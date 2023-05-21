class ChatMessage {
  String roomId = '';
  String memberId = '';
  String text = '';
  String time = '';
  ChatMessage(
      {this.roomId = '', this.memberId = '', this.text = '', this.time = ''});

  ChatMessage.fromJson(Map<String, dynamic> json)
      : roomId = json['roomId'],
        memberId = json['memberId'],
        text = json['text'],
        time = json['time'];

  Map<String, dynamic> toJson() =>
      {'roomId': roomId, 'memberId': memberId, 'text': text, 'time': time};
}
