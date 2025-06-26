import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Page/account_section/notification_page.dart';
import '../../Page/account_section/wishlist_page.dart';
// import 'package:nhameii/Page/account_section/notification_page.dart';
// import 'package:nhameii/Page/account_section/wishlist_page.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: const Text(
        'Hello, there!!',
        style: TextStyle(
          color: Color(0XFF3E0061),
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WishlistPage(wishlistItems: []),
              ), 
            );
          },
          child: SvgPicture.asset('assets/icons/like.svg'),
        ),
        const SizedBox(width: 10),

        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationPage(),
              ), 
            );
          },
          child: Image.asset('assets/images/notify.png', width: 25),
          
        ),

        const SizedBox(width: 25),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
