import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stalkin/models/news.dart';
import 'package:stalkin/models/topic.dart';
import 'package:stalkin/widgets/news_card.dart';
import 'package:stalkin/widgets/title.dart';
import 'package:stalkin/widgets/topic_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  Future<List<dynamic>> fetchNews() async {
    final response = await http
        .get(Uri.parse('https://berita-indo-api.vercel.app/v1/cnn-news'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> news = data['data'];
      return news;
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: whiteColor,
            elevation: 2,
            pinned: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            toolbarHeight: 70, // Adjust the desired height here
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns the text vertically at the center
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Home',
                        style: semiPoppins.copyWith(
                            fontSize: 24, color: mainColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: const MyTitle(title: 'Berita'),
                  ),
                ],
              ),
              FutureBuilder<List<dynamic>>(
                future: fetchNews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: 50,
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white,
                                    child: Container(
                                      height: 250,
                                      width: 325,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final List<dynamic> news = snapshot.data!;
                    return SizedBox(
                      width: 50,
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            final newsItem = news[index];
                            return Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SizedBox(
                                    child: NewsCard(
                                      News(
                                        idData: index + 1,
                                        title: newsItem['title'],
                                        imageUrl: newsItem['image']['small'],
                                        linkUrl: newsItem['link'],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: const MyTitle(title: 'Topik'),
                  ),
                ],
              ),

              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Topic').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final topics = snapshot.data?.docs.map((doc) {
                      final String id = doc.id;
                      final String name = doc['name'];
                      return Topic(idTopic: id, name: name);
                    }).toList();
                    if (topics != null) {
                      return Column(
                        children:
                            topics.map((topic) => TopicCard(topic)).toList(),
                      );
                    }
                  }
                  return const SizedBox(); // Return an empty widget if there's no data
                },
              ),

              // Add your remaining ListView children here
            ]),
          ),
        ],
      ),
    );
  }
}
