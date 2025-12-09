import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_wrapper_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // حفظ البيانات
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', _nameController.text);
      await prefs.setString('userPhone', _phoneController.text);

      if (!mounted) return;

      // الانتقال للرئيسية وحذف صفحة الدخول من الذاكرة
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainWrapperPage()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain, // عرض الصورة بالكامل
                        errorBuilder: (context, error, stackTrace) {
                          // في حال لم يتم العثور على الصورة، تظهر أيقونة مؤقتة
                          return const Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
                        },
                      ),
                    ),
                  ),
                ),
                // ------------------------------------

                const SizedBox(height: 20),
                Text(
                    "مطعم السعادة",
                    style: GoogleFonts.cairo(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF800000), // <-- عنابي
                    )
                ),

                // حقل الاسم
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "الاسم الكامل",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'الرجاء إدخال الاسم';
                    if (value.length < 3) return 'الاسم قصير جداً';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // حقل الرقم
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 9,
                  decoration: InputDecoration(
                    labelText: "رقم الهاتف",
                    prefixIcon: const Icon(Icons.phone_android),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "7xxxxxxxx",
                    counterText: "",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'الرجاء إدخال الرقم';
                    if (value.length != 9) return 'الرقم يجب أن يتكون من 9 أرقام';
                    if (!value.startsWith('7')) return 'الرقم يجب أن يبدأ بـ 7';
                    if (int.tryParse(value) == null) return 'أرقام فقط';
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("تسجيل الدخول", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}