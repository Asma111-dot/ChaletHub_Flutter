import 'package:chalet_2/components/button.dart';
import 'package:chalet_2/components/custom_appbar.dart';
import 'package:chalet_2/resources/config.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ChaletDetails extends StatefulWidget {
  final Function addToFavorites;
  final Map<String, dynamic> chaletDetails;

  ChaletDetails({required this.addToFavorites, required this.chaletDetails});

  @override
  _ChaletDetailsState createState() => _ChaletDetailsState();
}

class _ChaletDetailsState extends State<ChaletDetails> {
  bool isFav = false;
  late SharedPreferences prefs;

  final List<String> imagePaths = [
    'assets/chalet1.jpg',
    'assets/chalet2.jpg',
    'assets/chalet3.jpg',
    'assets/chalet4.jpg',
    'assets/chalet5.jpg',
    'assets/chalet6.jpg',
    'assets/chalet7.jpg',
    'assets/chalet8.jpg',
    'assets/chalet9.jpg',
    'assets/chalet10.jpg',
  ];

  final List<Map<String, dynamic>> services = [
    {'icon': Icons.sports_soccer, 'text': 'كرة قدم'},
    //  {'icon': Icons.no_smoking, 'text': 'ممنوع التدخين'},
    {'icon': Icons.pool, 'text': 'حوض سباحة'},
    {'icon': Icons.wifi, 'text': 'شبكة انترنت'},
    {'icon': Icons.child_care, 'text': 'حوض سباحة أطفال'},
    {'icon': Icons.videogame_asset, 'text': 'ألعاب'},
    {'icon': Icons.toys, 'text': 'ألعاب أطفال'},
  ];

  final String googleMapsUrl = 'https://maps.app.goo.gl/7TSkpSwwFokkF1HPA';

  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  void _loadFavoriteStatus() async {
    // تحميل حالة المفضلة عند بدء التطبيق
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isFav = prefs.getBool(widget.chaletDetails['name']) ?? false;
    });
  }

  void _toggleFavorite() async {
    // تغيير حالة المفضلة وتخزينها في SharedPreferences
    setState(() {
      isFav = !isFav;
    });
    prefs.setBool(widget.chaletDetails['name'], isFav);
    widget.addToFavorites(widget.chaletDetails['name']);
  }

  @override
  Widget build(BuildContext context) {
    final chaletDetails = widget.chaletDetails;

    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Chalet Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              isFav ? Icons.favorite_rounded : Icons.favorite_outline_outlined,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(height: 200.0, autoPlay: true),
              items: imagePaths.map((path) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(path, fit: BoxFit.cover);
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                chaletDetails['name'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Config.primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.attach_money, color: Config.primaryColor),
                  SizedBox(width: 8),
                  Text('Full Price: ${chaletDetails['price']} RY'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.moneyCheck,
                      color: Config.primaryColor),
                  SizedBox(width: 8),
                  Text('Deposit Price: ${chaletDetails['deposit']} RY'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.group, color: Config.primaryColor),
                  SizedBox(width: 8),
                  Text('Capacity: ${chaletDetails['capacity']} Person'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Config.primaryColor),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Location: Click here to see it on the map',
                      style:
                          TextStyle(fontSize: 15, color: Config.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  if (await canLaunch(googleMapsUrl)) {
                    await launch(googleMapsUrl);
                  } else {
                    throw 'Could not launch $googleMapsUrl';
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.map, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'View on map',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'وصف المنتزة ',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Config.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'يتكون الشالية من ( مجلس مع دورة مياه + غرفة تبديل الملابس + 2 دورة مياة +مطبخ +2جلسات خارجيه +جلسة خشبية + العاب اطغال + حوش مفروش عشب صناعي)',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'سياسات المنتزه',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Config.primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '1)  يتم تأكيد الحجز بدفع العربون(20000 الف ريال) \n'
                '2) عند زيادة العدد يتم دفع مبلغ 2000 على كل شخص\n'
                '3) يتم دفع المبلغ عبر سند رسمي ويتم تسليمه عند الدخول للشاليه\n'
                '4) يتم فتح المسبحة من الساعة 9 صباحا ويغلق الساعة 2 ظهرا\n'
                '5) الرجاء الالتزام بلبس الملابس الخاصه بالسباحه\n'
                '6) يمنع منعا باتا الاكل والشرب داخل المسبح\n'
                '7) لا يتم فتح المسبحة الابعد التوقيع على عقد الايجار ودفع باقي الحساب كاملا\n'
                '8) يتم دفع مبلغ تامين 20 الف او خاتم ذهب\n'
                '9) العربون لايرد في حالة عدم الحضور او الغاء الحجز',
                style: TextStyle(fontSize: 15),
              ),
            ),
            // Divider(),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     'الأسعار',
            //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Text(
            //     'سعر نصف اليوم: 150 ريال\n'
            //     'سعر الخميس والجمعة يوم كامل: 150 ريال\n'
            //     'سعر الخميس والجمعة نصف يوم: 150 ريال',
            //     style: TextStyle(fontSize: 15),
            //   ),
            // ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'الخدمات',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Config.primaryColor),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 1,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(services[index]['icon'],
                          size: 20, color: Config.primaryColor),
                      SizedBox(width: 8),
                      Text(
                        services[index]['text'],
                        style: TextStyle(color: Config.primaryColor),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: 'Book Appointment',
                onPressed: () {
                  // Navigate to booking page
                  Navigator.of(context).pushNamed('booking_page');
                },
                disable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
