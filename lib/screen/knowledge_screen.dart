import 'dart:convert';
import 'dart:math';

import 'package:bmi_manager/model/naver_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class KnowledgeScreen extends StatefulWidget {
  final String extra;
  const KnowledgeScreen({super.key, required this.extra});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  List<NaverModel> data = [];

  final List<String> _imagePaths_1 = [
    'asset/img/know0.png',
    'asset/img/know1.png',
    'asset/img/know2.png',
    'asset/img/know3.png',
    'asset/img/know4.png',
  ];

  final List<String> _imagePaths_2 = [
    'asset/img/know5.png',
    'asset/img/know6.png',
    'asset/img/know7.png',
    'asset/img/know8.png',
  ];

  final List<String> _imagePaths_3 = [
    'asset/img/know9.png',
    'asset/img/know10.png',
    'asset/img/know11.png',
    'asset/img/know12.png',
  ];

  @override
  void initState() {
    print('oninit build');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('반려견 백과사전')),
        body: FutureBuilder<List<NaverModel>>(
            future: _search(),
            builder: (context, snapshot) {
              if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No data found'),
                );
              }

              final data = snapshot.data!;
              List<String> imageData = [];
              if (widget.extra == '예방접종') {
                imageData = _imagePaths_1;
              } else if (widget.extra == '강아지목욕') {
                imageData = _imagePaths_2;
              } else {
                imageData = _imagePaths_3;
              }

              return ListView.separated(
                  itemBuilder: (ctx, idx) {
                    return GestureDetector(
                      onTap: () {
                        if (data![idx].link != '') {
                          _launchInWebViewWithoutJavaScript(data![idx].link);
                        }
                      },
                      child: ListTile(
                        leading: data![idx].thumbnail == ''
                            ? Image.asset(
                                imageData[Random().nextInt(imageData.length)],
                                width: 50,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                data![idx].thumbnail,
                                width: 50,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                        title: Text(
                          '${removeHtmlTags(data![idx].title)}',
                          style: TextStyle(color: Colors.red),
                        ),
                        subtitle: Text('${removeHtmlTags(data![idx].description)}'),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, idx) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemCount: data.length);
            }));
  }

  Future<List<NaverModel>> _search() async {
    final response = await http.get(
      Uri.parse('https://openapi.naver.com/v1/search/encyc.json?query=${widget.extra}'),
      headers: {
        'X-Naver-Client-Id': dotenv.env['client_id'] ?? '',
        'X-Naver-Client-Secret': dotenv.env['client_secret'] ?? '',
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['items'];
      print(result);
      return data = result.map<NaverModel>((e) => NaverModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }

  String removeHtmlTags(String htmlString) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  Future<void> _launchInWebViewWithoutJavaScript(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);

      await launchUrl(
        Uri.parse('${urlString}'),
      );
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
