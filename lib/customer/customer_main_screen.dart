import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/main_admin_screen.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CustomerMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              AppRouter.appRouter.push(const MainAdminScreen());
            },
          )
        ],
      ),
      body: Consumer<AdminProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              if (provider.allSliders != null)
                CarouselSlider(
                  options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        provider.setSliderIndex(index);
                      },
                      height: 250.0,
                      autoPlay: true,
                      viewportFraction: 1),
                  items: provider.allSliders!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration:
                                const BoxDecoration(color: Colors.amber),
                            child: Image.network(
                              i.url,
                              fit: BoxFit.cover,
                            ));
                      },
                    );
                  }).toList(),
                ),
              const SizedBox(
                height: 10,
              ),
              if (provider.allSliders != null)
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(provider.allSliders!.length, (index) {
                      if (provider.sliderIndex == index) {
                        return const Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Icon(
                            Icons.circle,
                            size: 14,
                            color: Colors.green,
                          ),
                        );
                      }
                      return const Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Icon(
                          Icons.circle,
                          size: 8,
                        ),
                      );
                    }))
            ],
          );
        },
      ),
    );
  }
}
