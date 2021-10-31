import 'package:flutter/material.dart';
import 'package:flutter_food/models/api_result.dart';

import 'package:flutter_food/services/api.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //static const pin = '123456';
  static const PIN_LENGTH = 6;
  var _input = '';
  var _isLoading = false;
  Map<String , dynamic> a = {'year':0,'month':0,'day':0};
  List tittlename = ['','','','',''];
  List number = ['','','','',''];
  List name = ['','','','',''];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                /*stops: [
                  0.0,
                  0.95,
                  1.0,
                ],*/
                colors: [
                  Colors.white,
                  //Color(0xFFD8D8D8),
                  //Color(0xFFAAAAAA),
                  Theme.of(context).colorScheme.background.withOpacity(0.5),
                  //Theme.of(context).colorScheme.background.withOpacity(0.6),
                  //Colors.white,
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [

                          Icon(
                            Icons.poll,
                            size: 90.0,
                            color:
                                Theme.of(context).textTheme.headline1?.color,
                          ),
                          Text(
                            'การเลือกตั้ง อบต.',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            'Exit Poll',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                    TextButton(

                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused))
                                return Colors.red;
                              return null; // Defer to the widget's default.
                            }
                        ),
                      ),
                      onPressed: () { _handleClickButton(5);


                      },
                      child: Text('ดูรายชื่อผู้ลงสมัคร'),
                    ),for(int i =0;i<5;i++)
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused))
                                return Colors.red;
                              return null; // Defer to the widget's default.
                            }
                        ),
                      ),
                      onPressed: () { 
                        _handleClickButton2();
                      },
                      child: Text('${number[i]} ${tittlename[i]}${name[i]}'),
                    ),




                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }



  _handleClickButton(int num) async {
    print('You pressed $num');
    //Api().fetch('exit_poll','07580420');
    var isLogin = (await Api().fetch('exit_poll','07580420')).toList();

      //print('loging na ja ${isLogin[0]['candidateName']}');

       setState(() {
         for(int i=0;i<5;i++){
           name[i] = isLogin[i]['candidateName'];
         }
         for(int i=0;i<5;i++){
           number[i] = isLogin[i]['candidateNumber'];
         }
         for(int i=0;i<5;i++){
           tittlename[i] = isLogin[i]['candidateTitle'];
         }

       });
      }


  _handleClickButton2() async {


    var isLogin = (await Api().submit('exit_poll','07580420',1)).toString();

    if (isLogin == null) return;



      _showMaterialDialog('บันทักข้อมูลสำเร็จ', '$isLogin');





  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  }







