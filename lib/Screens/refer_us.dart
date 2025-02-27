import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ReferUs extends StatelessWidget {
  const ReferUs({super.key});
  final String _referralLink = "https://www.sanjeevaniapp.com";

  void _shareApp(BuildContext context) {
    final String shareText =
        "Help save lives with Sanjeevani! Join our community for disaster preparedness and management. Check it out: $_referralLink";
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer Us"),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Refer Us and Help Save Lives!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 10),
            Text(
              "At Sanjeevani, we believe that every referral counts. By sharing our app with your friends, family, and community, you are helping to build a network of preparedness and support. Our mission is to provide quick access to disaster management tools and information—enabling communities to respond effectively in times of crisis.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text("Why Refer Us?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 10),
            _buildBulletPoint(
                "✅ Empower communities with timely disaster alerts."),
            _buildBulletPoint("✅ Help families stay safe and informed."),
            _buildBulletPoint(
                "✅ Strengthen emergency response through community support."),
            SizedBox(height: 20),
            Text("How to Refer:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 10),
            Text(
              "Tap the share button below to send your referral link via your preferred messaging or social media app. Every share brings us closer to a safer community.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _shareApp(context),
                icon: Icon(Icons.share),
                label: Text("Share Sanjeevani"),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Thank you for helping us make a difference!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
