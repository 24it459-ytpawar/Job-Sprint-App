import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/homepage.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/edit_screen.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/add_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeItem {
  String name;
  String location;
  String department;
  String workType;
  String package;
  String companySize;
  String positionType;
  String qualification;

  HomeItem({
    required this.name,
    required this.location,
    required this.department,
    required this.workType,
    required this.package,
    required this.companySize,
    required this.positionType,
    required this.qualification,
  });
  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "location": location,
      "department": department,
      "workType": workType,
      "package": package,
      "companySize": companySize,
      "positionType": positionType,
      "qualification": qualification,
    };
  }

  static HomeItem fromjson(Map<String, dynamic> item) {
    return HomeItem(
      name: item['name'] as String,
      location: item['location'] as String,
      department: item['department'] as String,
      workType: item['workType'] as String,
      package: item['package'] as String,
      companySize: item['companySize'] as String,
      positionType: item['positionType'] as String,
      qualification: item['qualification'] as String,
    );
  }
}

Future<void> loadList() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('My_Data');
    String? jsonCities = prefs.getString('My_Cities');
    if (jsonString == null) {
      data = [];
      return;
    }
    if (jsonCities == null) {
      data = [];
      return;
    }
    List<dynamic> decodeData = jsonDecode(jsonString);
    List<dynamic> decodeCities = jsonDecode(jsonCities);
    data = decodeData.map((item) => HomeItem.fromjson(item)).toList();
    cities = decodeCities.map((item) => item as String).toList();
    print("List added sucessfully");
  } catch (e) {
    print("List not added sucessfully");
  }
}

Future<void> savedList() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data.map((item) => item.tojson()).toList());
    String jsonCities = jsonEncode(cities.map((item) => item).toList());
    await prefs.setString("My_Data", jsonString);
    await prefs.setString("My_Cities", jsonCities);
    print("List is stored Sucessfully");
  } catch (e) {
    print("Error occured");
  }
}

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

List<String> cities = [];
List<HomeItem> data = [];

class _FragmentHolderState extends State<FragmentHolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Navigator(
              initialRoute: '/Home',
              onGenerateRoute: (setting) {
                WidgetBuilder page;
                switch (setting.name) {
                  case '/Home':
                    page = (BuildContext context) =>
                        HomeScreen(items: data, cities: cities);
                    break;
                  case '/Add':
                    page = (BuildContext context) => AddScreen(
                      items: data,
                      cities: setting.arguments as List<String>,
                    );
                    break;
                  case '/Edit':
                    page = (BuildContext context) => EditScreen(
                      index: setting.arguments as int,
                      cities: cities,
                      items: data,
                    );
                    break;
                  default:
                    page = (BuildContext context) =>
                        HomeScreen(items: data, cities: cities);
                }
                return MaterialPageRoute(builder: page, settings: setting);
              },
            ),
          ),
        ],
      ),
    );
  }
}
