import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app_login/utility/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ตัวแปรไว้เก็บค่า Email ที่ป้อนเข้ามา
  TextEditingController _user = TextEditingController();
  // ตัวแปรไว้เก็บค่า password ที่ป้อนเข้ามา
  TextEditingController _password = TextEditingController();
  bool _passwordVisible = false;

  // ฟังก์ชันสำหรับการสร้าง textfield สำหรับการกรอก E-mail
  _buildEmaildisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _user,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.manage_accounts,
                color: Colors.white,
              ),
              hintText: 'Enter your username',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

// ฟังก์ชันสำหรับการสร้าง textfield สำหรับการกรอก password
  _buildPassworddisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: !_passwordVisible,
            controller: _password,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              hintText: 'Enter your password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

// ฟังก์ชันสำหรับสร้าง Textbutton ในกรณีลืมรหัสผ่าน
  _buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: kLabelStyle,
        ),
        onPressed: () {},
        child: const Text(
          'Forgot password ?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF00b09b),
                  Color(0xFF96c93d),
                ],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 80,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/farmlink.png',
                    height: 120,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildEmaildisplay(),
                  SizedBox(
                    height: 30,
                  ),
                  _buildPassworddisplay(),
                  _buildForgotPassword(),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(120, 15, 120, 15),
                      ),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 20),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      print('--------------------------------------');
                      print('Username: ${_user.text}');
                      print('Password: ${_password.text}');
                      Login();
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Color(0xFF90C12E),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future Login() async {
    // var url = Uri.http('192.168.0.6:8000', '/api/post-todolist');
    var url = Uri.https('40c6-171-96-221-192.ngrok.io', '/api/login');
    Map<String, String> header = {"Content-type" : "application/json"};
    String jsondata = '{"username" : "${_user.text}", "password" : "${_password.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('---------------------');
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _user.clear();
        _password.clear();
      });
    }
  }

}
