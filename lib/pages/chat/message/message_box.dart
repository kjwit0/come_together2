import 'package:come_together2/components/come_together_user_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(
      {required this.message,
      required this.isMe,
      required this.nickname,
      required this.userIcon,
      super.key});

  final String message;
  final String nickname;
  final bool isMe;
  final String userIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (isMe)
              ChatBubble(
                clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
                alignment: Alignment.topRight,
                margin: const EdgeInsets.only(top: 12),
                backGroundColor: const Color.fromARGB(122, 129, 199, 132),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            if (!isMe)
              Row(
                children: [
                  Column(
                    children: [
                      Text(nickname,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      ChatBubble(
                        clipper:
                            ChatBubbleClipper4(type: BubbleType.sendBubble),
                        alignment: Alignment.topRight,
                        backGroundColor: Colors.indigo,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Text(
                            message,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 201, 64),
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 50, left: 10),
                    child: UserIconView(
                      url: userIcon,
                    ),
                  ),
                ],
              ),
          ]),
    );
  }
}
