import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitDoubleBounce(
      color: Theme.of(context).colorScheme.primary,
      size: 50.0,
    ));
  }
}
