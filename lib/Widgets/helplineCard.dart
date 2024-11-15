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
    Contacts? contact;

    Future<void> _launchUrl() async {
      final Uri url = Uri.parse(contact!.url);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final contacts in emergencyContacts)
            Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //contact name
                      Text(
                        contacts.contactName,
                      ),
                      //number
                      Text(
                        contacts.contactNumber.toString(),
                      ),
                      //link
                      TextButton(
                        child: Text(
                          contacts.url,
                        ),
                        onPressed: () => _launchUrl(),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
