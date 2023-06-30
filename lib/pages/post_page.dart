import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String selectedTopic = '0';
  final TextEditingController _textdiscus = TextEditingController();
  bool isSnackbarShown = false;

  // user data
  final currentUser = FirebaseAuth.instance.currentUser!;

  // add post user
  Future<void> postField(String postKategori, String postPostingan) async {
    try {
      DateTime now = DateTime.now();
      int timestamp = now.millisecondsSinceEpoch ~/ 1000;
      await FirebaseFirestore.instance.collection('User Post').add({
        "kategori": postKategori,
        "email": currentUser.email,
        "timestamp": timestamp,
        "postingan": postPostingan,
        "likeby": [],
        "dislikeby": [],
        "savedby": [],
        "commentCount": 0,
        "comment": []
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // Cek apakah Snackbar sudah ditampilkan sebelumnya
      isSnackbarShown = true; // Set flag menjadi true
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Berhasil Ditambahkan',
            style: semiPoppins,
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: semiPoppins,
          ),
          backgroundColor: Colors.red,
        ),
      );
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
            toolbarHeight: 70,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Create Post',
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
              const SizedBox(height: 38),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Topic')
                            .snapshots(),
                        builder: (context, snapshot) {
                          List<DropdownMenuItem> topicList = [];
                          if (!snapshot.hasData) {
                            const CircularProgressIndicator();
                          } else {
                            final topics =
                                snapshot.data?.docs.reversed.toList();
                            topicList.add(DropdownMenuItem(
                                value: '0',
                                child: Text(
                                  'Pilih Topik Diskusi',
                                  style: semiPoppins.copyWith(
                                    fontSize: 16,
                                  ),
                                )));
                            for (var topic in topics!) {
                              topicList.add(DropdownMenuItem(
                                value: topic.id,
                                child: Text(
                                  topic['name'],
                                  style: semiPoppins.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ));
                            }
                          }
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField(
                              items: topicList,
                              onChanged: (topicValue) {
                                setState(() {
                                  selectedTopic = topicValue;
                                });
                              },
                              value: selectedTopic,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteColor,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: secondaryColor,
                                    width: 2.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        height: 300,
                        width: double.infinity,
                        child: TextField(
                          controller: _textdiscus,
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          maxLines: null,
                          style: regularPoppins.copyWith(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Apa yang anda pikirkan?',
                            filled: true,
                            fillColor: whiteColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: secondaryColor,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            try {
                              if (selectedTopic == "0") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Silahkan Pilih Topik Diskusi Terlebih Dahulu!',
                                      style: semiPoppins,
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                String jumlahKata =
                                    _textdiscus.text.split(' ').length >= 5
                                        ? 'Benar'
                                        : 'Salah';
                                if (jumlahKata == "Benar") {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Pesan Dialog'),
                                      content: const Text(
                                          'Apakah anda yakin ingin mengirim post ini?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            DocumentSnapshot docSnapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('Topic')
                                                    .doc(selectedTopic)
                                                    .get();
                                            if (docSnapshot.exists) {
                                              Map<String, dynamic> data =
                                                  docSnapshot.data()
                                                      as Map<String, dynamic>;
                                              String name = data['name'];
                                              postField(name, _textdiscus.text);
                                            }
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Jumlah Minimal 5 Kata yang akan di post!',
                                        style: semiPoppins,
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              // ignore: avoid_print
                              print(e);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                          ),
                          child: Text(
                            'Post',
                            style: semiPoppins.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              // Add your remaining ListView children here
            ]),
          ),
        ],
      ),
    );
  }
}
