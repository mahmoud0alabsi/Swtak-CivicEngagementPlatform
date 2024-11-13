import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/ai_analysis/ai_analysis_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AiAnalysisPage extends StatefulWidget {
  final String type;
  const AiAnalysisPage({
    super.key,
    required this.type,
  });

  @override
  AiAnalysisPagePageState createState() => AiAnalysisPagePageState();
}

class AiAnalysisPagePageState extends State<AiAnalysisPage> {
  late String type;

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AiAnalysisBloc>(
          create: (context) => AiAnalysisBloc(
            type: type,
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: appBar(context),
        body: BlocBuilder<AiAnalysisBloc, AiAnalysisState>(
          builder: (context, state) {
            if (state is AiAnalysisLoading) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/ai_loading.gif',
                      width: 175,
                      height: 175,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              );
            } else if (state is AiAnalysisLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Opacity(
                        //   opacity: 0.05,
                        //   child: Image.asset(
                        //     'assets/images/ai_loading.gif',
                        //     width: 200,
                        //     height: 200,
                        //     color: Theme.of(context).colorScheme.primary,
                        //   ),
                        // ),
                        HtmlWidget(
                          state.aiSuggestion,
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        // Text(
                        //   state.aiSuggestion,
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w400,
                        //     color: Theme.of(context).colorScheme.secondary,
                        //   ),
                        //   textAlign: TextAlign.start,
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: Center(
                    child: Text(
                      'اطلع على تحليل الذكاء الاصطناعي للإقتراحات الرائجة',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
          },
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
        'تحليل الذكاء الاصطناعي',
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
