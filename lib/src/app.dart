import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muda_facil/src/controllers/auth_controller.dart';
import 'package:muda_facil/src/screens/authenticated.dart';
import 'package:muda_facil/src/screens/error.dart';
import 'package:muda_facil/src/screens/login.dart';
import 'package:muda_facil/src/utils/constants.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authStreamProvider);

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      scaffoldMessengerKey: UIUtils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: FlexScheme.bahamaBlue,
        textTheme: GoogleFonts.montserratTextTheme(),
      ).copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 8.0,
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          iconSize: 36.0,
          splashColor: kPrimaryColor.withOpacity(0.4),
        ),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.blumineBlue,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      themeMode:
          ThemeMode.light, // FIXME: change this later to `ThemeMode.system`
      home: authController.when(
        loading: () => const LoadingAdaptive(),
        data: (data) {
          Future.delayed(const Duration(seconds: 2), () {
            FlutterNativeSplash.remove();
          });
          return data == null ? const LoginScreen() : const Authenticated();
        },
        error: (error, _) => ErrorScreen(error.toString()),
      ),
    );
  }
}
