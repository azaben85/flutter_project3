import 'package:firebase_app/admin/models/product.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  Product product;
  ProductWidget(this.product);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 2)),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 170,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                  right: 15,
                  top: 10,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              // Provider.of<AdminProvider>(context,
                              //         listen: false)
                              //     .deleteCategory(product);
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              // Provider.of<AdminProvider>(context,
                              //         listen: false)
                              //     .loadForCategoryUpdate(product);
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    ],
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Product Name' + ': ' + product.nameEn,
                  ),
                  Text(
                    'Price: ' + product.price.toString(),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
