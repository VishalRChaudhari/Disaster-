import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
       elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About Us 🌍🚀",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "At Sanjeevani, we are committed to making disaster response faster, more efficient, and accessible for everyone. Our mission is to bridge the gap between affected individuals and emergency responders by providing real-time alerts, location-based assistance, and verified resources—all in one platform.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Why We Built This App",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "Disasters strike unexpectedly, and timely action can save lives. Whether it's a natural calamity like earthquakes, floods, or wildfires, or human-made emergencies, Sanjeevani empowers individuals, communities, and authorities to act swiftly.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "What We Offer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildBulletPoint(
                  "✅ Emergency Alerts – Stay informed with real-time disaster warnings."),
              _buildBulletPoint(
                  "✅ SOS Assistance – Send distress signals with one tap."),
              _buildBulletPoint(
                  "✅ Resource Sharing – Access shelters, medical aid, and relief services."),
              _buildBulletPoint(
                  "✅ Community Support – Report incidents and stay updated."),
              SizedBox(height: 20),
              Text(
                "Our Vision",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "We envision a world where technology helps reduce disaster impact, saving lives through rapid coordination and reliable information.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Get Involved",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "Join us in making a difference! If you're a volunteer, emergency service provider, or just someone who cares, you can contribute by sharing information, helping those in need, and spreading awareness.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "🚀 Stay Safe. Stay Prepared.",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(height: 10),
              Text(
                "📩 Contact us at: support@sanjeevaniapp.com",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              Text(
                "🌍 Visit: www.sanjeevaniapp.com",
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
