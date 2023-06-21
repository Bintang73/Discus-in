import 'package:flutter/material.dart';

import '../theme.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String dropdownvalue = 'Pilih Kategori';

  // List of items in our dropdown menu
  var items = [
    'Pilih Kategori',
    'Kategori 1',
    'Kategori 2',
    'Kategori 3',
    'Kategori 4',
    'Kategori 5',
    'Kategori 6',
    'Kategori 7',
    'Kategori 8',
    'Kategori 9',
    'Kategori 10',
    'Kategori 11',
    'Kategori 12',
    'Kategori 13',
    'Kategori 14',
    'Kategori 15',
    'Kategori 16',
    'Kategori 17',
    'Kategori 18',
    'Kategori 19',
    'Kategori 20',
    'Kategori 21',
    'Kategori 22',
    'Kategori 23',
    'Kategori 24',
    'Kategori 25',
    'Kategori 26',
    'Kategori 27',
    'Kategori 28',
    'Kategori 29',
    'Kategori 30',
  ];
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
                        child: DropdownButtonFormField(
                          value: dropdownvalue,
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
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: regularPoppins.copyWith(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                      /*
                        Container for post message
                      */
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
