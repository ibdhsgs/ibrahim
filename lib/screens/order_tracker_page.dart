import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class OrderTrackerPage extends StatefulWidget {
  const OrderTrackerPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackerPage> createState() => _OrderTrackerPageState();
}

class _OrderTrackerPageState extends State<OrderTrackerPage> {
  int _currentStep = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _currentStep = 2);
    });
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _currentStep = 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تتبع الطلب")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&w=800&q=80"),
                    fit: BoxFit.cover,
                    opacity: 0.6
                ),
              ),
              child: const Center(
                child: Icon(Icons.location_on, color: Colors.red, size: 50),
              ),
            ),
            const SizedBox(height: 30),
            const Text("وقت الوصول المتوقع", style: TextStyle(color: Colors.grey, fontSize: 16)),
            const Text("20 - 30 دقيقة", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: [
                  _buildTimelineTile("تم استلام الطلب", "نحن نجهز طلبك الآن", 1, true),
                  _buildTimelineTile("جاري التحضير", "الشيف يعمل على وجبتك", 2, _currentStep >= 1),
                  _buildTimelineTile("خرج للتوصيل", "السائق في الطريق إليك", 3, _currentStep >= 2),
                  _buildTimelineTile("تم التسليم", "استمتع بوجبتك!", 4, _currentStep >= 3),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).clearCart();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("العودة للرئيسية"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineTile(String title, String subtitle, int step, bool isActive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.red : Colors.grey[300],
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)]
              ),
            ),
            if (step != 4)
              Container(width: 2, height: 50, color: isActive ? Colors.red : Colors.grey[300]),
          ],
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isActive ? Colors.black : Colors.grey)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 30),
          ],
        )
      ],
    );
  }
}