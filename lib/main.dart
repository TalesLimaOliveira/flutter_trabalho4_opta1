import 'commons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppointmentController>(
          create: (_) => AppointmentController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      home: const LoginScreen() ,
      title: AppLabels.appName,

      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.primary,

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.text),
          bodyMedium: TextStyle(color: AppColors.text),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          toolbarHeight: 50,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
          ),
          titleTextStyle: TextStyle(
            color: AppColors.textButton,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: AppColors.textButton,
          ),
        ),

        listTileTheme: const ListTileThemeData(
          textColor: AppColors.text,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
          subtitleTextStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14.0,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonBG,
            foregroundColor: AppColors.textButton,
            fixedSize: const Size(175, 40),
          ),  
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.buttonBG,
          foregroundColor: AppColors.textButton,
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: AppColors.textButton,
            ).copyWith(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              //splashFactory: NoSplash.splashFactory,
            ),
        )
      ),
    );
  }
}
