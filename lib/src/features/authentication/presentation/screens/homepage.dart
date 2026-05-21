import 'package:flutter/material.dart';
import 'package:jobsprint/src/features/authentication/widgets/fragment_holder.dart';

// Simple model for a placement item

// Color palette (from user)
const Color kPrimary = Color(0xFF093C5D);
const Color kSecondary = Color(0xFF3B7597);
const Color kAccent = Color(0xFF6FD1D7);
const Color kHighlight = Color(0xFF5DF8D8);
const Color kWhite = Colors.white;

class HomeScreen extends StatefulWidget {
  final List<HomeItem> items;
  final List<String> cities;
  const HomeScreen({super.key, required this.items, required this.cities});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(items: items, cities: cities);
}

//! change this to stl
class _HomeScreenState extends State<HomeScreen> {
  final List<HomeItem> items;
  final List<String> cities;
  _HomeScreenState({required this.items, required this.cities});
  // Dropdown options

  String? selectedCity;

  List<HomeItem> _filteredItems() {
    if (selectedCity == null) return items;
    return items.where((item) => item.location == selectedCity).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Placements',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kPrimary,
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                '/Add',
                arguments: cities,
              );
              if (result != null) setState(() {});
              savedList();
            },
          ),
        ],
        leading: Image.asset('lib/src/assets/logo.png'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/src/assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: const Color.fromARGB(40, 255, 255, 255)),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // City filter
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(233, 9, 59, 93),
                            border: Border.all(color: kAccent, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String?>(
                              value: selectedCity,
                              hint: const Text(
                                '🌍 Select City',
                                style: TextStyle(
                                  color: kHighlight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              isExpanded: true,
                              dropdownColor: kSecondary,
                              items: [
                                const DropdownMenuItem<String?>(
                                  value: null,
                                  child: Text(
                                    'All Cities',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ...widget.cities
                                    .map(
                                      (c) => DropdownMenuItem<String?>(
                                        value: c,
                                        child: Text(
                                          c,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ],
                              onChanged: (v) =>
                                  setState(() => selectedCity = v),
                              style: const TextStyle(
                                color: kHighlight,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Cards (read-only)
                      ..._filteredItems()
                          .map((item) => buildBox(item))
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBox(HomeItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(210, 9, 59, 93),
            const Color.fromARGB(210, 59, 117, 151),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kSecondary, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    color: kWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: kAccent),
                    onPressed: () async {
                      final updateditem = await Navigator.pushNamed(
                        context,
                        '/Edit',
                        arguments: items.indexOf(item),
                      );
                      if (updateditem != null) setState(() {});
                      savedList();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFFF6B6B)),
                    onPressed: () {
                      setState(() {
                        items.remove(item);
                        widget.cities.remove(item.location);
                        savedList();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag('📍 ${item.location}', kAccent),
              _buildTag('🏢 ${item.department}', kAccent),
              _buildTag('💰 ${item.package}', kHighlight),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDetailBox('🌐 Work Type', item.workType)),
              const SizedBox(width: 8),
              Expanded(child: _buildDetailBox('🏛️ Size', item.companySize)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildDetailBox('💼 Position', item.positionType),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDetailBox('🏆 Qualification', item.qualification),
              ),
            ],
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
        color: kHighlight.withAlpha(15),
        border: Border.all(color: kHighlight, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: kAccent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: kHighlight,
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
