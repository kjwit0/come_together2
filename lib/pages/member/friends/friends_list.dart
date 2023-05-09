import 'package:come_together2/pages/member/friends/member_box.dart';
import 'package:flutter/material.dart';

class MemberList extends StatelessWidget {
  const MemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.account_box),
                                Text('data'),
                                ElevatedButton(
                                    onPressed: () {}, child: Text('대화하기')),
                              ],
                            )
                          ],
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
