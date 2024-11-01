import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/municipality_suggestions/municipality_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/parliament_suggestions/parliament_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/widgets/municipality_suggestion_cards.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/widgets/suggestion_cards.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySuggestions extends StatefulWidget {
  final ParliamentSuggestionsBloc parliamentSuggestionsBloc;
  final MunicipalitySuggestionsBloc municipalitySuggestionsBloc;
  const MySuggestions({
    super.key,
    required this.parliamentSuggestionsBloc,
    required this.municipalitySuggestionsBloc,
  });

  @override
  MySuggestionsPageState createState() => MySuggestionsPageState();
}

class MySuggestionsPageState extends State<MySuggestions> {
  late ParliamentSuggestionsBloc parliamentSuggestionsBloc;
  late MunicipalitySuggestionsBloc municipalitySuggestionsBloc;

  int currentIndex = 0;
  final int maxCards = 3;

  @override
  void initState() {
    super.initState();
    parliamentSuggestionsBloc = widget.parliamentSuggestionsBloc;
    municipalitySuggestionsBloc = widget.municipalitySuggestionsBloc;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ParliamentSuggestionsBloc>.value(
            value: parliamentSuggestionsBloc),
        BlocProvider<MunicipalitySuggestionsBloc>.value(
            value: municipalitySuggestionsBloc),
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
                const SizedBox(height: 10),
                Divider(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  thickness: 1,
                ),
                const SizedBox(height: 10),
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
                BlocBuilder(
                  bloc: municipalitySuggestionsBloc,
                  builder: (context, state) {
                    municipalitySuggestionsBloc
                        .add(GetMyMunicipalitySuggestions(
                      context.read<UserManagerBloc>().user.uid,
                    ));

                    if (state is MunicipalityMySuggestionsLoading) {
                      return const LoadingSpinner();
                    }

                    if (municipalitySuggestionsBloc.mySuggestions.isEmpty) {
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
                            itemCount: municipalitySuggestionsBloc
                                .mySuggestions.length,
                            itemBuilder: (context, index) {
                              return MunicipalitySuggestionCard(
                                bloc: municipalitySuggestionsBloc,
                                suggestion: municipalitySuggestionsBloc
                                    .mySuggestions[index],
                              );
                            }),
                        const SizedBox(height: 16),
                        Text(
                          '${municipalitySuggestionsBloc.mySuggestions.length}/$maxCards',
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
