// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';

class FrequentlyAskedQuestions extends StatefulWidget {
  const FrequentlyAskedQuestions({Key? key}) : super(key: key);

  @override
  State<FrequentlyAskedQuestions> createState() =>
      _FrequentlyAskedQuestionsState();
}

class _FrequentlyAskedQuestionsState extends State<FrequentlyAskedQuestions> {
  int allticketquery = 0;
  int pendingticketquery = 0;
  int resolvedticketquery = 0;

  final List<FAQItem> faqItems = [];

  @override
  void initState() {
    super.initState();
    faqItems.add(FAQItem("All Tickets ($allticketquery)",
        "Your Tickets will be displayed here!"));
    faqItems.add(FAQItem("Pending Tickets ($pendingticketquery)",
        "Your Pending Tickets will be displayed here!"));
    faqItems.add(FAQItem("Resolved Tickets ($resolvedticketquery)",
        "Your Resolved Tickets will be displayed here!"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: BoldText(
            name: "Frequently Asked Questions",
            fontsize: 16,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(faqItems[index].question),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(faqItems[index].answer),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
              top: MediaQuery.sizeOf(context).height * 0.4,
              child: Container(
                  height: 40,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(199, 0, 0, 0),
                  ),
                  child: const Center(
                      child: Text(
                    "This Page is under Development",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )))),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem(this.question, this.answer);
}
