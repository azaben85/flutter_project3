import 'package:firebase_app/admin/models/category.dart';
import 'package:flutter/material.dart';

class CategorySmallIconWidget extends StatelessWidget {
  Category category;
  bool selected = false;
  CategorySmallIconWidget(this.category, this.selected, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: selected ? Border.all(color: Colors.green, width: 2) : null),
      child: SizedBox(
        width: 180,
        height: 60,
        child: Center(
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(category.imageUrl)),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15)),
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    category.nameEn,
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
