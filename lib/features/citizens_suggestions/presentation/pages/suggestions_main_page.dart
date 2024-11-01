import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/municipality_suggestions/municipality_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/parliament_suggestions/parliament_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/tabs/municipality_tab.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/new_suggestion.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/my_suggestions.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/tabs/parliament_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Suggestionsscreen extends StatefulWidget {
  const Suggestionsscreen({super.key});

  @override
  State<Suggestionsscreen> createState() => SuggestionsscreenState();
}

class SuggestionsscreenState extends State<Suggestionsscreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: TabBar(
                controller: _tabController,
                dividerHeight: 0,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: MaterialDesignIndicator(
                  indicatorHeight: 4,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                ),
                tabs: const [
                  Tab(
                    child: Text(
                      'النواب',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'البلدية',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: buildParliamentTab(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: buildMunicipalityTab(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    ParliamentSuggestionsBloc parliamentSuggestionsBloc =
        context.read<ParliamentSuggestionsBloc>();
    MunicipalitySuggestionsBloc municipalitySuggestionsBloc =
        context.read<MunicipalitySuggestionsBloc>();
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MySuggestions(
                        parliamentSuggestionsBloc: parliamentSuggestionsBloc,
                        municipalitySuggestionsBloc:
                            municipalitySuggestionsBloc,
                      ),
                    ),
                  );
                },
                child:
                    // Icon(
                    //   Icons.history_rounded,
                    //   size: 25,
                    //   color: Theme.of(context).colorScheme.primary,
                    // ),
                    SvgPicture.asset(
                  'assets/icons/s1.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              // const SizedBox(width: 16),
              // GestureDetector(
              //   onTap: () {},
              //   child: SvgPicture.asset(
              //     'assets/icons/s4.svg',
              //     width: 20,
              //     height: 20,
              //   ),
              // ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewSuggestion(
                        parliamentSuggestionsBloc: parliamentSuggestionsBloc,
                        municipalitySuggestionsBloc:
                            municipalitySuggestionsBloc,
                      ),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/s3.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ],
      title: Text(
        "اقتراحات المواطنين",
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}

class MaterialDesignIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  const MaterialDesignIndicator({
    required this.indicatorHeight,
    required this.indicatorColor,
  });

  @override
  MaterialDesignPainter createBoxPainter([VoidCallback? onChanged]) {
    return MaterialDesignPainter(this, onChanged);
  }
}

class MaterialDesignPainter extends BoxPainter {
  final MaterialDesignIndicator decoration;

  MaterialDesignPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Rect rect = Offset(
          offset.dx,
          configuration.size!.height - decoration.indicatorHeight,
        ) &
        Size(configuration.size!.width, decoration.indicatorHeight);

    final Paint paint = Paint()
      ..color = decoration.indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topRight: const Radius.circular(8),
        topLeft: const Radius.circular(8),
      ),
      paint,
    );
  }
}
