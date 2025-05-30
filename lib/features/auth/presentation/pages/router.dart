import 'package:citizens_voice_app/features/home/presentation/pages/bottom_nav_bar.dart';
import 'package:citizens_voice_app/features/onboarding/onboarding_screens.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RouterPage extends StatefulWidget {
  const RouterPage({super.key});

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  @override
  Widget build(BuildContext context) {
    // return const OnboardingScreens();
    // return const PagesWrapper();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // AuthRepositoryImpl().firebaseAuthCustomUserStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: LoadingSpinner(),
          );
        }
        if (snapshot.data != null && snapshot.data!.uid.isNotEmpty) {
          return const PagesWrapper();
        }
        return const OnboardingScreens();
      },
    );
  }
}
