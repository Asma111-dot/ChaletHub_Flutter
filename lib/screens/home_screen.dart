import 'package:chalet_2/components/available_bookings.dart';
import 'package:chalet_2/components/chalet_card.dart';
import 'package:chalet_2/resources/config.dart';
import 'package:flutter/material.dart';
import 'package:chalet_2/screens/chalet_details_screen.dart'; // استيراد شاشة تفاصيل الشاليه
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  final List<Map<String, dynamic>> _chaletList = List.generate(
    10,
    (index) => {
      'name': 'Chalet $index',
      'price': 100.0 + index * 10,
      'address': 'Address $index'
    },
  ); // قائمة وهمية من الشاليهات

  void addToFavorites(String chaletName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteItems = prefs.getStringList('favorites') ?? [];
    if (!favoriteItems.contains(chaletName)) {
      favoriteItems.add(chaletName);
    }
    await prefs.setStringList('favorites', favoriteItems);
    print('$chaletName added to favorites');
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    List<Map<String, dynamic>> _filteredChaletList = _chaletList
        .where((chalet) =>
            chalet['name'].toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Amanda',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile1.jpg'),
                      ),
                    )
                  ],
                ),
                Config.spaceSmall,
                const Text(
                  'Available bookings',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Config.primaryColor),
                ),
                Config.spaceSmall,
                const AvailableBookings(),
                Config.spaceSmall,
                const Text(
                  'Top Chalet Hub',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Config.primaryColor),
                ),
                Config.spaceSmall,
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Chalets',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (text) {
                    setState(() {
                      _searchText = text;
                    });
                  },
                ),
                Config.spaceSmall,
                Column(
                  children: _filteredChaletList.map((chalet) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChaletDetails(
                              addToFavorites: addToFavorites,
                              chaletDetails: {
                                'name': chalet['name'],
                                'price': chalet['price'],
                                'capacity': 25, // أضف القيمة المناسبة
                                'deposit': 20000, // أضف القيمة المناسبة
                                'location': chalet['address'],
                              },
                            ),
                          ),
                        );
                      },
                      child: ChaletCard(
                        route: 'chalet_details',
                        chaletName: chalet['name'],
                        price: chalet['price'],
                        address: chalet['address'],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
