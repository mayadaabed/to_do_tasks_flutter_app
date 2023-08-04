import 'package:flutter/material.dart';

import '../../style/colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MainAppBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, -3),
                    blurRadius: 10),
              ],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              border: Border.all(color: white),
              color: mainColor),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: white),
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
