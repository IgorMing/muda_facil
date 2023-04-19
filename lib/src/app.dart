import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muda_facil/src/providers/authentication.dart';
import 'package:muda_facil/src/screens/auth.dart';
import 'package:muda_facil/src/screens/bottom_navigation.dart';
import 'package:muda_facil/src/utils/ui.dart';
import 'package:muda_facil/src/widgets/loading_adaptive.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

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
      home: authState.when(
        loading: () => const LoadingAdaptive(),
        data: (data) =>
            data == null ? const AuthScreen() : const BottomNavigation(),
        error: (error, _) => Center(
          child: Text('Ops, um erro ocorreu\n. Erro: $error'),
        ),
      ),
    );
  }
}
