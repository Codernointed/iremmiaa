import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String accessToken;

  const ProfilePage({Key? key, required this.accessToken}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String hostelName = '';
  String managerName = '';
  String managerProfilePicture = '';
  String hostelImage = '';
  int numberOfRooms = 0;
  int numberOfTenants = 0;
  int numberOfRoomsOccupied = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url =
        'https://ethenatx.pythonanywhere.com/management/management-profile/';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          hostelName = data['hostel_name'] ?? '';
          managerName = data['manager'] ?? '';
          numberOfRooms = data['number_of_rooms'] ?? 0;
          numberOfTenants = data['number_of_tenants'] ?? 0;
          numberOfRoomsOccupied = data['number_rooms_occupied'] ?? 0;
          final baseUrl = 'https://ethenatx.pythonanywhere.com';
          managerProfilePicture =
              '$baseUrl${data['hostel_manager_profile_picture']}';
          hostelImage = '$baseUrl${data['hostel_image']}';
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildStats(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      accessToken: widget.accessToken,
                    ),
                  ),
                );
              },
              child: _buildButton('Edit Profile', Icons.edit),
            ),
            _buildButton('Scanned History', Icons.qr_code_scanner_rounded),
            _buildButton('Statistics', Icons.insert_chart_outlined_outlined),
            _buildButton('Report an issue or bug', Icons.bug_report_rounded),
            _buildButton('Logout', Icons.logout, color: Colors.amber),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 267,
      child: Stack(
        children: [
          _buildBackgroundImage(),
          _buildSwitch(),
          _buildProfileImage(),
          _buildUserInfo(),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Align(
      alignment: const AlignmentDirectional(0.00, -1.00),
      child: Container(
        width: double.infinity,
        height: 235,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff000000), Color(0xffffffff)],
            stops: [0, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(0, 1),
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(hostelImage),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch() {
    return Align(
      alignment: const AlignmentDirectional(0.95, 1.09),
      child: Switch.adaptive(
        value: true,
        onChanged: (newValue) {},
        activeColor: const Color(0xFF959798),
        activeTrackColor: const Color(0xFF959798),
        inactiveTrackColor: Colors.white,
        inactiveThumbColor: Colors.black,
      ),
    );
  }

  Widget _buildProfileImage() {
    return Align(
      alignment: const AlignmentDirectional(-1.00, 1.00),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            managerProfilePicture,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Align(
      alignment: const AlignmentDirectional(0.00, 0.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildUserInfoText(hostelName, managerName),
        ],
      ),
    );
  }

  Widget _buildUserInfoText(String title, String subtitle) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontFamily: 'Outfit',
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: const AlignmentDirectional(-0.91, -0.8),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      width: double.infinity,
      height: 106,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          _buildStatsItem(Icons.bed, numberOfRooms.toString(), 'Rooms'),
          _buildStatsItem(Icons.supervisor_account_rounded,
              numberOfTenants.toString(), 'Tenants'),
          _buildStatsItem(Icons.door_back_door,
              numberOfRoomsOccupied.toString(), 'Occupied'),
        ],
      ),
    );
  }

  Widget _buildStatsItem(IconData icon, String value, String label) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
      child: Container(
        width: 130,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x34090F13),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Icon(
                icon,
                color: const Color(0xFFF59B15),
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, {Color? color}) {
    return Align(
      alignment: const AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: color ?? Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Icon(
                  icon,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
