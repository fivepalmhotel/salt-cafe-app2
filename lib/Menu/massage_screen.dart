import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MassageScreen extends StatefulWidget {
  const MassageScreen({super.key});

  @override
  State<MassageScreen> createState() => _MassageScreenState();
}

class _MassageScreenState extends State<MassageScreen> {
  final List<Map<String, dynamic>> massage = [
    {
      "sender": "Alice",
      "text": "Hey! How are you",
      "image": "assets/images/image_man.png",
      "status": "read",
    },
    {
      "sender": "Me",
      "text": "Hey! How are you",
      "image": "assets/images/profile_pic.jpeg",
      "status": "read",
    },
    {
      "sender": "Alice",
      "text": "Hey! How are you",
      "image": "assets/images/image_man.png",
      "status": "read",
    },
    {
      "sender": "Me",
      "text": "Hey! How are you",
      "image": "assets/images/profile_pic.jpeg",
      "status": "read",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/themeimg.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h, right: 15.w, left: 15.w),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          size: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "Rider Name",
                      style: GoogleFonts.sen(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.sp,
                          color: Colors.white),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: massage.length,
                    itemBuilder: (context, index) {
                      final message = massage[index];
                      final isMe = message['sender'] == "Me";

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              "10:45 AM", // Static time
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!isMe)
                                  Row(
                                    children: [
                                      getStatusIcon(message['status']),
                                    ],
                                  ),
                                if (isMe) ...[
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(message["image"]),
                                    radius: 16,
                                  ),
                                ],

                                // Message Bubble
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: !isMe
                                          ? const Color(0xff9D6712)
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message['text'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isMe
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                ),

                                if (!isMe) ...[
                                  const SizedBox(width: 8),
                                  // Profile Image (Right side for Me)
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(message["image"]),
                                    radius: 20,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Static Input Field
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.emoji_emotions_outlined,
                                color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.send, color: Colors.grey),
                          onPressed: () {}),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getStatusIcon(String status) {
    switch (status) {
      case 'read':
        return const Icon(Icons.done_all, color: Color(0xff9D6712), size: 16);
      case 'delivered':
        return const Icon(Icons.done_all, color: Colors.grey, size: 16);
      case 'sent':
      default:
        return const Icon(Icons.done, color: Colors.grey, size: 16);
    }
  }
}
