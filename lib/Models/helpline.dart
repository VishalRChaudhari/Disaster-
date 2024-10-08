class Contacts {
  Contacts(this.contactNumber, this.contactName, this.url);
  int contactNumber;
  String contactName;
  String url;
}

final List<Contacts> emergencyContacts = [
  
  Contacts(
    01126701728,
    'National Disaster Management Authority (NDMA)',
    'http://www.ndma.gov.in',
  ),
  Contacts(
    112,
    'National Emergency Response Centre (NERC)',
    '',
  ),
  Contacts(
    02222027990,
    'Maharashtra State Disaster Management Authority (MSDMA)',
    'http://www.maharashtra.gov.in',
  )
];
