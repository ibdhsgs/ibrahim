import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/cart_provider.dart';
import 'screens/login_page.dart';
import 'screens/main_wrapper_page.dart';

void main() async {
  // 1. ضمان تهيئة الأدوات قبل تنفيذ أي كود غير متزامن
  WidgetsFlutterBinding.ensureInitialized();

  // 2. جلب البيانات المحفوظة
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // 3. تحديد الصفحة التي سيبدأ بها التطبيق فوراً
  final Widget startScreen = isLoggedIn ? const MainWrapperPage() : const LoginPage();

  // 4. تشغيل التطبيق وتمرير الصفحة المحددة
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(startScreen: startScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startScreen; // متغير لاستقبال الصفحة المحددة

  const MyApp({Key? key, required this.startScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مطعمك السريع',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black87),
          titleTextStyle: GoogleFonts.cairo(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      // هنا نضع الصفحة التي حددناها في main
      home: startScreen,
    );
  }
}