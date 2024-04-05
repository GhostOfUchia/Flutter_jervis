import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Jarvis extends StatefulWidget {
  const Jarvis({super.key});

  @override
  State<Jarvis> createState() => _JarvisState();
}

class _JarvisState extends State<Jarvis> {
  ChatUser mySelf = ChatUser(id: '1', firstName: 'AmitSaini');
  ChatUser jarvis = ChatUser(id: '2', firstName: 'jarvis');

  final myUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyD_t_hTHy-ecZEeX0ztADP20FEasO8LNwA";
  final header = {'Content-Type': 'application/json'};
  List<ChatMessage> allMessage = [];
  List<ChatUser> userList = [];

  getData(ChatMessage m) async {
    userList.add(jarvis);
    allMessage.insert(0, m);
    setState(() {});
    var body = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };
    await http
        .post(Uri.parse(myUrl), headers: header, body: jsonEncode(body))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        print(result['candidates'][0]['content']['parts'][0]['text']);

        ChatMessage cm = ChatMessage(
            text: result['candidates'][0]['content']['parts'][0]['text'],
            user: jarvis,
            createdAt: DateTime.now());
        allMessage.insert(0, cm);
        setState(() {});
        userList.remove(jarvis);
      }

      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error"),
        ));
      }
    }).catchError((e) {
      print(e.toString());
      userList.remove(jarvis);
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMessage = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Jarvis"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: DashChat(
            typingUsers: userList,
            currentUser: mySelf,
            onSend: (ChatMessage message) {
              getData(message);
            },
            messages: allMessage,
          ),
        ),
      ),
    );
  }
}
