// ignore_for_file: library_private_types_in_public_api

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rebook/profile_page.dart';

class RoomPricesPage extends StatefulWidget {
  final String accessToken;

  const RoomPricesPage({super.key, required this.accessToken});

  @override
  _RoomPricesPageState createState() => _RoomPricesPageState();
}

class _RoomPricesPageState extends State<RoomPricesPage> {
  List<String> availableCapacities = [];
  String selectedCapacity = '';
  final TextEditingController _textEditingController = TextEditingController();

  double newPrice = 0.0;
  final apiUrl = Uri.parse(
      'https://ethenatx.pythonanywhere.com/management/update-room-price/');
  List<EditedEntry> editedEntries = [];

  @override
  void initState() {
    super.initState();
    fetchRoomData();
  }

  Future<void> fetchRoomData() async {
    try {
      final roomsResponse = await http.get(
        Uri.parse('https://ethenatx.pythonanywhere.com/management/rooms/'),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      if (roomsResponse.statusCode == 200) {
        final rooms = json.decode(roomsResponse.body) as List;
        availableCapacities = rooms
            .map((room) => room['room_capacity'].toString())
            .toSet()
            .toList();
        availableCapacities.insert(0, '...');
        // Sort the list in ascending order.
        availableCapacities.sort();

        if (availableCapacities.isNotEmpty) {
          setState(() {
            selectedCapacity = availableCapacities.first;
          });
        }
      } else {
        showSnackBar('Failed to fetch room data');
      }
    } catch (e) {
      showSnackBar('An error occurred. Please check your network connection.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF59B15)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Edit Room Prices',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFFF59B15),
            fontSize: 21,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: IconButton(
              icon: const Icon(Icons.account_circle,
                  color: Color(0xFFF59B15), size: 35),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            buildSectionTitle('Select room capacity to edit', 18),
            const SizedBox(height: 15.0),
            buildDropdown(),
            const SizedBox(height: 30.0),
            buildSectionTitle('Enter the new room price', 18),
            const SizedBox(height: 10.0),
            buildPriceInput(),
            const SizedBox(height: 20.0),
            buildApplyButton(),
            const SizedBox(height: 20.0),
            buildSectionTitle('History edited rooms:', 19),
            const SizedBox(height: 11.0),
            buildSectionTitle('disappears when you exit the page', 14),
            const SizedBox(height: 20.0),
            buildEditedEntriesList(),
            buildDeleteAllChangesButton(),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, double fontSizeValue) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSizeValue,
        ),
      ),
    );
  }

  Widget buildDropdown() {
    return DropdownButton<String>(
      isDense: true,
      isExpanded: true,
      value: selectedCapacity,
      onChanged: (String? newValue) {
        setState(() {
          selectedCapacity = newValue ?? '...';
        });
      },
      items: availableCapacities.map((capacity) {
        return DropdownMenuItem<String>(
          value: capacity,
          child: Text('Capacity $capacity'),
        );
      }).toList(),
    );
  }

  Widget buildPriceInput() {
    return Row(
      children: <Widget>[
        const Text('GH₵'),
        Expanded(
          child: TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                newPrice = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildApplyButton() {
    bool isPriceEntered = newPrice > 0.0;

    return SizedBox(
      width: double.infinity,
      height: 35,
      child: ElevatedButton(
        onPressed: isPriceEntered
            ? () async {
                if (selectedCapacity != '...') {
                  if (await updateRoomPrices()) {
                    setState(() {
                      editedEntries.add(EditedEntry(
                        capacity: int.parse(selectedCapacity),
                        newPrice: newPrice,
                      ));
                      _textEditingController.text = '';
                      newPrice = 0.0; // Reset newPrice
                      selectedCapacity = '...'; // Reset selectedCapacity
                    });
                  }
                } else {
                  showSnackBar('Select Room Capacity');
                }
              }
            : null, // Disable button when room price is not entered
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Apply Changes', style: TextStyle(fontSize: 16)),
            SizedBox(width: 5),
            FaIcon(FontAwesomeIcons.solidFloppyDisk, size: 18),
          ],
        ),
      ),
    );
  }

  Widget buildEditedEntriesList() {
    // print('Rebuilding edited entries list.');
    // print(editedEntries);

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: editedEntries.length,
        itemBuilder: (context, index) {
          final entry = editedEntries[index];
          return Card(
            child: ListTile(
              title: Text('Capacity ${entry.capacity}',
                  style: const TextStyle(fontSize: 18)),
              subtitle: Text(
                'New Price: GH₵${entry.newPrice.toStringAsFixed(2)}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Color(0xFFF59B15)),
                onPressed: () {
                  setState(() {
                    editedEntries.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildDeleteAllChangesButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SizedBox(
          width: double.infinity,
          height: 35,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                editedEntries.clear();
              });
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Delete All Changes', style: TextStyle(fontSize: 16)),
                SizedBox(width: 5),
                Icon(Icons.delete, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> updateRoomPrices() async {
    try {
      final response = await http.put(
        apiUrl,
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'room_capacity': selectedCapacity,
          'new_price': newPrice,
        }),
      );

      final responseJson = json.decode(response.body);
      (responseJson["message"]);

      // print(response.statusCode);
      showSnackBar(responseJson["message"]);
      return true;
    } catch (e) {
      showSnackBar('An error occurred. Please check your network connection.');
      return false;
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

class EditedEntry {
  final int capacity;
  final double newPrice;

  EditedEntry({
    required this.capacity,
    required this.newPrice,
  });
}
