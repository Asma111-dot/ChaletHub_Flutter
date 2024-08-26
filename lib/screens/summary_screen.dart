import 'package:chalet_2/components/custom_appbar.dart';
import 'package:chalet_2/resources/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:chalet_2/components/button.dart';

class SummaryScreen extends StatefulWidget {
  final DateTime selectedDay;
  final String chaletName;

  SummaryScreen({required this.selectedDay, required this.chaletName});

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE, dd/MM/yyyy').format(widget.selectedDay);

    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Summary & Payment',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/chalet.jpg', // Add your image to the assets folder
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Config.spaceBig,
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.chaletName,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Config.primaryColor),
                  ),
                ),
              ],
            ),
            Config.spaceMedium,
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Config.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Table(
                children: [
                  TableRow(children: [
                    Text(
                      'Day:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Config.primaryColor),
                    ),
                    Text(
                      DateFormat('EEEE').format(widget.selectedDay),
                      style: TextStyle(fontSize: 16),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'Date:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Config.primaryColor),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(widget.selectedDay),
                      style: TextStyle(fontSize: 16),
                    ),
                  ]),
                ],
              ),
            ),
            Config.spaceMedium,
            SizedBox(height: 16),
            Text(
              'Payment Ways:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Config.primaryColor),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet,
                  color: Config.primaryColor),
              title: Text('Payment Method 1'),
              onTap: () {
                setState(() {
                  _selectedPaymentMethod = 'Payment Method 1';
                });
              },
              trailing: _selectedPaymentMethod == 'Payment Method 1'
                  ? Icon(Icons.check_circle, color: Config.primaryColor)
                  : null,
            ),
            ListTile(
              leading: Icon(Icons.credit_card, color: Config.primaryColor),
              title: Text('Payment Method 2'),
              onTap: () {
                setState(() {
                  _selectedPaymentMethod = 'Payment Method 2';
                });
              },
              trailing: _selectedPaymentMethod == 'Payment Method 2'
                  ? Icon(Icons.check_circle, color: Config.primaryColor)
                  : null,
            ),
            ListTile(
              leading: Icon(Icons.attach_money, color: Config.primaryColor),
              title: Text('Floosak'),
              onTap: () {
                setState(() {
                  _selectedPaymentMethod = 'Floosak';
                });
              },
              trailing: _selectedPaymentMethod == 'Floosak'
                  ? Icon(Icons.check_circle, color: Config.primaryColor)
                  : null,
            ),
            Config.spaceSmall,
            SizedBox(height: 16),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Button(
                  width: double.infinity,
                  title: 'Book Now',
                  onPressed: _selectedPaymentMethod != null
                      ? () {
                          // handle booking logic here
                        }
                      : () {}, // Provide an empty function when _selectedPaymentMethod is null
                  disable: _selectedPaymentMethod == null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
