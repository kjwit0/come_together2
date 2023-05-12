import 'package:flutter/material.dart';
import '../message/message_list.dart';
import '../message/message_send.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({required this.roomTitle, super.key});
  final String roomTitle;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.roomTitle),
        ),
        body: Column(
          children: const [
            Expanded(
              child: MessageList(),
            ),
            MessageSend(),
          ],
        ));
  }
}
