import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class roomm extends StatefulWidget {
   DocumentSnapshot text1;
   roomm({this.text1});
  @override
  _roommState createState() => _roommState();
}

class _roommState extends State<roomm> {
  Future<void> callback() async {
    if (text.text.length > 0) {
      await FirebaseFirestore.instance.collection("roommessages").add({
        'text':text.text,
      //  'to':text2,
        'date': DateTime.now().toIso8601String().toString(),
        'from':currentuid,
        "usesr":user,
        "name":name,

      });
      text.clear();

    }
  }
  TextEditingController text = TextEditingController();
  String text2;
  String currentuid;
  String name;
  String user;
  @override
  void initState() {
    name=widget.text1.data()["name"];

    user=widget.text1.data()["user"];
    text2=widget.text1.data()['name'];
    currentuid=FirebaseAuth.instance.currentUser.uid;
    print("ok we are checking");
    //print(widget.uids);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Row(
        children: [Expanded(child: botmChatbar()), sendBtn()],
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Chats()),
            // );
          },
          icon: Icon(
            Icons.arrow_back,
            size:20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(text2,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("roommessages").snapshots(),
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot)
                {
                  if(snapshot.connectionState==ConnectionState.waiting)
                  {
                    return Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                        child:   CircularProgressIndicator(),
                      ),
                    );
                  }
                  else
                  {

                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        print("we");
                        print(snapshot.data.docs[index].data()["from"]);
                        return Column(
                          children: [
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  children: [
                                    currentuid==snapshot.data.docs[index].data()["from"]&&name==snapshot.data.docs[index]["name"]?
                                    reverMsg(bgColor: Colors.white24, textColor: Colors.black,text:snapshot.data.docs[index].data()["text"] ):SizedBox(width: 0,),
                                        //:SizedBox(width: 0,),
                                    // Text(DateFormat('kk:mm:ss')
                                    //     .format(DateTime.now())
                                    //     .toString())
                                  ],
                                )),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  children: [
                                    currentuid!=snapshot.data.docs[index].data()["from"]&&name==snapshot.data.docs[index]["name"]?  reverMsg(bgColor: Colors.blue, textColor:Colors.grey,text:snapshot.data.docs[index].data()["text"] ):SizedBox(width: 0,),
                                  ],
                                ))
                          ],
                        );
                      },
                    )     ;
                  }
                }

            ),

          )
        ],
      ),
    );
  }

  Widget botmChatbar() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: TextFormField(
        controller: text,
        onChanged: (value)
        {
        },
        decoration: InputDecoration(
            fillColor: Colors.blue,
            filled: true,
            hintText: "Enter your message",
            hintStyle: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget sendBtn() {
    return Container(
      margin: EdgeInsets.only(right: 10, bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.black38.withOpacity(0.5),
        child: InkWell(
          onTap: (){
            callback();
          },
          child: Icon(
            Icons.send,
            size: 20,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget reverMsg({Color bgColor=Colors.white24, Color textColor=Colors.blueGrey,String text}) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}