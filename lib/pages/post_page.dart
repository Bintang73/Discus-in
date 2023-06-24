import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String selectedTopic = '0';

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
                          //controller: _bio,
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
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
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
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
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
