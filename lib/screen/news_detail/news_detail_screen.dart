// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:task_news/res/app_strings.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);
  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  )),
            ),
            Positioned(
                top: 50,
                left: 7,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 24.0,
                  ),
                )),
            Positioned(
              bottom: 20,
              left: 10,
              child: Container(
                padding:
                    const EdgeInsets.only(right: 100, left: 10, bottom: 10),
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  title,
                  style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontFamily: AppStrings.openSansItalic),
                ),
              ),
            )
          ]),
          Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
              ))
        ],
      ),
    );
  }
}
