import 'package:disastermanagement/Models/helpline.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCard extends StatefulWidget {
  const HelpCard({
    super.key,
  });

  @override
  State<HelpCard> createState() => _HelpCard();
}

class _HelpCard extends State<HelpCard> {
  @override
  Widget build(BuildContext context) {
    _launchUrl(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        //dialog box : print("Could not launch $url");
      }
    }

    void _makePhoneCall(String phoneNumber) async {
      final Uri url = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        //dialog box adding
      }
    }

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final contacts in emergencyContacts)
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Contact Name
                      Text(
                        contacts.contactName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      // Number and URL Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contacts.contactNumber.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                GestureDetector(
                                  child: Text(
                                    contacts.url,
                                    style:
                                        TextStyle(color: Colors.blue.shade400),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  onTap: () => _launchUrl(contacts.url),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => _makePhoneCall(
                                contacts.contactNumber.toString()),
                            icon: Icon(Icons.phone, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
