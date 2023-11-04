import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomPricesPage extends StatefulWidget {
  final String accessToken;

  RoomPricesPage({required this.accessToken});

  @override
  _RoomPricesPageState createState() => _RoomPricesPageState();
}

class _RoomPricesPageState extends State<RoomPricesPage> {
  List<String> availableCapacities = [];
  String selectedCapacity = '1';
  double newPrice = 0.0;
  final apiUrl = Uri.parse(
      'https://ethenatx.pythonanywhere.com/management/update-room-price/');
  List<EditedEntry> editedEntries = [];

  @override
  void initState() {
    super.initState();
    fetchAvailableCapacities();
  }

  Future<void> fetchAvailableCapacities() async {
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

        if (availableCapacities.isNotEmpty) {
          setState(() {
            selectedCapacity = availableCapacities.first;
          });
        }
      } else {
        showSnackBar('Failed to fetch available capacities');
      }
    } catch (e) {
      showSnackBar('An error occurred. Please check your network connection.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFF59B15)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
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
              icon: Icon(Icons.account_circle,
                  color: Color(0xFFF59B15), size: 35),
              onPressed: () {
                // Navigate to the profile page here.
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            buildSectionTitle('Select room capacity to edit'),
            const SizedBox(height: 15.0),
            buildDropdown(),
            const SizedBox(height: 30.0),
            buildSectionTitle('Enter the new room price'),
            const SizedBox(height: 10.0),
            buildPriceInput(),
            const SizedBox(height: 20.0),
            buildApplyButton(),
            const SizedBox(height: 20.0),
            buildEditedEntriesList(),
            buildUndoAllChangesButton(),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
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
          selectedCapacity = newValue ?? '1';
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
    return Container(
      width: double.infinity,
      height: 35,
      child: ElevatedButton(
        onPressed: () async {
          if (await updateRoomPrices()) {
            final oldPrice = await getOldRoomPrice();
            editedEntries.add(EditedEntry(
              capacity: int.parse(selectedCapacity),
              oldPrice: oldPrice,
              newPrice: newPrice,
            ));
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Apply Changes'),
            SizedBox(width: 5),
            const FaIcon(FontAwesomeIcons.solidFloppyDisk, size: 18),
          ],
        ),
      ),
    );
  }

  Widget buildEditedEntriesList() {
    return Expanded(
      child: Column(
        children: [
          ListView.builder(
            itemCount: editedEntries.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final entry = editedEntries[index];
              return Card(
                child: ListTile(
                  title: Text('Capacity ${entry.capacity}',
                      style: TextStyle(fontSize: 18)),
                  subtitle: Text(
                    'Old Price: \$${entry.oldPrice.toStringAsFixed(2)}\nNew Price: \$${entry.newPrice.toStringAsFixed(2)}',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildUndoAllChangesButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Container(
          width: double.infinity,
          height: 35,
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Undo All Changes'),
                SizedBox(width: 5),
                const FaIcon(FontAwesomeIcons.arrowRotateLeft, size: 18),
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
      return response.statusCode == 200;
    } catch (e) {
      showSnackBar('An error occurred. Please check your network connection.');
      return false;
    }
  }

  Future<double> getOldRoomPrice() async {
    try {
      final roomsResponse = await http.get(
        Uri.parse('https://ethenatx.pythonanywhere.com/management/rooms/'),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
        },
      );

      if (roomsResponse.statusCode == 200) {
        final rooms = json.decode(roomsResponse.body) as List;
        final room = rooms.firstWhere(
          (room) => room['room_capacity'] == selectedCapacity,
          orElse: () => {},
        );

        if (room.isNotEmpty) {
          return double.tryParse(room['room_price'].toString()) ?? 0.0;
        }
      }
    } catch (e) {
      showSnackBar('An error occurred. Please check your network connection.');
    }
    return 0.0;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

class EditedEntry {
  final int capacity;
  final double oldPrice;
  final double newPrice;

  EditedEntry(
      {required this.capacity, required this.oldPrice, required this.newPrice});
}