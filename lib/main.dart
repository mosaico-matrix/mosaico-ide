import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mosaico_flutter_core/core/exceptions/exception_handler.dart';
import 'package:mosaico_flutter_core/core/configuration/app_color_scheme.dart';
import 'package:mosaico_flutter_core/core/utils/toaster.dart';
import 'package:toastification/toastification.dart';
import 'features/welcome/presentation/pages/welcome_page.dart';

void main() {
  runZonedGuarded(() {
    runApp(const ToastificationWrapper(child: App()));
  }, (error, stackTrace) {
    handleException(error, stackTrace);
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    Toaster.setAlignment(Alignment.bottomLeft);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Dotted',
        colorScheme: AppColorScheme.getDefaultColorScheme(),
      ),
      home: Builder(
        builder: (context) =>  const WelcomePage(),
      ),
    );
  }
}

