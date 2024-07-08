import 'dart:convert';

import 'package:bmi_manager/model/naver_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  @override
  void initState() {
    print('oninit build');
    _search('rrr');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }

  Future<void> _search(String query) async {
    final response = await http.get(
      Uri.parse('https://openapi.naver.com/v1/search/encyc.json?query=강아지백과사전'),
      headers: {
        'X-Naver-Client-Id': dotenv.env['client_id'] ?? '',
        'X-Naver-Client-Secret': dotenv.env['client_secret'] ?? '',
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['items'];
      print(result);
      List<NaverModel> data = result
          .map<NaverModel>(
              (e) => NaverModel(title: e.title, link: e.link, description: e.description, thumbnail: e.thumbnail))
          .toList();
      print(data[0]);
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
