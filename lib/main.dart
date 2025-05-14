import 'package:citizens_voice_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/auth/presentation/pages/router.dart';
import 'package:citizens_voice_app/firebase_options.dart';
import 'package:citizens_voice_app/generated/l10n.dart';
import 'package:citizens_voice_app/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'theme/dark_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OtpBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        // BlocProvider(
        //   create: (context) => RegistrationBloc(),
        // ),
        BlocProvider(
          create: (context) => UserManagerBloc(),
        ),
      ],
      child: const MyApp(),
      // child: DevicePreview(
      //   enabled: true,
      //   builder: (context) => const MyApp(),
      // ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'صوتك',
      // ================ Don't touch this code please ================
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: const RouterPage(),
      // const MainPage(),
      // ================================================
    );
  }
}

// ====================== Start play from here ======================

//                          *****     *****
//                         *******   *******
//                        ********* *********
//                        *******************
//                         *****************
//                          ***************
//                           *************
//                            ***********
//                             *********
//                              *******
//                               *****
//                                ***
//                                 *
