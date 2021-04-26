import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messagingapp/Messagingscreen/roommmessages.dart';
class showgroup  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          Text("Groups"),
          StreamBuilder(
              stream:(FirebaseFirestore.instance.collection("creategroup").where("user",isEqualTo:FirebaseAuth.instance.currentUser.uid).snapshots()),
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

                              // {
                              //   setState(() {
                              //     FirebaseFirestore.instance.collection(widget.Text).doc().collection("users").add({
                              //       "user":snapshot.data.docs[index].data()["uid"],
                              //     });
                              //   });


                              },
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>roomm(text1:snapshot.data.docs[index])));
                                    },
                                      child: Text(snapshot.data.docs[index].data()["name"])),
                                  Spacer(),

                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
              }
          ),

        ],
      ),
    );
  }
}
