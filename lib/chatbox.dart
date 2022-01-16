import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class chatbox extends StatefulWidget {
  chatbox({Key? key}) : super(key: key);

  @override
  _chatbox createState() => _chatbox();
}

class _chatbox extends State<chatbox> {
  TextEditingController msg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: 150,
                color: Colors.lightBlue,
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('messeges').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('error');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Text('the type is empty');
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      List<DocumentSnapshot> _docs = snapshot.data!.docs;

                      List _users = _docs.map((e) => e["messege"]).toList();
                   
                      return ListView.builder(
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            return Text(_users[index] ?? 'no name');
                          });
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msg,
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('messeges')
                            .add({
                          'messege': msg.value.text,
                        }).catchError((e) => debugPrint(e.toString()));
                      },
                      child: Text("send"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
