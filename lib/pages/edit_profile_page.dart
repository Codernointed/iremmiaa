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
  TextEditingController priceRangeController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  List<String> priceRanges = ["2003-56006", "3000-6000", "5000-10000"];

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
        setState(() {
          hostelNameController.text = data['hostel_name'] ?? '';
          managerContactController.text = data['manager_contact'] ?? '';
          hostelContactController.text = data['hostel_contact'] ?? '';
          mobileMoneyController.text = data['mobile_money'] ?? '';
          priceRangeController.text = data['price_range'] ?? '';
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
          "price_range": priceRangeController.text,
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
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTextField('Hostel Name', hostelNameController),
            _buildTextField('Manager Contact', managerContactController),
            _buildTextField('Hostel Contact', hostelContactController),
            _buildTextField('Mobile Money', mobileMoneyController),
            _buildDropdownField(
                'Price Range', priceRanges, priceRangeController),
            _buildTextField('Location', locationController),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                onPressed: updateProfile,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Update Profile', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 5),
                    FaIcon(FontAwesomeIcons.solidFloppyDisk, size: 18),
                  ],
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
          // border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String label, List<String> items, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: controller.text,
        onChanged: (newValue) {
          setState(() {
            controller.text = newValue!;
          });
        },
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
