// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:shopnewversion/controllers/login_page_controller.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Login_screenState createState() => _Login_screenState();
}


class _Login_screenState extends State<LoginScreen> {
  final LoginController _controller = LoginController();
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(249, 252, 252, 252),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0, top: 10.0),
                child: Image.asset('images/tof1.jpg'),
              ),
              const Text(
                'Login',
                style: TextStyle(
                  color: Color.fromARGB(255, 20, 58, 74),
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Please Sign in to continue.',
                style: TextStyle(
                  color: Color.fromARGB(255, 20, 58, 74),
                ),
              ),
              const SizedBox(height: 20.0),
              // username/email field
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: TextField(
                  onChanged: (value) {
                    _controller.updateUsername(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined, color: Color.fromARGB(84, 146, 172, 183)),
                    hintText: 'Username',
                    filled: true,
                    fillColor: const Color.fromARGB(134, 225, 233, 238),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              // password field
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: TextField(
                  obscureText: hide,
                  onChanged: (value) {
                    _controller.updatePassword(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Color.fromARGB(84, 146, 172, 183)),
                    hintText: 'Password',
                    filled: true,
                    fillColor: const Color.fromARGB(134, 225, 233, 238),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                      icon: Icon(hide ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                ),
              ),
               const Padding(
          padding:EdgeInsets.only(left: 10.0,top:8.0,bottom: 20.0),
          child:  Text(
          'forget your password?',
          style: TextStyle(
            color: Color.fromARGB(255, 20, 58, 74),
          ),
        ),),

        // connexion button
         Padding(padding:const EdgeInsets.only(left: 2.0),
        child: TextButton(
          
          onPressed: () {
             _controller.login();
          },
          style:const ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size.fromWidth(500)),
              backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(2, 37, 70, 0.976))
            ),
          child:const Center(
            child: Text('Sign in',
            style: TextStyle(
              color:  Color.fromARGB(255, 209, 216, 225)
            ),),
          )
            )),

             const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Or sign in with",
                      style: TextStyle(
                        color: Color.fromARGB(255, 20, 58, 74),
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
          const SizedBox(height: 20.0),
              // Google & Facebook sign-in button

               Row(
            children: [
              Expanded(
                child: TextButton(
                      style:const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(2, 37, 70, 0.976))
                      ),
                      onPressed: () {
                        _controller.loginWithGoogle(context);
                      },
                child: Row(
                  children: [
                    Image.asset('images/google.png', height: 20),
                    const SizedBox(width: 10.0),
                    const Text(
                      'Google',
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 209, 216, 225)),
                    ),
                  ],
                ),
                )),
                     const SizedBox(width: 5.0,),
                       Expanded(
                child: TextButton(
                      style:const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(2, 37, 70, 0.976))
                      ),
                      onPressed: () { 
                        _controller.loginWithFaceBook();
                       },
                      child: Row(
                        children: [
                         Image.asset('images/icons_facebook96.png',
                         height: 24,),
                        const SizedBox(width:  10.0,),
                        const Text('Facebook',
                              style: TextStyle(
                                fontSize: 20,
                              color:  Color.fromARGB(255, 209, 216, 225)
                           ),)
                        ],
                      ),))
            ],
          ),
          Row(
             children: [
             const  Text('Don\'t have account?',
              style: TextStyle(
            color: Color.fromARGB(255, 20, 58, 74),
          ),),
              TextButton(
                onPressed: (){
                 /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const RegisterScreen()),
          );*/
                }, 
                child:const Text('Sign up',
                style: TextStyle(
                 color:  Color.fromRGBO(2, 37, 70, 0.976),
                 fontWeight: FontWeight.w700
                ),))
             ],
          )
              
            ],
          ),
        ),
      ),
    );
  }
}