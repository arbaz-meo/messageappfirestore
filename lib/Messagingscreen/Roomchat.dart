
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/Messagingscreen/creategroup.dart';
class Roomchat extends StatefulWidget {
  @override
  _RoomchatState createState() => _RoomchatState();
}

class _RoomchatState extends State<Roomchat> {
  TextEditingController cont= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("GROUP CHAT"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: InkWell(
              onTap: (){
                bottomSheet(context);
               // Navigator.push(context, MaterialPageRoute(builder: (context)=>Creategroup()));
              },
              child: Row(
                children: [
                  Text("Create Group",style: TextStyle(fontWeight: FontWeight.bold),),
                    Spacer(),
                    Icon(Icons.create),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
  Widget bottomSheet(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,

        isScrollControlled: true,


        context: context,
        builder:(context)
        {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,

            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+10),
                // height: size.height*0.6,
                decoration: BoxDecoration(
                  color: Colors.white,

                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                    Container(
                      height: 100,
                      width:double.infinity,
                      child: TextFormField(
                        controller: cont,
                        decoration: InputDecoration(
                          hintText: "enter group name",


                        ),
                      ),
                    ),
                      InkWell(
                        onTap: ()async{
                          await FirebaseFirestore.instance.collection("Groupchat").add({
                            "createdby":FirebaseAuth.instance.currentUser.uid,
                            "name":cont.text
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Creategroup(Text:cont.text,text1:FirebaseAuth.instance.currentUser.uid)));
                        },
                        child: Container(
                          height:40 ,
                          width: 50,
                          color: Colors.teal,
                          child: Center(child: Text("Create",textAlign: TextAlign.center,)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }


    );

  }
}
