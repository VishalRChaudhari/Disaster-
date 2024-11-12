import 'package:disastermanagement/data/news_data.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        return NewsExpansionTile(newsItem: newsItems[index]);
      },
    );
  }
}

class NewsExpansionTile extends StatelessWidget {
  final NewsItem newsItem;

  const NewsExpansionTile({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, top: 10, bottom: 10, right: 8),
      child: ExpansionTile(
        title: Text(newsItem.title),
        subtitle: Text(newsItem.date),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (newsItem.location.isNotEmpty)
                  Text(
                    "Location: ${newsItem.location}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 8),
                Text(newsItem.content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
