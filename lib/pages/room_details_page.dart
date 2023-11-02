import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomDetailsPage extends StatefulWidget {
  final String accessToken;

  const RoomDetailsPage({Key? key, required this.accessToken})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  String searchText = '';
  int selectedCapacity = 0;
  bool showOccupiedOnly = false;

  List<Room> rooms = [];
  List<Room> filteredRooms = [];

  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  void filterRooms() {
    setState(() {
      filteredRooms = rooms.where((room) {
        final matchesSearch =
            room.roomNo.toLowerCase().contains(searchText.toLowerCase());
        final matchesCapacity =
            selectedCapacity == 0 || room.roomCapacity == selectedCapacity;
        final matchesOccupancy = !showOccupiedOnly || room.occupied;

        return matchesSearch && matchesCapacity && matchesOccupancy;
      }).toList();
    });
  }

  Future<void> fetchRooms() async {
    final response = await http.get(
      Uri.parse('https://ethenatx.pythonanywhere.com/management/rooms/'),
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      print("RES: $response.body");
      final List<dynamic> roomData = json.decode(response.body);
      print("RESpo: $roomData");

      rooms = roomData.map((roomJson) => Room.fromJson(roomJson)).toList();
      print("filter: $rooms");
      filteredRooms = List.from(rooms);
      setState(() {});
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  void updateRoom(Room updatedRoom) {
    // Find and update the room in the list.
    final index = rooms.indexWhere((room) => room.roomId == updatedRoom.roomId);
    if (index != -1) {
      setState(() {
        rooms[index] = updatedRoom;
      });
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
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xFFF59B15),
            fontSize: 25,
          ),
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
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilter(),
          Expanded(
            child: filteredRooms.isEmpty
                ? const Center(child: Text('No rooms match your criteria.'))
                : _buildRoomGridView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchText = value;
            filterRooms();
          });
        },
        decoration: InputDecoration(
          hintText: 'Search by Room No',
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Filter by Capacity
        DropdownButton<int>(
          value: selectedCapacity,
          onChanged: (value) {
            setState(() {
              selectedCapacity = value!;
              filterRooms();
            });
          },
          items: <DropdownMenuItem<int>>[
            const DropdownMenuItem<int>(
              value: 0,
              child: Text('Filter by Capacity'),
            ),
            for (var capacity in rooms.map((room) => room.roomCapacity).toSet())
              DropdownMenuItem<int>(
                value: capacity,
                child: Text('Capacity $capacity'),
              ),
          ],
        ),
        // Filter by Occupancy
        Row(
          children: [
            const Text('Occupied Only'),
            Checkbox(
              value: showOccupiedOnly,
              onChanged: (value) {
                setState(() {
                  showOccupiedOnly = value ?? false;
                  filterRooms();
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  GridView _buildRoomGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: filteredRooms.isEmpty ? rooms.length : filteredRooms.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return RoomCard(
          room: filteredRooms.isEmpty ? rooms[index] : filteredRooms[index],
          onEdit: (room) => _showEditRoomDialog(context, room),
          accessToken: widget.accessToken,
          updateRoom: updateRoom,
        );
      },
    );
  }

  Future<void> _showEditRoomDialog(BuildContext context, Room room) async {
    final TextEditingController roomNoController =
        TextEditingController(text: room.roomNo);
    final TextEditingController roomCapacityController =
        TextEditingController(text: room.roomCapacity.toString());
    final TextEditingController roomPriceController =
        TextEditingController(text: room.roomPrice.toString());
    final TextEditingController roomBedSpaceController =
        TextEditingController(text: room.roomBedSpace.toString());
    bool isOccupied = room.occupied;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // Use StatefulBuilder for the dialog content
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Room Details'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: roomNoController,
                      decoration: const InputDecoration(labelText: 'Room No'),
                    ),
                    TextFormField(
                      controller: roomCapacityController,
                      decoration:
                          const InputDecoration(labelText: 'Room Capacity'),
                    ),
                    TextFormField(
                      controller: roomPriceController,
                      decoration:
                          const InputDecoration(labelText: 'Room Price'),
                    ),
                    TextFormField(
                      controller: roomPriceController,
                      decoration:
                          const InputDecoration(labelText: 'Space Left'),
                    ),
                    CheckboxListTile(
                      title: const Text('Occupied'),
                      value: isOccupied,
                      onChanged: (value) {
                        setState(() {
                          isOccupied = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final updatedRoom = room.copyWith(
                      roomNo: roomNoController.text,
                      roomCapacity:
                          int.tryParse(roomCapacityController.text) ?? 0,
                      roomPrice: double.parse(roomPriceController.text),
                      roomBedSpace:
                          int.tryParse(roomBedSpaceController.text) ?? 0,
                      occupied: isOccupied,
                    );

                    // Update the room details via an API request.
                    await _updateRoom(updatedRoom, widget.accessToken);
                    // Update the room details in the cards through the callback.
                    updateRoom(updatedRoom);

                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _updateRoom(Room updatedRoom, String accessToken) async {
    final apiUrl = Uri.parse(
        'https://ethenatx.pythonanywhere.com/management/room-details/${updatedRoom.roomId}');
    final response = await http.put(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'room_no': updatedRoom.roomNo,
        'room_capacity': updatedRoom.roomCapacity,
        'room_price': updatedRoom.roomPrice,
        'bed_space_left': updatedRoom.roomBedSpace,
        'occupied': updatedRoom.occupied,
      }),
    );

    if (response.statusCode == 200) {
      // Update the room in the rooms and filteredRooms lists.
      final index =
          rooms.indexWhere((room) => room.roomId == updatedRoom.roomId);
      if (index != -1) {
        setState(() {
          rooms[index] = updatedRoom;

          final filteredIndex = filteredRooms
              .indexWhere((room) => room.roomId == updatedRoom.roomId);
          if (filteredIndex != -1) {
            filteredRooms[filteredIndex] = updatedRoom;
          }
        });
      }
    } else {}
  }
}

class Room {
  final String roomNo;
  final int roomCapacity;
  final double roomPrice;
  final int roomBedSpace;
  final bool occupied;
  final String roomId;

  Room({
    required this.roomNo,
    required this.roomCapacity,
    required this.roomPrice,
    required this.roomBedSpace,
    required this.occupied,
    required this.roomId,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomNo: json['room_no'] ?? '',
      roomCapacity: json['room_capacity'] ?? 0,
      roomPrice: double.parse(json['room_price']),
      roomBedSpace: json['bed_space_left'] ?? 0,
      occupied: json['occupied'] ?? false,
      roomId: json['room_id'],
    );
  }

  Room copyWith({
    String? roomNo,
    int? roomCapacity,
    double? roomPrice,
    int? roomBedSpace,
    bool? occupied,
  }) {
    return Room(
      roomNo: roomNo ?? this.roomNo,
      roomCapacity: roomCapacity ?? this.roomCapacity,
      roomPrice: roomPrice ?? this.roomPrice,
      roomBedSpace: roomBedSpace ?? this.roomBedSpace,
      occupied: occupied ?? this.occupied,
      roomId: roomId,
    );
  }
}

class RoomCard extends StatelessWidget {
  final Room room;
  final void Function(Room) onEdit;
  final String accessToken;
  final Function(Room) updateRoom;

  const RoomCard({
    super.key,
    required this.room,
    required this.onEdit,
    required this.accessToken,
    required this.updateRoom,
  });

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
        child: IntrinsicHeight(
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
              Flexible(
                child: Text('Capacity: ${room.roomCapacity}'),
              ),
              Flexible(
                child: Text('Price: GH₵${room.roomPrice.toStringAsFixed(2)}'),
              ),
              Flexible(
                child: Text('Space Left: ${room.roomBedSpace}'),
              ),
              Flexible(
                child: Text('Occupied: ${room.occupied ? 'Yes' : 'No'}'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 9, 0, 5),
                child: ElevatedButton(
                  onPressed: () => onEdit(room),
                  child: const Text('Edit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
