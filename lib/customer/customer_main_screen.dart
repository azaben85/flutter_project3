import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/screens/components/car_displays_slider.dart';
import 'package:firebase_app/admin/views/screens/components/categories_slider.dart';
import 'package:firebase_app/auth/components/custom_label_value.dart';
import 'package:firebase_app/auth/components/custom_scaffold.dart';
import 'package:firebase_app/data_repository/uri_launcher_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<AdminProvider>(
        builder: (context, provider, child) {
          return ListView(
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
                        return InkWell(
                          onTap: () {
                            UrlLauncherHelper.urlLauncherHelper.openUrl(i.url);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(color: Colors.grey[50]),
                              child: Image.network(
                                i.imageURL,
                                fit: BoxFit.cover,
                              )),
                        );
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
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Icon(
                            Icons.circle,
                            size: 14,
                            color: Colors.green,
                          ),
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Icon(
                          Icons.circle,
                          size: 8,
                        ),
                      );
                    })),
              const SizedBox(
                height: 10,
              ),
              LabelValue('Cars:', '', 0),
              AllCarsSlider(),
              // SizedBox(
              //     height: 200,
              //     width: double.infinity,
              //     child: AllCategoriesSlider())
            ],
          );
        },
      ),
    );
  }
}
