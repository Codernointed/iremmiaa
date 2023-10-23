import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomDetailsPage extends StatelessWidget {
  final String accessToken;

  const RoomDetailsPage({super.key, required this.accessToken});

  // Future<List<Room>> fetchRooms() async {
  //   final response = await http.get(
  //     Uri.parse('https://ethenatx.pythonanywhere.com/management/rooms/'),
  //     headers: {
  //       'Authorization': 'Bearer $accessToken',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final List<dynamic> roomData = json.decode(response.body);
  //     print('Confirming: ${accessToken}');
  //     return roomData.map((data) => Room.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Failed to load rooms');
  //   }
  // }

  Future<List<Room>> fetchRooms() async {
    final response = await http.get(
      Uri.parse('https://ethenatx.pythonanywhere.com/management/rooms/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Cookie': 'Cookie_1=value; csrftoken=Pwf0DK0kZJLNbDlVx6F5uvpipzfROgbb',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> roomData = json.decode(response.body);
      final List<Room> rooms = [];

      for (final roomJson in roomData) {
        final room = Room.fromJson(roomJson);
        rooms.add(room);
      }
      print('Response body: ${response.body}');
      print('Status code: ${response.statusCode}');

      return rooms;
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
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF59B15)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Rooms',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            color: Color(0xFFF59B15),
            fontSize: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                0, 0, 30, 0), // Adjust padding as needed
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
      body: FutureBuilder<List<Room>>(
        future: fetchRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFFF59B15)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final rooms = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: rooms?.length,
                    shrinkWrap:
                        true, // Allow the GridView to take only the required height
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable scrolling for GridView
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
  final bool occupied;

  Room({
    required this.roomNo,
    required this.roomCapacity,
    required this.roomPrice,
    required this.occupied,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomNo: json['room_no'] ?? '',
      roomCapacity: json['room_capacity'] ?? 0,
      roomPrice: double.parse(json['room_price']),
      occupied: json['occupied'] ?? false,
    );
  }
}

class RoomCard extends StatelessWidget {
  final Room room;

  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(8.0),
      color: const Color(0xFFF59B15).withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room No: ${room.roomNo}',
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFFF59B15),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Capacity: ${room.roomCapacity}'),
            Text('Price: GH₵${room.roomPrice.toStringAsFixed(2)}'),
            Text('Occupied: ${room.occupied ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }
}
