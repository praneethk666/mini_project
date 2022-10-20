import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'delay.dart';
class apiSeviceGet{
  Future<PostResponse>getApi(String id,context) async{
    var url = Uri.parse('http://192.168.29.119:4001/apii/user/delete/$id');
    SnackBar snackBar = const SnackBar(
      content: Text("Checking QR",
        style: TextStyle(
          fontSize: 25,
          color: Colors.black87,
        ),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    );
    await delay(3);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    var response = await http.delete(url,headers:{
      'Accept': 'application/json',
      'Content-Type' : 'application/json',
    });
    print('Response code:${response.statusCode}');
    //print(response.body);
    final data = jsonDecode(response.body);
    return PostResponse(name: data["name"], id:data["_id"]);

  }
}
class PostResponse{
  final String name;
  final String id;
  PostResponse({
    required this.name,required this.id
  });
}

