import 'package:flutter/material.dart';

class RoomPricesPage extends StatefulWidget {
  @override
  _RoomPricesPageState createState() => _RoomPricesPageState();
}

class _RoomPricesPageState extends State<RoomPricesPage> {
  String _selectedCapacity = 'Capacity 1';
  TextEditingController _newPriceController = TextEditingController();
  int _numberOfSelectedRooms = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select room capacity to edit',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              DropdownButton<String>(
                value: _selectedCapacity,
                items: [
                  'Capacity 1',
                  'Capacity 2',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCapacity = newValue ?? 'Capacity 1';
                  });
                },
              ),
              Text(
                'Enter the new room price',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Text(
                    'GH₵',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    width: 310,
                    child: TextFormField(
                      controller: _newPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'New Price...',
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Number of rooms affected: $_numberOfSelectedRooms',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('Apply Changes button pressed');
                  // You can implement the logic to apply changes here.
                },
                child: Text('Apply Changes'),
              ),
              Text(
                'History of Edited Rooms',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Replace this with a ListView.builder to display edited room entries.
              Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Room Capacity:'),
                            Text('4'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Old Price:'),
                            Text('\$100'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('New Price:'),
                            Text('\$120'),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.undo),
                      onPressed: () {
                        print('Undo button pressed');
                        // Implement undo logic here.
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton(
          onPressed: () {
            print('Undo All Changes button pressed');
            // Implement undo all changes logic here.
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Undo All Changes'),
            ],
          ),
        ),
      ),
    );
  }
}
