import 'package:flutter/material.dart';
import 'package:messagingapp/Login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messagingapp/Messagingscreen/Messagescreen.dart';
class Signup extends StatelessWidget {
  TextEditingController namecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String name;
  String email;
  String password;
  Future Adduser( )async
  {
    await firebaseAuth.createUserWithEmailAndPassword(email:email,password:password ).
   then((currentuser)=>
       FirebaseFirestore.instance.collection("users").doc(currentuser.user.uid)
        .set({
         "name":name,
          "email":email,
            "uid":currentuser.user.uid,

       })
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign UP",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 20,),
              Container(
                height: 70,
                width: double.infinity,
                child: Card(
                    color: Colors.grey,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: size.width*0.1,),
                        Icon(Icons.person_outline_sharp,size: 25,),
                        SizedBox(width: size.width*0.1,),
                        Container(
                          width:size.width*0.5,
                          child: TextFormField(
                            //onChanged: onchanged,
                            onChanged: (value)
                            {
                              name=value;
                            },
                            controller: namecont,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:"Please enter your name",
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              Container(
                height: 70,
                width: double.infinity,
                child: Card(
                    color: Colors.grey,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: size.width*0.1,),
                        Icon(Icons.mail_outline,size: 25,),
                        SizedBox(width: size.width*0.1,),
                        Container(
                          width:size.width*0.5,
                          child: TextFormField(
                            //onChanged: onchanged,
                            onChanged: (value)
                            {
                              email=value;
                            },
                            controller: emailcont,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:"Please enter your email",
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              Container(
                height: 70,
                width: double.infinity,
                child: Card(
                    color: Colors.grey,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: size.width*0.1,),
                        Icon(Icons.lock,size: 25,),
                        SizedBox(width: size.width*0.1,),
                        Container(
                          width:size.width*0.5,
                          child: TextFormField(
                            //onChanged: onchanged,
                            onChanged: (value)
                            {
                              password=value;
                            },
                            controller: passwordcont,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:"Please enter your password",
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: ()
                {
                  _formKey.currentState.save();
                  Adduser();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>messagescreen()));


                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  child:Card(
                    color: Colors.pink,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(child: Text("Signup",style:TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
                  ) ,
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Are you have already account ?"),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
                      },
                        child: Text("Login",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 17),)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
