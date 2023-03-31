import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muda_facil/src/screens/auth.dart';
import 'package:muda_facil/src/screens/bottom_navigation.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';
import 'package:muda_facil/src/utils/ui.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: FlexColor.bahamaBlueDarkPrimaryContainer,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.blumineBlue,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      themeMode:
          ThemeMode.light, // FIXME: change this later to `ThemeMode.system`
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingAdaptive();
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }

          if (snapshot.hasData) {
            return const BottomNavigation();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
