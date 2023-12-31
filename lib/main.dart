import 'package:doc_saver_app/firebase_options.dart';
import 'package:doc_saver_app/provider/auth_provider.dart';
import 'package:doc_saver_app/provider/document_provider.dart';
import 'package:doc_saver_app/provider/user_info_provider.dart';
import 'package:doc_saver_app/screens/add_document_screen.dart';
import 'package:doc_saver_app/screens/authentication_screen.dart';
import 'package:doc_saver_app/screens/document_view_screen.dart';
import 'package:doc_saver_app/screens/forgot_password_screen.dart';
import 'package:doc_saver_app/screens/home_screen.dart';
import 'package:doc_saver_app/screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserInfoProvider>(create: (_)=> UserInfoProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<DocumentProvider>(create: (_) => DocumentProvider()),
      ],
      child: DynamicColorBuilder(
        builder: (lightColorScheme, darkColorScheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
            ),
            themeMode: ThemeMode.system,
            initialRoute: AuthenticationScreen.routeName,
            routes: {
              AuthenticationScreen.routeName: (context) =>
                  const AuthenticationScreen(),
              ForgotPasswordScreen.routeName: (context) =>
                  const ForgotPasswordScreen(),
              MyHomePage.routeName: (context) => const MyHomePage(),
              AddDocumentScreen.routeName: (context) => const AddDocumentScreen(),
              DocumentViewScreen.routeName: (context) => DocumentViewScreen(),
              SettingsScreen.routeName: (context) => SettingsScreen()
            },
          );
        },
      ),
    );
  }
}
