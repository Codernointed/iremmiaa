import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  final String accessToken;

  const EditProfilePage({Key? key, required this.accessToken})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController hostelNameController = TextEditingController();
  TextEditingController managerContactController = TextEditingController();
  TextEditingController hostelContactController = TextEditingController();
  TextEditingController mobileMoneyController = TextEditingController();
  TextEditingController startPriceController = TextEditingController();
  TextEditingController endPriceController = TextEditingController();
  TextEditingController mainWebsiteController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch data from API and populate the fields
    fetchAndPopulateData();
  }

  Future<void> fetchAndPopulateData() async {
    final url =
        'https://ethenatx.pythonanywhere.com/management/management-profile/';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Get the price range
        String priceRange = data['price_range'];

        // Split the price range
        List<String> prices = priceRange.split('-');

        setState(() {
          hostelNameController.text = data['hostel_name'] ?? '';
          managerContactController.text = data['manager_contact'] ?? '';
          hostelContactController.text = data['hostel_contact'] ?? '';
          mobileMoneyController.text = data['mobile_money'] ?? '';
          // Set the start and end price controllers
          startPriceController.text = prices[0];
          endPriceController.text = prices[1];
          mainWebsiteController.text = data['main_website'];
          locationController.text = data['location'] ?? '';
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle the error appropriately
    }
  }

  Future<void> updateProfile() async {
    String priceRange =
        '${startPriceController.text}-${endPriceController.text}';
    final url =
        'https://ethenatx.pythonanywhere.com/management/management-profile/';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "hostel_name": hostelNameController.text,
          "manager_contact": managerContactController.text,
          "hostel_contact": hostelContactController.text,
          "mobile_money": mobileMoneyController.text,
          "price_range": priceRange,
          "main_website": mainWebsiteController.text,
          "location": locationController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Profile updated successfully
        // You might want to navigate back or show a success message
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print('Error updating profile: $e');
      // Handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF59B15)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFFF59B15),
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTextField('Hostel Name', hostelNameController),
                    _buildTextField(
                        'Manager Contact', managerContactController),
                    _buildTextField('Hostel Contact', hostelContactController),
                    _buildTextField('Mobile Money', mobileMoneyController),
                    _buildPriceRangeFields(),
                    _buildTextField('Main Website', mainWebsiteController),
                    _buildTextField('Main Website', mainWebsiteController),
                    _buildTextField('Main Website', mainWebsiteController),
                    _buildTextField('Main Website', mainWebsiteController),
                    _buildTextField('Main Website', mainWebsiteController),
                    _buildTextField('Main Website', mainWebsiteController),
                    _buildTextField('Location', locationController),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: updateProfile,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Update Profile', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      FaIcon(FontAwesomeIcons.solidFloppyDisk, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }

  Widget _buildPriceRangeFields() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildTextField('Start Price', startPriceController),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _buildTextField('End Price', endPriceController),
          ),
        ],
      ),
    );
  }
}
