import 'package:chat_gpt_sdk/chat_gpt_sdk.dart' as gpt;

import 'package:citizens_voice_app/features/citizens_suggestions/data/models/municipality_suggestion_model.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/business/repositories/ai_suggestions_repository.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/datasources/remote_municipality_suggestions_data.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/datasources/remote_parliament_suggestions_data.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/models/suggestion_model.dart';

class AISuggestionsRepoImpl implements IAISuggestionsRepo {
  RemoteParliamentSuggestionsData remoteParliamentSuggestionsData =
      RemoteParliamentSuggestionsData();
  RemoteMunicipalitySuggestionsData remoteMunicipalitySuggestionsData =
      RemoteMunicipalitySuggestionsData();

  final String _apiKey =
      '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';

  // Singleton
  static final AISuggestionsRepoImpl _instance =
      AISuggestionsRepoImpl._internal();

  factory AISuggestionsRepoImpl() => _instance;

  AISuggestionsRepoImpl._internal();

  @override
  Future<String> getAISuggestion(String type) async {
    try {
      String field = type == 'parliament' ? 'البرلمان' : 'البلدية';
      // prompt AI to suggest
      String aiPrompt =
          """لدي مجموعة من الاقتراحات من المواطنين حول مواضيع مختلفة، حيث يحتوي كل اقتراح على عنوان، تفاصيل، وعدد الأصوات المؤيدة لهذا الاقتراح. أريد منك تحليل هذه الاقتراحات لتحديد الاتجاه العام للأفكار الأكثر شيوعاً والشعبية بين المواطنين. ركّز في التحليل على عدد الأصوات المؤيدة لكل اقتراح، وحاول تحديد النمط أو الموضوع المتكرر الذي يحظى بتأييد واسع. قدم لي ملخصاً يوضح الفكرة الرئيسية التي اتفق عليها غالبية المواطنين بناءً على هذا التحليل.
      لا تقم بذكر عنوان او عدد الإصوات المؤيدة لأي من الإقتراحات في التحليل، فقط اذكر الأفكار والمجالات وتحليلك لذلك.
      قم بتقديم نصائح للمواطنين ليعملوا عليها، ونصائح للجهات المعنية.
      قم بترتيب النص واستخدام عناوين واضحة في الرد، يجب ان يكون الرد على شكل HTML tags without main tags (such as <!DOCTYPE html>, <html>, <head>, <body>) use headers and paragraphs only.
      يجب ان يكون العنوان دائماً هو (ملخص اقتراحات المواطنين - $field).
      الاقتراحات:
      """;

      String allSuggestions = '';
      if (type == 'parliament') {
        // get text (suggestions) from parliament
        List<SuggestionModel> sugestions =
            await remoteParliamentSuggestionsData.getAllParliamentSuggestions();

        sugestions.sort((a, b) => b.upvotesCount.compareTo(a.upvotesCount));

        // get first 10 suggestions
        sugestions = sugestions.sublist(
            0, sugestions.length > 10 ? 10 : sugestions.length);

        // get (title, details and upvotesCount) from suggestions
        List<String> suggestionsText = sugestions.map((e) => """
            \n- **العنوان**: ${e.title}
              **التفاصيل**: ${e.details}
              **عدد الأصوات المؤيدة**: ${e.upvotesCount}
          """).toList();
        allSuggestions = suggestionsText.join('\n\n');
      } else {
        // get text (suggestions) from municipality
        List<MunicipalitySuggestionModel> sugestions =
            await remoteMunicipalitySuggestionsData
                .getAllMunicipalitySuggestions();

        sugestions.sort((a, b) => b.upvotesCount.compareTo(a.upvotesCount));

        // get first 10 suggestions
        sugestions = sugestions.sublist(
            0, sugestions.length > 10 ? 10 : sugestions.length);

        // get (title, details and upvotesCount) from suggestions
        List<String> suggestionsText = sugestions.map((e) => """
            \n- **العنوان**: ${e.title}
              **التفاصيل**: ${e.details}
              **عدد الأصوات المؤيدة**: ${e.upvotesCount}
          """).toList();
        allSuggestions = suggestionsText.join('\n\n');
      }

      String model = 'gpt-3.5-turbo-0125';
      String prompt = '$aiPrompt\n$allSuggestions';

      final openAI = gpt.OpenAI.instance.build(
        token: _apiKey,
        baseOption: gpt.HttpSetup(
          receiveTimeout: const Duration(seconds: 30),
        ),
        enableLog: false,
      );

      final request = gpt.ChatCompleteText(
        model: gpt.ChatModelFromValue(model: model),
        messages: [
          {
            "role": "system",
            "content":
                "أنت مساعد مفيد يقوم بتحليل الاقتراحات ويحدد الاتجاه العام بين المواطنين. أجب باللغة العربية.",
          },
          {
            "role": "user",
            "content": prompt,
          }
        ],
        maxToken: 2000,
        temperature: 0.5,
      );

      final response = await openAI.onChatCompletion(request: request);

      return response!.choices[0].message?.content ?? '';
    } catch (e) {
      throw Exception(e);
    }
  }
}
