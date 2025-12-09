import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // استيراد المكتبة
import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String userName = "زائر";
  String userPhone = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // جلب البيانات المحفوظة
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? "زائر";
      userPhone = prefs.getString('userPhone') ?? "";
    });
  }

  // دالة تسجيل الخروج
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // مسح البيانات

    if (!mounted) return;

    // العودة لصفحة الدخول وحذف كل الصفحات السابقة من الذاكرة
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (c) => const LoginPage()),
          (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الإعدادات")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.red,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 10),
          // عرض الاسم المحفوظ
          Center(child: Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          // عرض الرقم المحفوظ
          Center(child: Text(userPhone, style: const TextStyle(color: Colors.grey))),

          const SizedBox(height: 30),

          _settingsTile(Icons.person_outline, "تعديل الملف الشخصي", () {}),
          _settingsTile(Icons.notifications_outlined, "الإشعارات", () {}),
          _settingsTile(Icons.language, "اللغة", () {}),
          const Divider(),
          _settingsTile(Icons.logout, "تسجيل الخروج", _logout, color: Colors.red),
        ],
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title, VoidCallback onTap, {Color color = Colors.black87}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}