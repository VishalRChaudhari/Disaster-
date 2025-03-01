import 'package:disastermanagement/Models/helpline.dart';
import 'package:disastermanagement/Widgets/helplinecard.dart';
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
  final TextEditingController searchcontroller = TextEditingController();
  List<Contacts> filteredcontacts = [];
  @override
  Widget build(BuildContext context) {
    void _launchUrl(String url) async {
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

    void searchedHelplines(String keyword) {
      for (final contacts in emergencyContacts) {
        if (keyword == contacts.contactName) {
          filteredcontacts.add(contacts);
        }
        for (final contact in filteredcontacts) {
          Helplinecard(
            contactname: contact.contactName,
            number: contact.contactNumber.toString(),
            url: contact.url,
            phoneCall: (number) {
              _makePhoneCall(contact.contactNumber.toString());
            },
            urlLaunch: (url) {
              _launchUrl(contact.url);
            },
          );
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          //Search bar
          TextField(
            
            controller: searchcontroller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(12),
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          
          for (final contacts in emergencyContacts)
            Helplinecard(
              contactname: contacts.contactName,
              number: contacts.contactNumber.toString(),
              url: contacts.url,
              phoneCall: (number) {
                _makePhoneCall(contacts.contactNumber.toString());
              },
              urlLaunch: (url) {
                _launchUrl(contacts.url);
              },
            ),
        ],
      ),
    );
  }
}
