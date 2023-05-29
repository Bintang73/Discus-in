import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stalkin/models/news.dart';
import 'package:stalkin/models/question.dart';
import 'package:stalkin/widgets/news_card.dart';
import 'package:stalkin/widgets/question_card.dart';

import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: CustomScrollView(
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
                background: Column(
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
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 38),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Berita',
                    style:
                        semiPoppins.copyWith(fontSize: 24, color: whiteColor),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 32,
                      ),
                      NewsCard(
                        News(
                            idData: 1,
                            title:
                                'Puan Bertemu Gibran di Solo, Jalan-jalan di Mal hingga Makan Malam',
                            imageUrl:
                                'https://akcdn.detik.net.id/visual/2023/05/27/puan-bertemu-gibran_169.jpeg?w=360&q=90'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      NewsCard(
                        News(
                            idData: 2,
                            title:
                                '14 KK Dievakuasi Imbas Tanah Geser Bulukumba, Pakar Jelaskan Sebabnya',
                            imageUrl:
                                'https://akcdn.detik.net.id/visual/2021/01/28/ilustrasi-sesar-ilustrasi-patahan-ilustrasi-tanah-bergerak_169.jpeg?w=360&q=90'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      NewsCard(
                        News(
                            idData: 3,
                            title:
                                'Polda Metro Bakal Kembali Gelar Street Race Awal Juni',
                            imageUrl:
                                'https://akcdn.detik.net.id/visual/2022/09/03/gelaran-street-race-pmj-kembali-digelar-9_169.jpeg?w=360&q=90'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Questions',
                    style:
                        semiPoppins.copyWith(fontSize: 24, color: whiteColor),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                QuestionCart(
                  Questions(
                    idQuestion: 1,
                    question: "Pertanyaan 1",
                    urlQuestion: 'urlQuestion',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                QuestionCart(
                  Questions(
                    idQuestion: 2,
                    question: "Pertanyaan 2",
                    urlQuestion: 'urlQuestion',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                QuestionCart(
                  Questions(
                    idQuestion: 3,
                    question: "Pertanyaan 3",
                    urlQuestion: 'urlQuestion',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                QuestionCart(
                  Questions(
                    idQuestion: 3,
                    question: "Hai apa kabar?",
                    urlQuestion: 'urlQuestion',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 38,
                ),
                // Add your remaining ListView children here
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
