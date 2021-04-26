import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/Messagingscreen/Messagescreen.dart';
class Login extends StatelessWidget {
  Future Loginuser()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,


      );
      print("we in function");
      print(userCredential);
      return userCredential;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "User Not Found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "you Enter Wrong Password",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    } catch (e) {
      print(e);
    }
  }
  TextEditingController emailcont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
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
                            onChanged: (value){
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
                onTap: (){
                  _formKey.currentState.save();
                  Loginuser().then((userCredential)
                  {
                    if(userCredential!=null)
                    {
                      print("user sucessful Login");
                      print(userCredential);
                      Navigator.push(context,  MaterialPageRoute(
                        builder: (context)=>messagescreen(),
                      ));

                    }

                  });
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
                    child: Center(child: Text("Login",style:TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
                  ) ,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
