import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muda_facil/firebase_options.dart';
import 'package:muda_facil/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAnalytics.instance.logAppOpen();
  runApp(ProviderScope(
    observers: [Logger()],
    child: const App(),
  ));
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    FirebaseAnalytics.instance.logEvent(
      name: 'state_changed',
      parameters: {"old": previousValue.toString(), "new": newValue.toString()},
    );

    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "${previousValue.toString()}"
  "newValue": "${newValue.toString()}"
}''');
  }
}
