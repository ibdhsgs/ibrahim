import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'order_tracker_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItemsMap = cart.cartItems;
    final pdtKeys = cartItemsMap.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("سلة المشتريات")),
      body: cartItemsMap.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text("السلة فارغة", style: TextStyle(fontSize: 20, color: Colors.grey)),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItemsMap.length,
              separatorBuilder: (c, i) => const Divider(),
              itemBuilder: (context, index) {
                final productId = pdtKeys[index];
                final quantity = cartItemsMap[productId]!;
                final product = cart.findById(productId);

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(product.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${product.price} ر.ي"),
                  trailing: SizedBox(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _iconButton(Icons.remove, () {
                          cart.removeSingleItem(productId);
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("$quantity", style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        _iconButton(Icons.add, () {
                          cart.addItem(productId);
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 5, blurRadius: 10)],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("الإجمالي", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("${cart.totalPrice.toStringAsFixed(0)} ر.ي", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OrderTrackerPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("تأكيد الطلب", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}