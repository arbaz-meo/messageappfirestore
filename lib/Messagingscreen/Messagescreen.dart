import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messagingapp/Messagingscreen/Roomchat.dart';
import 'package:messagingapp/Messagingscreen/inbox.dart';
class messagescreen extends StatefulWidget {
  @override
  _messagescreenState createState() => _messagescreenState();
}

class _messagescreenState extends State<messagescreen> {
  @override
  Future<void> didChangeDependencies() async {

    value = await getuserid();
    print("its value getting");
    setState(() {
      cond=value;
    });
    print(value);


    super.didChangeDependencies();
  }
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String okk;
  String value;
  String cond;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Roomchat()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.group),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
        Center(child: Text('${cond} inbox',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)),
          StreamBuilder(
            stream:FirebaseFirestore.instance.collection("users").snapshots() ,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
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
               return  Expanded(
                 child: ListView.builder(
                     itemCount: snapshot.data.docs.length,
                       itemBuilder:(_,index)
                       {
                         return Padding(
                           padding: const EdgeInsets.all(20),
                           child: Row(
                             children: [
                             InkWell(
                               onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Conservation(uids:snapshot.data.docs[index])));
                               } ,
                                 child: Text( snapshot.data.docs[index].data()["name"])),
                             ],
                           ),
                         );
                       }
                   ),
               );
                }
          })
        ],
      ),
    );
  }

  Future<String> getuserid() async
  {
    final User users =await firebaseAuth.currentUser;
    await FirebaseFirestore.instance.collection("users")
        .doc(users.uid).get().then((datasnapshot){
      okk =  datasnapshot.data()["name"];
    });
    print("ok its value");
    print (okk);
    return okk;
  }
}
