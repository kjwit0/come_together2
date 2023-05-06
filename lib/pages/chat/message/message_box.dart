import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class MessageBox extends StatelessWidget {
  const MessageBox(this._message, this._isMe, this._nickname, this._userIcon,
      {super.key});

  final String _message;
  final String _nickname;
  final bool _isMe;
  final String _userIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Row(
          mainAxisAlignment:
              _isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (_isMe)
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
                    _message,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            if (!_isMe)
              Row(
                children: [
                  Column(
                    children: [
                      Text(_nickname,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      ChatBubble(
                        clipper:
                            ChatBubbleClipper4(type: BubbleType.sendBubble),
                        alignment: Alignment.topRight,
                        //margin: const EdgeInsets.only(top: 12),
                        backGroundColor: Colors.indigo,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Text(
                            _message,
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
                    child: CircleAvatar(
                      backgroundImage:
                          (_userIcon == '') ? null : NetworkImage(_userIcon),
                    ),
                  ),
                ],
              ),
          ]),
    );
  }
}
