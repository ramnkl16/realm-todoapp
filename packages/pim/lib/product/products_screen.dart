import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posprovider/posDbProvider.dart';
import 'package:posprovider/product/product.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pos = ref.read(posDbProvider);
    int totalProducts = pos.realm.all<Product>().length;
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Column(
        children: [
          Text('Total Products $totalProducts'),
        ],
      ),
    );
  }
}
