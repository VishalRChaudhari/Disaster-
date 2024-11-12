class NewsItem {
  final String title;
  final String content;
  final String date;
  final String location;

  NewsItem({
    required this.title,
    required this.content,
    required this.date,
    required this.location,
  });
}

final List<NewsItem> newsItems = [
  NewsItem(
    title: "Cyclone Biparjoy Expected to Hit Gujarat Coast",
    content:
        "The Indian Meteorological Department has issued a red alert for Gujarat as Cyclone Biparjoy approaches the coast. Heavy rains and strong winds are expected. Residents in vulnerable areas are advised to evacuate, and relief teams have been deployed to ensure safety and support in affected areas.",
    date: "Today, 10:00 AM",
    location: "Gujarat",
  ),
  NewsItem(
    title: "Flood Warning in Assam and Northeast India",
    content:
        "Due to heavy monsoon rains, rivers in Assam and surrounding states have breached their banks, causing flooding in several districts. The government has set up relief camps, and NDRF teams are on the ground to help with evacuation efforts. Residents are advised to move to higher ground and stay informed.",
    date: "November 12, 2024",
    location: "Assam, Northeast India",
  ),
  NewsItem(
    title: "Heatwave Advisory Issued in Northern India",
    content:
        "With record-breaking temperatures in parts of northern India, the health department has issued a heatwave advisory. Citizens are urged to stay hydrated, avoid outdoor activities during peak hours, and look out for symptoms of heat exhaustion and heatstroke. Emergency cooling centers have been opened in key locations.",
    date: "November 11, 2024",
    location: "Northern India",
  ),
  NewsItem(
    title: "Air Quality Hazard in Delhi NCR",
    content:
        "The air quality in Delhi NCR has deteriorated to hazardous levels. Authorities have implemented measures to curb pollution, including restrictions on certain vehicles and construction activities. Citizens are advised to limit outdoor exposure, especially children and those with respiratory issues, and to use masks when necessary.",
    date: "November 10, 2024",
    location: "Delhi NCR",
  ),
  NewsItem(
    title: "Landslide Blocks Highway in Uttarakhand",
    content:
        "A landslide triggered by continuous rainfall has blocked the highway in Uttarakhand, disrupting transport and travel. Efforts are underway to clear the debris, and alternative routes have been arranged. Travelers are advised to check for updates before planning travel to the affected areas.",
    date: "November 9, 2024",
    location: "Uttarakhand",
  ),
  NewsItem(
    title: "Drought Relief Program Announced in Maharashtra",
    content:
        "The Maharashtra government has announced a relief program to support farmers affected by the prolonged drought in Marathwada and Vidarbha regions. The program includes financial assistance, water distribution initiatives, and support for crop loss. Applications for relief are now open.",
    date: "November 8, 2024",
    location: "Maharashtra",
  ),
];
