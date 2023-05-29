import 'package:flutter/material.dart';
import 'package:stalkin/models/news.dart';
import 'package:stalkin/theme.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 250,
          width: 325,
          color: whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                news.imageUrl,
                height: 130,
                width: 325,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  news.title,
                  style: regularPoppins.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 325,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                  ),
                  child: Text(
                    'Baca Selengkapnya',
                    style: semiPoppins.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}