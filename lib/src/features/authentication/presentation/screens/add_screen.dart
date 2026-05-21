import 'package:flutter/material.dart';
import 'package:jobsprint/src/features/authentication/widgets/fragment_holder.dart';

const Color kPrimary = Color(0xFF093C5D);
const Color kSecondary = Color(0xFF3B7597);
const Color kAccent = Color(0xFF6FD1D7);
const Color kHighlight = Color(0xFF5DF8D8);

class AddScreen extends StatelessWidget {
  final List<HomeItem> items;
  final TextEditingController nameController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController areaController = TextEditingController();

  final TextEditingController workTypeController = TextEditingController();

  final TextEditingController packageController = TextEditingController();

  final TextEditingController companySizeController = TextEditingController();

  final TextEditingController positionTypeController = TextEditingController();
  AddScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5F7),
      appBar: AppBar(
        title: const Text(
          'Add Tab',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kPrimary,
        elevation: 5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(144, 0, 0, 0),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        textitems("Name", nameController),
                        textitems("Location", locationController),
                        textitems("Area", areaController),
                        textitems("Work Type", workTypeController),
                        textitems("Package", packageController),
                        textitems("Company Size", companySizeController),
                        textitems("Position Type", positionTypeController),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                final newItem = HomeItem(
                                  name: nameController.text,
                                  location: locationController.text,
                                  area: areaController.text,
                                  workType: workTypeController.text,
                                  package: packageController.text,
                                  companySize: companySizeController.text,
                                  positionType: positionTypeController.text,
                                );

                                items.add(newItem);

                                Navigator.pop(context, newItem);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Add Item',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget textitems(String name, TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: name,
            hintStyle: const TextStyle(color: kSecondary),
            filled: true,
            fillColor: const Color(0xFFF6FBFC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFB8D6DF),
                width: 1.1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    ),
  );
}
