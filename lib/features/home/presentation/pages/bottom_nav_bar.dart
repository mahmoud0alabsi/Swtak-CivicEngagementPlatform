import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/municipality_suggestions/municipality_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/parliament_suggestions/parliament_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/suggestions_main_page.dart';
import 'package:citizens_voice_app/features/municipality/presentation/bloc/archived_projects/archived_projects_bloc.dart';
import 'package:citizens_voice_app/features/municipality/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
import 'package:citizens_voice_app/features/municipality/presentation/pages/municipalitie_main_page.dart';
import 'package:citizens_voice_app/features/parliament/presentation/bloc/ongoing_round/ongoing_round_bloc.dart';
import 'package:citizens_voice_app/features/parliament/presentation/pages/parliament_main_page.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:citizens_voice_app/theme/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home_page.dart';

class PagesWrapper extends StatefulWidget {
  const PagesWrapper({super.key});

  @override
  State<PagesWrapper> createState() => _PagesWrapperState();
}

class _PagesWrapperState extends State<PagesWrapper> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ================ Parliament Blocs ================
        BlocProvider(
          create: (context) => OngoingRoundBloc(),
          lazy: false,
        ),

        // ================ Municipality Blocs ================
        BlocProvider(
          create: (context) => OngoingProjectsBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ArchivedProjectsBloc(),
          lazy: false,
        ),

        // ================ Suggestions Blocs ================
        BlocProvider(
          create: (context) => ParliamentSuggestionsBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => MunicipalitySuggestionsBloc(),
          lazy: false,
        ),
      ],
      child: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const ParliamentMainPage(),
    const MunicipalityMainPage(),
    const Suggestionsscreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserManagerBloc, UserManagerState>(
      listener: (context, state) {
        if (state is UserManagerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is UserManagerLoading) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const LoadingSpinner(),
          );
        }

        if (context.read<UserManagerBloc>().user.uid == '') {
          context.read<UserManagerBloc>().add(LoadUserData());
        }

        return Scaffold(
          key: _scaffoldKey,
          body: pages[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Color.fromRGBO(7, 33, 58, 0.1),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: GNav(
                  curve: Curves.easeOutExpo,
                  rippleColor: const Color.fromRGBO(117, 194, 246, 1),
                  hoverColor: const Color.fromRGBO(117, 194, 246, 1),
                  haptic: true,
                  tabBorderRadius: 15,
                  gap: 3,
                  activeColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  duration: const Duration(milliseconds: 300),
                  tabBackgroundColor: Theme.of(context).colorScheme.primary,
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    GButton(
                      iconSize: 24,
                      icon: CustomIcons.home,
                      iconColor: Theme.of(context).colorScheme.secondary,
                      text: 'الرئيسية',
                    ),
                    GButton(
                      iconSize: 26,
                      icon: CustomIcons.parliament,
                      iconColor: Theme.of(context).colorScheme.secondary,
                      text: 'مجلس النواب',
                    ),
                    GButton(
                      iconSize: 22,
                      icon: CustomIcons.building,
                      iconColor: Theme.of(context).colorScheme.secondary,
                      text: 'مجلس البلدية',
                    ),
                    GButton(
                      iconSize: 24,
                      icon: CustomIcons.pulb,
                      iconColor: Theme.of(context).colorScheme.secondary,
                      text: 'المقترحات',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: _onItemTapped,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
