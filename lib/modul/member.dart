class Member {
  Member(
      {required this.memberId,
      required this.memberEmail,
      required this.memberNickname,
      this.memberIcon});

  late String memberId;
  late String memberEmail;
  late String memberNickname;
  String? memberIcon;
}
