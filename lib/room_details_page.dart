import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomDetailsPage extends StatelessWidget {
  final String accessToken;

  RoomDetailsPage({required this.accessToken});

  Future<List<Room>> fetchRooms() async {
    final response = await http.get(
      Uri.parse('https://ethenatx.pythonanywhere.com/management/rooms/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> roomData = json.decode(response.body);
      return roomData.map((data) => Room.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFF59B15)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Rooms',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            color: Color(0xFFF59B15),
            fontSize: 25,
          ),
        ),
      ),
      body: FutureBuilder<List<Room>>(
        future: fetchRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final rooms = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: rooms?.length,
                    shrinkWrap:
                        true, // Allow the GridView to take only the required height
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling for GridView
                    itemBuilder: (context, index) {
                      return RoomCard(room: rooms![index]);
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class Room {
  final String roomNo;
  final int roomCapacity;
  final double roomPrice;
  final String roomCategory;
  final bool occupied;

  Room({
    required this.roomNo,
    required this.roomCapacity,
    required this.roomPrice,
    required this.roomCategory,
    required this.occupied,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomNo: json['Room_No'] ?? '',
      roomCapacity: json['Room_Capacity'] ?? 0,
      roomPrice: (json['Room_Price'] as num?)?.toDouble() ?? 0.0,
      roomCategory: json['Room_Category'] ?? '',
      occupied: json['Occupied'] ?? false,
    );
  }
}

class RoomCard extends StatelessWidget {
  final Room room;

  RoomCard({required this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.all(8.0),
      color: Color(0xFFF59B15).withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room No: ${room.roomNo}',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFF59B15),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text('Capacity: ${room.roomCapacity}'),
            Text('Price: \$${room.roomPrice.toStringAsFixed(2)}'),
            Text('Category: ${room.roomCategory}'),
            Text('Occupied: ${room.occupied ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }
}
