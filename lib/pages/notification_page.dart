import 'package:flutter/material.dart';
import 'package:stalkin/models/notification.dart';
import 'package:stalkin/widgets/notification_card.dart';
import '../theme.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final balas = TextEditingController();
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
                        'Notification',
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
                    NotificationUser(
                      Notifications(
                        idNotif: 1,
                        message: 'Anda punya pertanyaan baru!',
                      ),
                    ),
                    NotificationUser(
                      Notifications(
                        idNotif: 2,
                        message: 'Pertanyaan Anda dijawab!',
                      ),
                    ),
                    NotificationUser(
                      Notifications(
                        idNotif: 1,
                        message: 'Anda punya pertanyaan baru!',
                      ),
                    ),
                    NotificationUser(
                      Notifications(
                        idNotif: 2,
                        message: 'Pertanyaan Anda dijawab!',
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
