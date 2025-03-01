import 'package:flutter/material.dart';


class Helplinecard extends StatelessWidget {
  Helplinecard(
      {super.key,
      required this.contactname,
      required this.number,
      required this.url,
      required this.phoneCall,
      required this.urlLaunch});

  String contactname;
  String url;
  String number;
   Function(String number) phoneCall;
   Function(String url) urlLaunch;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Name
              Text(
                contactname,
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
                          number,
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          child: Text(
                            url,
                            style: TextStyle(color: Colors.blue.shade400),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          onTap: () => urlLaunch(url),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => phoneCall(number),
                    icon: Icon(Icons.phone, size: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
