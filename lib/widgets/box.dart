import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Message {
  final int id;
  final String sender;
  final String receiver;
  final String body;
  final String stat;
  final DateTime date;

  Message({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.body,
    required this.stat,
    required this.date,
  });
}

class MyApp3 extends StatefulWidget {
  @override
  _MyApp3State createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {
  final Box _boxUser = Hive.box("user");
  List<Map<String, dynamic>> messages = [];
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.1.77:3000/targets/${_boxUser.get('numero')}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        messages = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Message> parseMessages(List<Map<String, dynamic>> jsonMessages) {
    return jsonMessages.map((jsonMessage) {
      return Message(
        id: jsonMessage['id'],
        sender: jsonMessage['sender'],
        receiver: jsonMessage['receiver'],
        body: jsonMessage['body'],
        stat: jsonMessage['stat'],
        date: DateTime.parse(jsonMessage['date']),
      );
    }).toList();
  }

  Widget getIcon(Message message, String currentUser) {
    if (message.sender == currentUser) {
      return Icon(FontAwesomeIcons.sun, color: Colors.yellow);
    } else {
      if (message.stat == 'true') {
        return Icon(FontAwesomeIcons.car, color: Colors.blue);
      } else {
        return Icon(FontAwesomeIcons.tree, color: Colors.green);
      }
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await fetchData();

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String currentUser = _boxUser.get('numero'); // L'utilisateur courant
    final List<Message> parsedMessages = parseMessages(messages);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text('Message List'),
        ),
        body: RefreshIndicator(
          onRefresh: handleRefresh,
          child: Padding(
            padding: EdgeInsets.all(16.0), // Ajustez la valeur selon vos préférences
            child: ListView.builder(
              itemCount: parsedMessages.length,
              itemBuilder: (context, index) {
                final Message message = parsedMessages[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: getIcon(message, currentUser), backgroundColor: Colors.transparent,),
                    title: Text(message.body),
                    subtitle: Text(message.date.toString()),
                  ),
                );
              },
            ),
          ),
        ),

      ),
    );
  }
}
