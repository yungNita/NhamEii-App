import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text(
        'Hello, there!!',
        style: TextStyle(
          color: Color(0XFF3E0061),
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
      actions: <Widget>[
        SvgPicture.asset('assets/icons/like.svg'),
        const SizedBox(width: 10),
        Image.asset('assets/images/notify.png', width: 25),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
