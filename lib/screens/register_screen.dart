import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app_login/utility/constant.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
// ตัวแปร สำหรับการกรอกข้อมูล Username
  TextEditingController _user = TextEditingController();
// ตัวแปร สำหรับการกรอกข้อมูล Password
  TextEditingController _password = TextEditingController();
  // ตัวแปร สำหรับการกรอกข้อมูล Password
  TextEditingController _passwordCon = TextEditingController();
// ตัวแปรสำหรับเปิด-ปิดการดู Password
  bool _passwordVisible = false;
// ตัวแปรทำเผื่อไว้ถาต้องการเปิด-ปิดการดู Password ในการ Confirm Password
  bool _passwordVisibleConfirm = false;
// ตัวแปรสำหรับการเริ่มต้น Dropdown
  String dropdownValue = 'User';

// Function สำหรับการสร้าง TextField สำหรับกรอก Username
  _buildUsername() {
    return TextField(
      controller: _user,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        border: UnderlineInputBorder(),
        contentPadding: EdgeInsets.only(top: 14),
        prefixIcon: Icon(
          Icons.manage_accounts,
          color: Colors.white,
        ),
        hintText: 'Enter Username',
        hintStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

// Function สำหรับสร้างช่องกรอก Password
  _buildPassword() {
    return TextField(
      obscureText: !_passwordVisible,
      controller: _password,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        border: UnderlineInputBorder(),
        contentPadding: EdgeInsets.only(top: 14),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon:
              Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
          color: Colors.white,
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        hintText: 'Enter Password',
        hintStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

// Function สำหรับสร้างช่องกรอกยืนยัน Password
  _buildConfirm_Password() {
    return TextField(
      obscureText: !_passwordVisibleConfirm,
      controller: _passwordCon,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        border: UnderlineInputBorder(),
        contentPadding: EdgeInsets.only(top: 14),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        // *************************** Suffix Icon ใช้เปิด-ปิดการดูรหัสผ่านได้ ****************************
        // suffixIcon: IconButton(
        //   icon:
        //       Icon(_passwordVisibleConfirm ? Icons.visibility : Icons.visibility_off),
        //   color: Colors.white,
        //   onPressed: () {
        //     setState(() {
        //       _passwordVisibleConfirm = !_passwordVisibleConfirm;
        //     });
        //   },
        // ),
        hintText: 'Confirm Password',
        hintStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
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
                    height: 10,
                  ),
                  Text(
                    'Register User',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Column(
                      children: [
                        _buildUsername(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildPassword(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildConfirm_Password(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'User Permission',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Dropdown(),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(100, 15, 100, 15),
                            ),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 20),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            print('--------------------------------------');
                            print('Username: ${_user.text}');
                            print('Password: ${_password.text}');
                            print('Confirm Password: ${_passwordCon.text}');
                            print('Permission: ${dropdownValue}');
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Color(0xFF90C12E),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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

  Widget Dropdown() {
    return DropdownButton<String>(
      value: dropdownValue,
      dropdownColor: Colors.green[700],
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.white,
      ),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['User', 'Admin']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        );
      }).toList(),
    );
  }
}
