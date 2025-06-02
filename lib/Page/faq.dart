import 'package:flutter/material.dart';

import '../components/backbutton.dart';
import '../components/background.dart';
import '../components/button.dart';
import '../components/faqquestion.dart';
import 'contactus.dart';

class Faqs extends StatelessWidget {
  final List<Map<String, String>> faqData = [
    {
      "question": "What is NhamEii?",
      "answer":
          "NhamEii provides personalized food recommendations based on user preferences. The app will suggest meals from restaurants. The app will use a rule-based approach, user inputs, and filtering techniques to offer the best food choices. Additionally, NhamEii will feature a Wheel Game, where users can spin a virtual wheel to randomly select a meal option when they are unsure what to eat, adding an element of fun and spontaneity to the experience.",
    },
    {
      "question": "How to register for an account?",
      "answer":
          "You can register using your email and a password through our sign-up screen.",
    },
    {
      "question": "Can we use NhamEii without an account?",
      "answer":
          "Yes, but personalized features like recommendations and the Wheel Game require signing in.",
    },
    {
      "question": "How can we get food recommendations?",
      "answer":
          "By answering short preference quizzes and letting NhamEii analyze your choices.",
    },
    {
      "question": "What can I do on NhamEii?",
      "answer":
          "You can explore food tips, get personalized suggestions, and spin the Wheel Game to decide meals.",
    },
    {
      "question": "How is my personal data protected?",
      "answer":
          "We use encryption and do not share your data with third parties. Your privacy is a top priority.",
    },
    {
      "question": "Why do we need to create account?",
      "answer":
          "Creating an account helps us tailor recommendations and store your preferences securely.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Background(
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
                  'FAQ',
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
                      'We’re here to help you with everything here on NhamEii',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'At NhamEii, we give you daily food tips for your wants and needs! We have got you covered, share your concerns or check our frequently asked questions below.',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 50),
                    ...faqData.map(
                      (faq) => FaqQuestion(
                        question: faq['question']!,
                        answer: faq['answer']!,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Still got questions?',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GradientButton(
                            text: 'Contact Us',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactUs(),
                                ),
                              );
                            },

                            width: 115,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
