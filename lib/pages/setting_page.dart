import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stalkin/theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  bool isSnackbarShown = false;

  // user data
  final currentUser = FirebaseAuth.instance.currentUser!;

  // edit user
  Future<void> editField(String field, String newValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .update({field: newValue});

      if (!isSnackbarShown) {
        // Cek apakah Snackbar sudah ditampilkan sebelumnya
        isSnackbarShown = true; // Set flag menjadi true
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Berhasil Diubah',
              style: semiPoppins,
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
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
  void dispose() {
    _name.dispose();
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData =
                snapshot.data!.data() as Map<String, dynamic>? ?? {};
            _name.text = userData['name'] ?? '';
            _bio.text = userData['bio'] ?? '';

            return CustomScrollView(
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
                              'Setting',
                              style: semiPoppins.copyWith(
                                fontSize: 24,
                                color: mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        padding: const EdgeInsets.only(top: 46),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 26),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      userData['urlProfile'] ?? '',
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    top: 0,
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: whiteColor,
                                      onPressed: () {
                                        // Tambahkan aksi yang diinginkan ketika ikon edit diklik
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                controller: _name,
                                style: regularPoppins.copyWith(fontSize: 14),
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
                                  hintText: 'Name',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              height: 200,
                              width: double.infinity,
                              child: TextField(
                                controller: _bio,
                                textAlignVertical: TextAlignVertical.top,
                                expands: true,
                                maxLines: null,
                                style: regularPoppins.copyWith(fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'Bio',
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
                            Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
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
                              child: ElevatedButton(
                                onPressed: () {
                                  editField('name', _name.text);
                                  editField('bio', _bio.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Ubah',
                                  style: semiPoppins.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      // Add your remaining ListView children here
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
