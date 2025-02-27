import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String apiKey = 'b111dd48005944e291c3d5ba5ad93003'; // Replace with your News API key
  bool isLoading = true;
  List<dynamic> newsArticles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=in&q=disaster&apiKey=$apiKey';
    
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);  
        if (data['status'] == 'ok' && data['articles'] != null) {
          setState(() {
            newsArticles = data['articles'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print('No news found or failed API response');
        }
      } else {
        // Handle failed response
        setState(() {
          isLoading = false;
        });
        print('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disaster News in India'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : newsArticles.isEmpty
              ? Center(child: Text('No news available'))
              : ListView.builder(
                  itemCount: newsArticles.length,
                  itemBuilder: (context, index) {
                    final article = newsArticles[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(article['title'] ?? 'No Title'),
                        subtitle: Text(article['description'] ?? 'No Description'),
                        onTap: () {
                          // You can implement navigation to the article URL here
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
