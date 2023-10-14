import 'package:firebase_app/admin/models/product.dart';
import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  Product product;
  bool edit;
  ProductWidget(this.product, {this.edit = false, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: List.filled(1, const BoxShadow(color: Colors.grey)),
      ),
      //border: Border.all(color: Colors.black, width: 2)),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(product.imageUrl)),
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
          Text(
            product.nameEn,
          ),
          Text(
            '\$${product.price}',
          ),
          if (!edit)
            InkWell(
              child: const Text("اضف الى السلة"),
              onTap: () {
                Provider.of<OrderProvider>(context, listen: false)
                    .addItem(product, "cat");
              },
            ),
          if (edit)
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Provider.of<AdminProvider>(context, listen: false)
                          .deleteProduct(product);
                    },
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      Provider.of<AdminProvider>(context, listen: false)
                          .loadProductForUpdate(product);
                    },
                    icon: const Icon(Icons.edit)),
              ],
            )
        ],
      ),
    );
  }
}
