import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:citizens_voice_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:citizens_voice_app/features/auth/presentation/pages/welcome_page.dart';
import 'package:citizens_voice_app/features/home/presentation/pages/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class RouterPage extends StatefulWidget {
  const RouterPage({super.key});

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  @override
  Widget build(BuildContext context) {
    return const PagesWrapper();
    // return StreamBuilder<CustomUserEntity?>(
    //   stream: AuthRepositoryImpl().firebaseAuthCustomUserStream,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     }
    //     if (snapshot.data != null && snapshot.data!.uid.isNotEmpty) {
    //     return const PagesWrapper();
    //     }
    //     return const WelcomePage();
    //   },
    // );
  }
}
