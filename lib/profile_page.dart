import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildStats(),
            _buildEditProfileButton(),
            _buildScannedHistoryButton(),
            _buildStatisticsButton(),
            _buildReportBugButton(),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
      alignment: AlignmentDirectional(0.00, -1.00),
      child: Container(
        width: double.infinity,
        height: 235,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff000000), // Replace with your theme colors
              Color(0xffffffff),
            ],
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
                    image: Image.network(
                      'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8c3RhcnJ5JTIwbmlnaHR8ZW58MHx8fHwxNjk5NjY2MzAyfDA&ixlib=rb-4.0.3&q=80&w=1080',
                    ).image,
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
      alignment: AlignmentDirectional(0.95, 1.09),
      child: Switch.adaptive(
        value: true, // Replace with your switch value
        onChanged: (newValue) {},
        activeColor: Color(0xFF959798),
        activeTrackColor: Color(0xFF959798),
        inactiveTrackColor: Colors.white,
        inactiveThumbColor: Colors.black,
      ),
    );
  }

  Widget _buildProfileImage() {
    return Align(
      alignment: AlignmentDirectional(-1.00, 1.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
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
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildUserInfoText('Hostel Name', 'Username'),
        ],
      ),
    );
  }

  Widget _buildUserInfoText(String title, String subtitle) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: AlignmentDirectional(-0.91, -0.92),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
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
      decoration: BoxDecoration(
        color: Colors.white, // Replace with your theme color
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          _buildStatsItem(Icons.bed, '6', 'Rooms'),
          _buildStatsItem(Icons.supervisor_account_rounded, '0', 'Tenants'),
          _buildStatsItem(Icons.door_back_door, '0', 'Occupied'),
        ],
      ),
    );
  }

  Widget _buildStatsItem(IconData icon, String value, String label) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
      child: Container(
        width: 130,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200], // Replace with your theme color
          boxShadow: [
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
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Icon(
                icon,
                color: Color(0xFFF59B15), // Replace with your theme color
                size: 30,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.black, // Replace with your theme color
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.grey, // Replace with your theme color
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

  Widget _buildEditProfileButton() {
    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Replace with your theme color
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          alignment: AlignmentDirectional(0.00, 0.00),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Icon(
                  Icons.edit,
                  color: Colors.grey, // Replace with your theme color
                ),
              ),
              Expanded(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    color: Colors.black, // Replace with your theme color
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

  Widget _buildScannedHistoryButton() {
    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Replace with your theme color
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          alignment: AlignmentDirectional(0.00, 0.00),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.grey, // Replace with your theme color
                ),
              ),
              Expanded(
                child: Text(
                  'Scanned History',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    color: Colors.black, // Replace with your theme color
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

  Widget _buildStatisticsButton() {
    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Replace with your theme color
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          alignment: AlignmentDirectional(0.00, 0.00),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Icon(
                  Icons.insert_chart_outlined_outlined,
                  color: Colors.grey, // Replace with your theme color
                ),
              ),
              Expanded(
                child: Text(
                  'Statistics',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    color: Colors.black, // Replace with your theme color
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

  Widget _buildReportBugButton() {
    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Replace with your theme color
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          alignment: AlignmentDirectional(0.00, 0.00),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Icon(
                  Icons.bug_report_rounded,
                  color: Colors.grey, // Replace with your theme color
                ),
              ),
              Expanded(
                child: Text(
                  'Report an issue or bug',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    color: Colors.black, // Replace with your theme color
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

  Widget _buildLogoutButton() {
    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFFF59B15), // Replace with your theme color
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: AlignmentDirectional(0.00, 0.00),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Icon(
                  Icons.logout,
                  size: 20,
                ),
              ),
              Expanded(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 15,
                    color: Colors.black, // Replace with your theme color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
