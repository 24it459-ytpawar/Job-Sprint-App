import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/homepage.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/edit_screen.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/add_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeItem {
  String name;
  String location;
  String area;
  String workType;
  String package;
  String companySize;
  String positionType;
  String qualification;

  HomeItem({
    required this.name,
    required this.location,
    required this.area,
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
      "area": area,
      "workType": workType,
      "package": package,
      "companySize": companySize,
      "positionType": positionType,
      "qualification": qualification,
    };
  }
}

Future<void> savedList() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data.map((item) => item.tojson()).toList());
    await prefs.setString("My_Data", jsonString);
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

final List<String> cities = [
  'Ahmedabad',
  'Bangalore',
  'Chennai',
  'Vadodara',
  'Mumbai',
];
List<HomeItem> data = [
  HomeItem(
    name: 'Microsoft',
    location: 'Ahmedabad',
    area: 'IT',
    workType: 'Remote',
    package: '6 LPA',
    companySize: 'Startup',
    positionType: 'Full Time',
    qualification: 'B.Tech',
  ),
  HomeItem(
    name: 'Amazon',
    location: 'Mumbai',
    area: 'Software',
    workType: 'Onsite',
    package: '8 LPA',
    companySize: 'Enterprise',
    positionType: 'Full Time',
    qualification: 'B.Tech',
  ),
  HomeItem(
    name: 'Google',
    location: 'Bangalore',
    area: 'Software',
    workType: 'Work from Home',
    package: '5 LPA',
    companySize: 'Mid-size',
    positionType: 'Intern',
    qualification: 'B.Tech',
  ),
  HomeItem(
    name: 'Infosys',
    location: 'Pune',
    area: 'Development',
    workType: 'Hybrid',
    package: '4.5 LPA',
    companySize: 'Enterprise',
    positionType: 'Full Time',
    qualification: 'M.Tech',
  ),
  HomeItem(
    name: 'TCS',
    location: 'Hyderabad',
    area: 'Cloud',
    workType: 'Onsite',
    package: '3.8 LPA',
    companySize: 'Enterprise',
    positionType: 'Full Time',
    qualification: 'M.Tech',
  ),
  HomeItem(
    name: 'Wipro',
    location: 'Chennai',
    area: 'Cyber Security',
    workType: 'Remote',
    package: '5.2 LPA',
    companySize: 'Large',
    positionType: 'Intern',
    qualification: 'M.Tech',
  ),
  HomeItem(
    name: 'Adobe',
    location: 'Noida',
    area: 'UI/UX',
    workType: 'Hybrid',
    package: '10 LPA',
    companySize: 'Enterprise',
    positionType: 'Full Time',
    qualification: 'M.Tech',
  ),
  HomeItem(
    name: 'Flipkart',
    location: 'Bangalore',
    area: 'Backend',
    workType: 'Onsite',
    package: '7 LPA',
    companySize: 'Mid-size',
    positionType: 'Full Time',
    qualification: 'B.Tech',
  ),
  HomeItem(
    name: 'Zomato',
    location: 'Delhi',
    area: 'Data Science',
    workType: 'Remote',
    package: '9 LPA',
    companySize: 'Startup',
    positionType: 'Part Time',
    qualification: 'B.Tech',
  ),
  HomeItem(
    name: 'Paytm',
    location: 'Gurgaon',
    area: 'FinTech',
    workType: 'Hybrid',
    package: '6.5 LPA',
    companySize: 'Startup',
    positionType: 'Full Time',
    qualification: 'B.Tech',
  ),
];

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
