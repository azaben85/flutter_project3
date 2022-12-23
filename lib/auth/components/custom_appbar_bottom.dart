// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  Widget? bottomAppBar;
  Widget? title;
  CustomBottomAppBar({Key? key, this.title, this.bottomAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title!;
  }

  @override
  Size get preferredSize => Size(390.w, 40.h);
}
