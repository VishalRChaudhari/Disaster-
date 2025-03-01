import 'package:disastermanagement/Providers/address_provider.dart';
import 'package:disastermanagement/Screens/splashsceen.dart';
import 'package:disastermanagement/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LocationProvider(),
    )
  ], child: const MyApp()));
}

const Color maincolor = Color(0xFFB2BEB5);
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: maincolor),
  brightness: Brightness.light,
  textTheme: GoogleFonts.poppinsTextTheme(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: SplashScreenn(),
    );
  }
}
