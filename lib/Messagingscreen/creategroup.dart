import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messagingapp/Messagingscreen/showchat.dart';
class Creategroup  extends StatefulWidget {
  String Text;
  String text1;
  Creategroup({this.Text,this.text1});
  @override
  _CreategroupState createState() => _CreategroupState();
}

class _CreategroupState extends State<Creategroup> {
  String currentuid = FirebaseAuth.instance.currentUser.uid;
 // List<String> snapshotquery=[];
 //
 //  String a="a";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
            Text(widget.Text),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").snapshots(),
              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot)
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
                     return Expanded(
                        child: ListView.builder(
                         itemCount: snapshot.data.docs.length,
                           itemBuilder:(context,index)
                    {

                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: InkWell(
                            onTap: ()
                            {
                              setState(() {
                                 FirebaseFirestore.instance.collection("creategroup").add({
                                   "user":snapshot.data.docs[index].data()["uid"],
                                    "created":widget.text1,
                                   "name":widget.Text,

                                 });
                              });


                            },
                            child: Row(
                              children: [
                                Text(snapshot.data.docs[index].data()["name"]),
                                Spacer(),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                  //color:==snapshot.data.docs[index].data()["uid"].toString()? Colors.green:Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                    }),
                     );
                  }
              }
          ),
          InkWell(
               onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>showgroup()));
               },
              child: Text("MoveNext",style: TextStyle(color: Colors.teal),)),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
