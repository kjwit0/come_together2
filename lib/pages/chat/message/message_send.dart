import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageSend extends StatefulWidget {
  const MessageSend({super.key});

  @override
  State<MessageSend> createState() => _MessageSendState();
}

class _MessageSendState extends State<MessageSend> {
  String _userEnterMessage = '';
  final _textController = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final userId = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text': _userEnterMessage,
      'time': Timestamp.now(),
      'memberId': userId!.uid,
      'nickname': userId.displayName
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            maxLines: null,
            controller: _textController,
            decoration: const InputDecoration(labelText: '메시지 입력'),
            onChanged: (value) {
              setState(() {
                _userEnterMessage = value;
              });
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          color: Colors.green[300],
          onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
        ),
      ]),
    );
  }
}
