import 'package:flutter/material.dart';
import 'package:rebook/room_details_page.dart';

class HomePage extends StatelessWidget {
  final String accessToken;

  HomePage({required this.accessToken});

  Widget _buildCard(String text, String imageUrl) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment(0.00, 0.00),
            image: NetworkImage(imageUrl),
          ),
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black],
            stops: [0, 1],
            begin: Alignment(1, 0),
            end: Alignment(-1, 0),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Align(
                alignment: Alignment(0.00, 0.00),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.00, 0.00),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment(-1.00, 0.00),
              child: Padding(
                padding: EdgeInsets.fromLTRB(35, 30, 0, 30),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF59B15),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCard(
                      'Update Room Prices',
                      'assets/prices.jpg',
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to RoomDetailsPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoomDetailsPage(
                              accessToken: accessToken,
                            ),
                          ),
                        );
                      },
                      child: _buildCard(
                        'Update Rooms Details',
                        'assets/details.jpg',
                      ),
                    ),
                    _buildCard(
                      'View Tenants',
                      'assets/view.jpg',
                    ),
                    _buildCard(
                      'Verify Tenants',
                      'assets/verify.jpg',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
