import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/home/presentation/widgets/banner_widget.dart';
import 'package:citizens_voice_app/features/home/presentation/widgets/carousel_with_dots.dart';
import 'package:citizens_voice_app/features/home/presentation/widgets/contributions_card.dart';
import 'package:citizens_voice_app/features/home/presentation/widgets/countd.dart';
import 'package:citizens_voice_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:citizens_voice_app/features/settings/presentation/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الرئيسية',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          SizedBox(
            width: 40,
            height: 40,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/notfi.svg',
                height: 20,
                width: 20,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsPage(),
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
                'assets/icons/profile.svg',
                height: 20,
                width: 20,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.read<UserManagerBloc>().state
                              is UserManagerLoading
                          ? Skeletonizer(
                              enabled: true,
                              child: Text(
                                'Loading..................',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Text(
                              'أهلا بك، ${context.read<UserManagerBloc>().user.fullName.split(' ')[0]}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      // Text(
                      //   'أهلا بك، ${context.read<UserManagerBloc>().user.fullName.split(' ')[0]}',
                      //   style: TextStyle(
                      //     color: Theme.of(context).colorScheme.primary,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      const SizedBox(height: 16),
                      const Contributions(),
                      const SizedBox(height: 16),
                      const Bannerofimage(),
                      const SizedBox(height: 16),
                      Text(
                        'مجلس النواب ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Count1(
                        context: context,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'مجلس البلدية ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ]),
              ),
              const CarouselWithDots(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
