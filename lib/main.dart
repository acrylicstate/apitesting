import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  Future<void> insertrecord() async{
    if(name.text != "" || email.text != "" || password.text != "")
      {
          String uri = "http://10.0.2.2/practice_api/insert_record.php";
          var res=await http.post(Uri.parse(uri),body: {
            "name" :name.text,
            "email" :email.text,
            "password" :password.text
          });

          var response=jsonDecode(res.body);
          if(response["success"] == 'true')
          {
            print("Record Inserted");
          }
          else
          print("Some issue");
      }
    else print("Please Fill all fields");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Record'),
      ),
      body:  Column(children: [
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Enter the name')
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: email,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter the Email')
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: password,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter the Password')
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              insertrecord();
            },
            child: Text('Insert'),
          ),
        )
      ])
    );
  }
}
