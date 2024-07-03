
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/register_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/settings_provider.dart';
import 'package:todo_app/tabs/tasks/task_provider.dart';
import 'package:todo_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   //if you want to work offline 
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings=Settings(cacheSizeBytes:Settings.CACHE_SIZE_UNLIMITED );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_)=>UserProvider()),
      ],
      child:const  TodoApp(),
    ),
  );

  // runApp(ChangeNotifierProvider(
  //     create: (_) => SettingsProvider(), child: const TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsProvider.themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingsProvider.languageCode),
      routes: {
       
        LoginScreen.routeName:(_)=>const  LoginScreen(),
        RegisterScreen.registerroute:(_)=>RegisterScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(), 
        },
       initialRoute: LoginScreen.routeName,
    );
  }
}
