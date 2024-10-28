import 'package:citizens_voice_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'صوت المواطن',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading spinner while waiting for auth state to be determined
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.phoneNumber.toString(),
                      );
                    }
                    return const Text(
                      'No phone number',
                    );
                  }),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthRepositoryImpl().logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primaryContainer, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 8,
                    shadowColor: Colors.black,
                  ),
                  child: Text(
                    'خروج',
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.surfaceContainer),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
