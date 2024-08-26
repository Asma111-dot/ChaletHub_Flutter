import 'dart:io';
import 'package:chalet_2/resources/config.dart';
import 'package:chalet_2/screens/policies_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_screen.dart'; // Import the Favorites screen
//import 'chalet_details_screen.dart'; // Import the Chalet Details screen

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<String> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteItems = prefs.getStringList('favoriteItems') ?? [];
    });
  }

  void addToFavorites(String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteItems.add(item);
    });
    await prefs.setStringList('favoriteItems', favoriteItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Chalet Hub',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  UserHeader(name: 'Asmaa  '),
                  SizedBox(height: 16),
                  MenuItem(
                    text: 'Personal Data',
                    icon: FontAwesomeIcons.user,
                    onTap: () {},
                  ),
                  MenuItem(
                    text: 'Favorites',
                    icon: FontAwesomeIcons.heart,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FavoritesScreen(favoriteItems: favoriteItems),
                        ),
                      );
                    },
                  ),
                  MenuItem(
                    text: 'Policies and Terms',
                    icon: FontAwesomeIcons.fileContract,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PoliciesScreen(),
                        ),
                      );
                    },
                  ),
                  MenuItem(
                    text: 'Submit a Complaint or Suggestion',
                    icon: FontAwesomeIcons.commentDots,
                    onTap: () {
                      _showComplaintBottomSheet(context);
                    },
                  ),
                  MenuItem(
                    text: 'Communication Channels and Technical Support',
                    icon: FontAwesomeIcons.headset,
                    onTap: () {
                      _showCommunicationBottomSheet(context);
                    },
                  ),
                  MenuItem(
                    text: 'Log Out',
                    icon: FontAwesomeIcons.signOutAlt,
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                  SocialMediaIcons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Confirm Logout',
            style: TextStyle(color: Config.primaryColor),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            OutlinedButton(
              child:
                  Text('Cancel', style: TextStyle(color: Config.primaryColor)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Config.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child:
                  Text('Log Out', style: TextStyle(color: Config.primaryColor)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Config.primaryColor),
                backgroundColor: Colors.blue.shade900.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () {
                exit(0); // Close the app
              },
            ),
          ],
        );
      },
    );
  }

  void _showComplaintBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Submit a Complaint or Suggestion',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Config.primaryColor),
                ),
                SizedBox(height: 10),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your complaint or suggestion here',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add your submission logic here
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Config.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCommunicationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Config.primaryColor),
                ),
                SizedBox(height: 10),
                Text(
                  'If you encounter any issues or have suggestions to improve the service, you can contact us via WhatsApp at:',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                SelectableText(
                  '+775421110',
                  style: TextStyle(
                      fontSize: 18,
                      color: Config.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    String url = 'https://wa.me/775421110';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text(
                    'Contact via WhatsApp',
                    style: TextStyle(color: Config.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserHeader extends StatelessWidget {
  final String name;

  UserHeader({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Config.primaryColor,
          radius: 40,
          child: Icon(
            FontAwesomeIcons.user,
            size: 40,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 20)),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  MenuItem({required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Config.primaryColor,
      ),
      title: Text(
        text,
      ),
      trailing: Icon(
        Icons.arrow_forward,
        color: Config.primaryColor,
      ),
      onTap: onTap,
    );
  }
}

class SocialMediaIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Config.primaryColor,
      child: Column(
        children: [
          Text(
            'Chalet Hub!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
                onPressed: () {
                  _launchURL('https://wa.me/+967775421110');
                },
              ),
              SizedBox(width: 16),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
                onPressed: () {
                  _launchURL('https://www.instagram.com/yourprofile');
                },
              ),
              SizedBox(width: 16),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                onPressed: () {
                  _launchURL('https://www.facebook.com/yourpage');
                },
              ),
              SizedBox(width: 16),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
                onPressed: () {
                  _launchURL('https://www.linkedin.com/in/yourprofile');
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Follow us on social media',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
