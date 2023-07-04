import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stalkin/models/user.dart';
import 'package:stalkin/widgets/search_card.dart';

import '../theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  String searchQuery = '';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Search',
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
                    Container(
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
                      child: TextField(
                        controller: search,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        style: regularPoppins.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: whiteColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: secondaryColor, width: 2.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Cari",
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: mainColor,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final users = snapshot.data?.docs.map((doc) {
                            final String id = doc.id;
                            final String name = doc['name'];
                            final String bio = doc['bio'];
                            final String img = doc['urlProfile'];
                            return Users(
                                idUser: id,
                                name: name,
                                bio: bio,
                                urlProfile: img);
                          }).where((user) {
                            final lowerCaseQuery = searchQuery.toLowerCase();
                            final lowerCaseName = user.name.toLowerCase();
                            return lowerCaseName.contains(lowerCaseQuery);
                          }).toList();
                          if (users != null && users.isNotEmpty) {
                            return Column(
                              children: users
                                  .map((user) => SearchUsers(user))
                                  .toList(),
                            );
                          } else {
                            return Text(
                              'No results found.',
                              style: semiPoppins.copyWith(
                                  fontSize: 24, color: whiteColor),
                            );
                          }
                        }
                        return const SizedBox(); // Return an empty widget if there's no data
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}