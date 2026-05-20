import 'package:flutter/material.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/homepage.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/edit_screen.dart';
import 'package:jobsprint/src/features/authentication/presentation/screens/add_screen.dart';

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

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
  List<HomeItem> data = [
    HomeItem(
      name: 'Placement 134',
      location: 'Ahmedabad',
      area: 'IT',
      workType: 'Remote',
      package: '6 LPA',
      companySize: 'Startup',
      positionType: 'Full Time',
    ),
    HomeItem(
      name: 'Placement 2',
      location: 'Mumbai',
      area: 'Finance',
      workType: 'Onsite',
      package: '8 LPA',
      companySize: 'Enterprise',
      positionType: 'Full Time',
    ),
    HomeItem(
      name: 'Placement 3',
      location: 'Bangalore',
      area: 'Software',
      workType: 'Work from Home',
      package: '5 LPA',
      companySize: 'Mid-size',
      positionType: 'Intern',
    ),
  ];
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
                    page = (BuildContext context) => HomeScreen(items: data);
                    break;
                  case '/Add':
                    page = (BuildContext context) => AddScreen(items: data);
                    break;
                  case '/Edit':
                    page = (BuildContext context) => EditScreen(index : setting.arguments as int,items: data );
                    break;
                  default:
                    page = (BuildContext context) => HomeScreen(items: data);
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
