class Member {
  Member({
    this.memberId = '',
    this.memberEmail = '',
    this.memberNickname = '',
    this.memberIcon = 'none',
  });

  String memberId;
  String memberEmail;
  String memberNickname;
  String? memberIcon;
  List<String> friends = [];

  Member.fromJson(Map<String, dynamic> json)
      : memberId = json['memberId'],
        memberEmail = json['memberEmail'],
        memberNickname = json['nickname'],
        memberIcon = json['userIcon'],
        friends = List<String>.from(json['friends']);

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'memberEmail': memberEmail,
        'nickname': memberNickname,
        'userIcon': memberIcon,
        'friends': friends
      };
}
