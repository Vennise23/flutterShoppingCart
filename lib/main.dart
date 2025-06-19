import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/cart_viewmodel.dart';
import 'views/cart_view.dart';
import 'models/cart_item.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartViewModel(),
      child: MaterialApp(
        title: 'MVVM Cart',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeWrapper(),
      ),
    );
  }
}

class HomeWrapper extends StatelessWidget {
  HomeWrapper({super.key});

  final List<CartItem> items = [
    CartItem(
      id: '1',
      title: 'Chocolate Tiramisu 🍰',
      price: 8.00,
      imageUrl: 'assets/images/food1.jpg',
    ),
    CartItem(
      id: '2',
      title: 'Mille Feuille ✨',
      price: 9.00,
      imageUrl: 'assets/images/food2.jpg',
    ),
    CartItem(
      id: '3',
      title: 'Chocolate Roll Cake 🍫🍰',
      price: 5.00,
      imageUrl: 'assets/images/food3.jpg',
    ),
    CartItem(
      id: '4',
      title: 'Tiramisu-Style Tartlets🍰☕✨',
      price: 7.00,
      imageUrl: 'assets/images/food4.jpg',
    ),
    CartItem(
      id: '5',
      title: 'No-Bake Cheesecake Balls 🧀🍡',
      price: 5.00,
      imageUrl: 'assets/images/food5.jpg',
    ),
    CartItem(
      id: '6',
      title: 'Brownie Cheesecake Parfait 🍫🍰',
      price: 5.00,
      imageUrl: 'assets/images/food6.jpg',
    ),
    CartItem(
      id: '7',
      title: 'Pomegranate & Mint Cheesecake Domes 🍰🍀',
      price: 3.00,
      imageUrl: 'assets/images/food7.jpg',
    ),
  ];

  final List<Color> colors = [
    const Color.fromARGB(255, 255, 234, 234),
    const Color.fromARGB(255, 255, 234, 189),
    const Color.fromARGB(255, 244, 255, 197),
    const Color.fromARGB(255, 197, 255, 197),
    const Color.fromARGB(255, 214, 248, 255),
    const Color.fromARGB(255, 225, 225, 255),
    const Color.fromARGB(255, 255, 218, 255),
    const Color.fromARGB(255, 255, 221, 221),
  ];

  final Random random = Random();

  Color darken(Color color, [double amount = .2]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('GOODIES MENU')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: double.infinity,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: items.map((item) {
              final bgColor = colors[random.nextInt(colors.length)];
              final priceColor = darken(bgColor, 0.7);

              return SizedBox(
                width: 300, // Fixed width for each card
                child: Card(
                  color: bgColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.imageUrl!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${item.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: priceColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      197,
                                      132,
                                      253,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    cart.addItem(item);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${item.title} added to cart',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => CartView()));
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
