import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Conservation extends StatefulWidget {
  DocumentSnapshot uids;
  Conservation({this.uids});
  @override
  _ConservationState createState() => _ConservationState();
}

class _ConservationState extends State<Conservation> {
  Future<void> callback() async {
    if (text.text.length > 0) {
      await FirebaseFirestore.instance.collection('messages').add({
        'text':text.text,
        'to':text2,
        'date': DateTime.now().toIso8601String().toString(),
        'from':currentuid,
      });
      text.clear();

    }
  }
  TextEditingController text = TextEditingController();
  String text1;
  String text2;
  String currentuid;
  @override
  void initState() {
    text1=widget.uids.data()['name'];
    text2=widget.uids.data()['uid'];
    currentuid=FirebaseAuth.instance.currentUser.uid;
    print("ok we are checking");
    print(widget.uids);
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
        title: Text(text1,
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
              stream: FirebaseFirestore.instance.collection("messages").where("to",whereIn: [currentuid,text2]).snapshots(),
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
                          return Column(
                            children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    children: [
                                     currentuid==snapshot.data.docs[index].data()["from"]&&text2==snapshot.data.docs[index].data()["to"]? reverMsg(bgColor: Colors.white24, textColor: Colors.black,text:snapshot.data.docs[index].data()["text"] ):SizedBox(width: 0,),
                                      // Text(DateFormat('kk:mm:ss')
                                      //     .format(DateTime.now())
                                      //     .toString())
                                    ],
                                  )),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Column(
                                    children: [
                                      currentuid==snapshot.data.docs[index].data()["to"]&&text2==snapshot.data.docs[index].data()["from"]?  reverMsg(bgColor: Colors.blue, textColor:Colors.grey,text:snapshot.data.docs[index].data()["text"] ):SizedBox(width: 0,),
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
