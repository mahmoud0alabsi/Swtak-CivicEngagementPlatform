import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/parliament_suggestions/parliament_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/SuggestionCards.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySuggestions extends StatefulWidget {
  final ParliamentSuggestionsBloc parliamentSuggestionsBloc;
  const MySuggestions({super.key, required this.parliamentSuggestionsBloc});

  @override
  MySuggestionsPageState createState() => MySuggestionsPageState();
}

class MySuggestionsPageState extends State<MySuggestions> {
  late ParliamentSuggestionsBloc parliamentSuggestionsBloc;
  int currentIndex = 0;
  final int maxCards = 3;
  final List<Map<String, dynamic>> suggestions = [
    {
      'title': 'اصلاح خط مياه',
      'description':
          'تُعتبر مشكلة تسرب المياه من خطوط المياه من القضايا الحيوية التي تؤثر على حياة المواطنين اليومية. عند وجود تسرب أو كسر في خط المياه، يتسبب ذلك في هدر كبير للمياه، مما يؤدي إلى نقص الإمدادات في المناطق المجاورة وظهور مشاكل صحية نتيجة تلوث المياه. لذلك، يتعين على البلدية التدخل بشكل سريع لمعالجة هذه المشكلة',
    },
    {
      'title': 'بناء مدرسة',
      'description':
          'تلبيةً لاحتياجات المجتمع، يطالب المواطنون البلدية ببدء مشروع بناء مدرسة جديدة، حيث ستساهم هذه المدرسة في تخفيف الضغط على المدارس القائمة وتوفير بيئة تعليمية آمنة ومجهزة. يجب أن تكون المدرسة مجهزة بكافة المرافق اللازمة، مثل الفصول الدراسية، المكتبة، وملاعب الأطفال، مما يوفر للطلاب تجربة تعليمية شاملة. إن الاستثمار في التعليم هو استثمار في مستقبل الأجيال القادمة، ولذلك يعد بناء مدرسة جديدة خطوة حيوية نحو تحقيق تنمية مستدامة في المنطقة.',
    },
  ];

  @override
  void initState() {
    super.initState();
    parliamentSuggestionsBloc = widget.parliamentSuggestionsBloc;
  }

  @override
  Widget build(BuildContext context) {
    int totalSuggestions = suggestions.length;
    int displayedCount = (currentIndex + maxCards <= totalSuggestions)
        ? maxCards
        : totalSuggestions - currentIndex;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ParliamentSuggestionsBloc>.value(
            value: parliamentSuggestionsBloc),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: appBar(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0.0,
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          "مجلس النواب",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.primary),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder(
                  bloc: parliamentSuggestionsBloc,
                  builder: (context, state) {
                    parliamentSuggestionsBloc.add(GetMySuggestions(
                      context.read<UserManagerBloc>().user.uid,
                    ));

                    if (state is ParliamentMySuggestionsLoading) {
                      return const LoadingSpinner();
                    }

                    if (parliamentSuggestionsBloc.mySuggestions.isEmpty) {
                      return const Center(
                        child: Text('لا توجد مقترحات'),
                      );
                    }

                    return Column(
                      children: [
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemCount:
                                parliamentSuggestionsBloc.mySuggestions.length,
                            itemBuilder: (context, index) {
                              return SuggestionCard(
                                bloc: parliamentSuggestionsBloc,
                                suggestion: parliamentSuggestionsBloc
                                    .mySuggestions[index],
                              );
                            }),
                        const SizedBox(height: 16),
                        Text(
                          '${parliamentSuggestionsBloc.mySuggestions.length}/$maxCards',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0.0,
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          "مجلس البلدية",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.primary),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined,
            color: Theme.of(context).colorScheme.primary),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'مقترحاتي',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
    );
  }
}
