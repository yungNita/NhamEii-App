import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nhameii/components/backbutton.dart';
import 'package:nhameii/components/background.dart';
import 'package:nhameii/components/navigation_bar/nav_bar.dart';



class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    

    return Scaffold(body:  Background(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: BackButtonWidget(),
                ),
                Text(
                  'Contact Us',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How can we help?',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Got questions for us? Connect with us using our contact below! Give us a call, or leave an email. We’ll get back to you as soon as possible!',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Contact Details Section
                    const Divider(),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/phone.svg', width: 18),
                        const SizedBox(width: 10),
                        Text(
                          '+855 12 345 6789',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'nhameiioffice@company.com',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    bottomNavigationBar: NavBar(
        currentIndex: 0, 
        onTap: (index) {
        },
      ),
    );
  }
}
