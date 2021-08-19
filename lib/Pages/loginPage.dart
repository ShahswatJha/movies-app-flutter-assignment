import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app_assignment_1828194/Pages/HomePage.dart';
import 'package:movies_app_assignment_1828194/loginPageController.dart';

class LoginPage extends StatelessWidget {
  //const LoginPage({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xff1e0d2d),
        body: Obx(() {
          if (controller.googleAccount.value == null)
            return buildLoginButton();
          else
            return buildLoggedinPage(width, context);
        }));
  }

  ListView buildLoggedinPage(double width, BuildContext context) {
    // return Column(
    //   children: [
    //     Text(controller.googleAccount.value?.displayName ?? ''),
    //   ],
    // );
    double x = width;
    return ListView(
      children: [
        Stack(
          children: [
            //Profile
            Container(
              height: 350,
              decoration: BoxDecoration(
                  //color: Colors.white,
                  color: Color(0xffFFDAB9),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(80.0))),
            ),
            //
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                height: 150,
                width: width,
                decoration: BoxDecoration(
                    //color: Colors.cyan[50],
                    color: Color(0xffF39189),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(80.0))
                    //color: Color(0xffe3e3e3),
                    ),
                child: Text(
                    "Welcome \n ${controller.googleAccount.value?.displayName ?? 'User'}",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        //color: Color(0xff1e0d2d)
                        color: Colors.white))),
            buildProfile(),
            Padding(
              padding: const EdgeInsets.fromLTRB(45, 375, 10, 200),
              child: Image.asset('assets/images/Magic.gif'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(200, 510, 50, 200),
              child: FloatingActionButton.extended(
                elevation: 8,
                label: Text('Show Movies'),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
          ],
        ),

        //  ElevatedButton(
        //   // style: ButtonStyle(
        //   //   backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
        //   // ),
        //   onPressed: () {
        //     Navigator.push(context,MaterialPageRoute(
        //       builder: (context) => HomePage()
        //     ),
        //     );},
        //   child: const Text('Show Movies'),
        // ),
      ],
    );
  }

  Align buildProfile() {
    String url =
        "https://image.shutterstock.com/image-vector/person-icon-260nw-282598823.jpg";
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 115,
          ),
          CircleAvatar(
            backgroundImage:
                Image.network(controller.googleAccount.value?.photoUrl ?? url)
                    .image,
            //backgroundImage: Image.network(url).image,
            radius: 69,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
              " You are logged in with ${controller.googleAccount.value?.email ?? ''}"),
          SizedBox(
            height: 15,
          ),
          ActionChip(
              avatar: Icon(Icons.logout),
              label: Text('Logout'),
              onPressed: () {
                controller.logout();
              })
        ],
      ),
    );
  }

  Column buildLoginButton() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 50, 0, 0),
          child: Image.asset('assets/images/Google.jpg',
           height:500 ,width: 500,),
        ),
        FloatingActionButton.extended(
          onPressed: () {
            controller.login();
          },
          label: Text('Sign in with Google'),
          icon: Icon(Icons.security_rounded),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        SizedBox(height: 5,),
        Text("Sign In to Add your favourite movies",
        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
      ],
    );
  }
}
