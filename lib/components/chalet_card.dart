import 'package:chalet_2/resources/config.dart';
import 'package:flutter/material.dart';

class ChaletCard extends StatelessWidget {
  final String route;
  final String chaletName;
  final double price;
  final String address;

  const ChaletCard({
    super.key,
    required this.route,
    required this.chaletName,
    required this.price,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          //redirect to chalet details page
          Navigator.of(context).pushNamed(route);
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage('assets/chalet2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Text(
                chaletName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 10,
              right: 10,
              child: Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Text(
                address,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
