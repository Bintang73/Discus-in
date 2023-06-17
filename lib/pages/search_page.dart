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
                    SearchUsers(
                      Users(
                        idUser: 1,
                        name: 'Anton',
                      ),
                    ),
                    SearchUsers(
                      Users(
                        idUser: 2,
                        name: 'Beni',
                      ),
                    ),
                    SearchUsers(
                      Users(
                        idUser: 3,
                        name: 'Rusdi',
                      ),
                    ),
                  ],
                ),
              ),

              // Add your remaining ListView children here
            ]),
          ),
        ],
      ),
    );
  }
}
