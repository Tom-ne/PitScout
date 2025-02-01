import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io'; // Add this import to handle file loading.

class TeamCard extends StatefulWidget {
  const TeamCard({super.key});

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  Map<String, dynamic> team = {};

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  // Load the JSON file and parse it
  Future<void> _loadConfig() async {
    final String response = await rootBundle.loadString('assets/config.json');
    final data = json.decode(response);

    setState(() {
      team = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (team.isEmpty) {
      return Center(
          child:
              CircularProgressIndicator()); // Show loading while data is being fetched
    }

    final dimensions = team["dimensions"];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Team ${team["number"]} - ${team["name"]}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildRobotDetails(dimensions),
                _buildImageSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRobotDetails(String dimensionsList) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left Column for Robot Details
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Robot Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Drivetrain: ${team["drivetrain"]}",
                      style: TextStyle(fontSize: 16)),
                  Text("Dimensions: $dimensionsList",
                      style: TextStyle(fontSize: 16)),
                  Text(
                    "Weight: ${team["weight"]} lbs",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            // Right Column for Abilities
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _buildAbilitiesList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAbilitiesList() {
    List<Widget> abilityWidgets = [];

    team["abilities"].forEach((category, abilities) {
      abilityWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            category,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
      abilities.forEach((ability) {
        bool isCapable = ability["capable"];
        abilityWidgets.add(
          ListTile(
            leading: Icon(
              isCapable ? Icons.check_box : Icons.check_box_outline_blank,
              color: isCapable ? Colors.green : Colors.red,
            ),
            title: Text(ability["ability"]),
          ),
        );
      });
    });

    return abilityWidgets;
  }

  Widget _buildImageSection() {
    String imagePath = team["imagePath"];
    if (imagePath.isNotEmpty) {
      // Load the image from the local file system if imagePath is provided
      return Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Robot Image",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Image.file(
                File(imagePath), // Load image from the file system
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Error loading image'));
                },
              ),
            ),
          ],
        ),
      );
    } else {
      // Fallback to network image if imagePath is not available
      return Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Robot Image",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Image.network(
                team["imageUrl"],
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    final progress = loadingProgress.expectedTotalBytes != null
                        ? (loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)) *
                            100
                        : null;
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(value: progress),
                          if (progress != null)
                            Text("${progress.toStringAsFixed(0)}% Loaded"),
                        ],
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Error loading image'));
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
