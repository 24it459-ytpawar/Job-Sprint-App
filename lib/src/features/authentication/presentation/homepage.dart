import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomeItem {
  final String label;
  final bool isEditable;

  HomeItem({
    required this.label,
    this.isEditable = false,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeItem> items = [
    HomeItem(label: 'Placement 1', isEditable: true),
    HomeItem(label: 'Placement 2', isEditable: true),
    HomeItem(label: 'Placement 3', isEditable: true),
  ];

  int count = 4; // for Placement 4,5,6...

  // Dropdown state variables
  final List<String> cities = ['Ahmedabad', 'Bangalore', 'Chennai', 'Vadodara', 'Mumbai'];
  String? selectedCity;

  void addItem() {
    setState(() {
      items.add(HomeItem(label: 'Placement $count', isEditable: true));
      count++;
    });
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(255, 14, 112, 124), // Colored AppBar
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addItem,
          )
        ],
      ),
      body: ListView(
        children: [
          // City Selection Dropdown Container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCity,
                  hint: const Text('Select City'),
                  isExpanded: true,
                  items: cities.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCity = newValue;
                    });
                  },
                ),
              ),
            ),
          ),

          // Placement Cards
          ...items.asMap().entries.map(
                (entry) => buildBox(entry.key, entry.value),
              ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildBox(int index, HomeItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 9, 60, 93),

        borderRadius: BorderRadius.circular(15),
        // Shadow effect added here
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3), // moves shadow down
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT SIDE TEXT
          Text(
            item.label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          // RIGHT SIDE ICONS
          item.isEditable
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.edit, color: Colors.white),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteItem(index),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
