import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/municipality_suggestions/municipality_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/parliament_suggestions/parliament_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/ai_analysis_page.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AiAnalysisPage(
                type: _tabController.index == 0 ? 'parliament' : 'municipality',
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        elevation: 8,
        child: const SubtleBounceText(),
        // Text(
        //   'AI',
        //   style: TextStyle(
        //     color: Theme.of(context).colorScheme.primary,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20,
        //   ),
        // ),
        // Image.asset(
        //   'assets/images/ai_loading.gif',
        //   width: 40,
        //   height: 40,
        //   color: Theme.of(context).colorScheme.primary,
        // ),
      ),
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
      title: Text(
        "اقتراحات المواطنين",
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.end,
      ),
      actions: [
        SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/s1.svg',
              height: 20,
              width: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MySuggestions(
                    parliamentSuggestionsBloc: parliamentSuggestionsBloc,
                    municipalitySuggestionsBloc: municipalitySuggestionsBloc,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/s3.svg',
              height: 20,
              width: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewSuggestion(
                    parliamentSuggestionsBloc: parliamentSuggestionsBloc,
                    municipalitySuggestionsBloc: municipalitySuggestionsBloc,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
      ],
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

class SubtleBounceText extends StatefulWidget {
  const SubtleBounceText({super.key});

  @override
  _SubtleBounceTextState createState() => _SubtleBounceTextState();
}

class _SubtleBounceTextState extends State<SubtleBounceText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Define a subtle scaling animation
    _animation = Tween<double>(begin: 0, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Listen for animation status to add a delay after each bounce
    _controller.addStatusListener((status) async {
      try {
        if (status == AnimationStatus.completed) {
          await Future.delayed(const Duration(seconds: 2)); // Add delay
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          await Future.delayed(const Duration(milliseconds: 0)); // Add delay
          _controller.forward();
        }
      } catch (e) {}
    });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value), // Apply vertical bounce effect
          child: Text(
            'AI',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              shadows: [
                Shadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  offset: const Offset(0, 1),
                  blurRadius: 6,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
