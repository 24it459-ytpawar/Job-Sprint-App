import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

// MODEL
class HomeItem {
  String name;
  String location;
  String area;
  String workType;
  String package;
  String companySize;
  String positionType;

  HomeItem({
    required this.name,
    required this.location,
    required this.area,
    required this.workType,
    required this.package,
    required this.companySize,
    required this.positionType,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // DATA
  List<HomeItem> items = [
    HomeItem(name: 'Placement 1', location: 'Ahmedabad', area: 'IT', workType: 'Remote', package: '6 LPA', companySize: 'Startup', positionType: 'Full Time'),
    HomeItem(name: 'Placement 2', location: 'Mumbai', area: 'Finance', workType: 'Onsite', package: '8 LPA', companySize: 'Enterprise', positionType: 'Full Time'),
    HomeItem(name: 'Placement 3', location: 'Bangalore', area: 'Software', workType: 'Work from Home', package: '5 LPA', companySize: 'Mid-size', positionType: 'Intern'),
  ];

  // DROPDOWN
  final List<String> cities = [
    'Ahmedabad',
    'Bangalore',
    'Chennai',
    'Vadodara',
    'Mumbai'
  ];
  final List<String> workTypes = ['Remote', 'Onsite', 'Work from Home'];
  final List<String> companySizes = ['Startup', 'Mid-size', 'Enterprise'];
  final List<String> positionTypes = ['Intern', 'Full Time', 'Part Time'];
  String? selectedCity;

  // ADD ITEM
  void addItem() {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController areaController = TextEditingController();
    TextEditingController packageController = TextEditingController();
    String? selectedWorkType;
    String? selectedCompanySize;
    String? selectedPositionType;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Add Placement", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Company Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: "Location",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: areaController,
                      decoration: InputDecoration(
                        labelText: "Department/Area",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: packageController,
                      decoration: InputDecoration(
                        labelText: "Package (e.g., 6 LPA)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedWorkType,
                      hint: const Text("Work Type"),
                      items: workTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                      onChanged: (value) => setStateDialog(() => selectedWorkType = value),
                      decoration: InputDecoration(
                        labelText: "Work Type",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedCompanySize,
                      hint: const Text("Company Size"),
                      items: companySizes.map((size) => DropdownMenuItem(value: size, child: Text(size))).toList(),
                      onChanged: (value) => setStateDialog(() => selectedCompanySize = value),
                      decoration: InputDecoration(
                        labelText: "Company Size",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedPositionType,
                      hint: const Text("Position Type"),
                      items: positionTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                      onChanged: (value) => setStateDialog(() => selectedPositionType = value),
                      decoration: InputDecoration(
                        labelText: "Position Type",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty && selectedWorkType != null && selectedCompanySize != null && selectedPositionType != null) {
                      setState(() {
                        items.add(
                          HomeItem(
                            name: nameController.text,
                            location: locationController.text,
                            area: areaController.text,
                            package: packageController.text,
                            workType: selectedWorkType!,
                            companySize: selectedCompanySize!,
                            positionType: selectedPositionType!,
                          ),
                        );
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF093C5D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text("Add", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // EDIT ITEM
  void editItem(int index) {
    TextEditingController nameController =
        TextEditingController(text: items[index].name);
    TextEditingController locationController =
        TextEditingController(text: items[index].location);
    TextEditingController areaController =
        TextEditingController(text: items[index].area);
    TextEditingController packageController =
        TextEditingController(text: items[index].package);
    String? selectedWorkType = items[index].workType;
    String? selectedCompanySize = items[index].companySize;
    String? selectedPositionType = items[index].positionType;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Edit Placement", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Company Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: "Location",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: areaController,
                      decoration: InputDecoration(
                        labelText: "Department/Area",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: packageController,
                      decoration: InputDecoration(
                        labelText: "Package (e.g., 6 LPA)",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedWorkType,
                      items: workTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                      onChanged: (value) => setStateDialog(() => selectedWorkType = value),
                      decoration: InputDecoration(
                        labelText: "Work Type",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedCompanySize,
                      items: companySizes.map((size) => DropdownMenuItem(value: size, child: Text(size))).toList(),
                      onChanged: (value) => setStateDialog(() => selectedCompanySize = value),
                      decoration: InputDecoration(
                        labelText: "Company Size",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedPositionType,
                      items: positionTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                      onChanged: (value) => setStateDialog(() => selectedPositionType = value),
                      decoration: InputDecoration(
                        labelText: "Position Type",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      items[index] = HomeItem(
                        name: nameController.text,
                        location: locationController.text,
                        area: areaController.text,
                        package: packageController.text,
                        workType: selectedWorkType!,
                        companySize: selectedCompanySize!,
                        positionType: selectedPositionType!,
                      );
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF093C5D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // DELETE ITEM
  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  List<HomeItem> _filteredItems() {
    if (selectedCity == null) {
      return items;
    }

    return items.where((item) => item.location == selectedCity).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5F7),
      appBar: AppBar(
        title: const Text('Job Placements', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF093C5D),
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: addItem,
          ),
        ],
      ),
      body: ListView(
        children: [
          // DROPDOWN
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF093C5D),
                border: Border.all(color: const Color(0xFF6FD1D7), width: 2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF093C5D).withAlpha(30),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String?>(
                  value: selectedCity,
                  hint: const Text("🌍 Select City", style: TextStyle(color: Color(0xFF5DF8D8), fontWeight: FontWeight.w500)),
                  isExpanded: true,
                  dropdownColor: const Color(0xFF3B7597),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('All Cities', style: TextStyle(color: Colors.white)),
                    ),
                    ...cities.map((city) {
                      return DropdownMenuItem<String?>(
                        value: city,
                        child: Text(city, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                  style: const TextStyle(color: Color(0xFF5DF8D8), fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          // CARDS
          ..._filteredItems().asMap().entries.map(
                (entry) => buildBox(entry.key, entry.value),
              ),
        ],
      ),
    );
  }

  // CARD UI
  Widget buildBox(int index, HomeItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF093C5D), Color(0xFF3B7597)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF6FD1D7), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF093C5D).withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: const Color(0xFF5DF8D8).withAlpha(20),
            blurRadius: 15,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER WITH COMPANY NAME AND BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    color: Color(0xFF5DF8D8),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFF6FD1D7)),
                    onPressed: () => editItem(index),
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(8),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFFF6B6B)),
                    onPressed: () => deleteItem(index),
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // INFO TAGS
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag('📍 ${item.location}', const Color(0xFF6FD1D7)),
              _buildTag('🏢 ${item.area}', const Color(0xFF6FD1D7)),
              _buildTag('💰 ${item.package}', const Color(0xFF5DF8D8)),
            ],
          ),
          const SizedBox(height: 12),
          // DETAILS ROW 1
          Row(
            children: [
              Expanded(
                child: _buildDetailBox(
                  '🌐 Work Type',
                  item.workType,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDetailBox(
                  '🏛️ Size',
                  item.companySize,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // DETAILS ROW 2
          _buildDetailBox(
            '💼 Position',
            item.positionType,
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildDetailBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF5DF8D8).withAlpha(15),
        border: Border.all(color: const Color(0xFF5DF8D8), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6FD1D7),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF5DF8D8),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}