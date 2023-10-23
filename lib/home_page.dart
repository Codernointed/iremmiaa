import 'package:flutter/material.dart';
import 'package:rebook/room_details_page.dart';

class HomePage extends StatelessWidget {
  final String accessToken;

  const HomePage({super.key, required this.accessToken});

  Widget _buildCard(String text, String imageLoc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: const Alignment(0.00, 0.00),
            image: AssetImage(imageLoc),
          ),
          gradient: const LinearGradient(
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
                alignment: const Alignment(0.00, 0.00),
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
              alignment: const Alignment(0.00, 0.00),
              child: Text(
                text,
                style: const TextStyle(
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
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0), // Adjust padding as needed
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFF59B15)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Row(
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                color: Color(0xFFF59B15),
                fontSize: 25,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: IconButton(
              icon: const Icon(Icons.account_circle,
                  color: Color(0xFFF59B15), size: 35),
              onPressed: () {
                // Add an action to navigate to the profile page here.
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
                height: 20), // Add spacing between AppBar and content
            _buildCard(
              'Update Room Prices',
              'assets/price.jpg',
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
    );
  }
}
