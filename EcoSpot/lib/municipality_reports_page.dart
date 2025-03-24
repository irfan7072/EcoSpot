import 'package:flutter/material.dart';

class MunicipalityReportsPage extends StatelessWidget {
  final List<Map<String, dynamic>> completedReports;
  final Function(int) restoreReport;

  const MunicipalityReportsPage({Key? key, required this.completedReports, required this.restoreReport}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: completedReports.isEmpty
          ? const Center(child: Text("No completed reports yet."))
          : ListView(
              children: completedReports.reversed.map((report) {
                return Card(
                  child: ListTile(
                    leading: Image.asset(report["photo"], width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(report["location"]),
                    subtitle: Text(report["description"]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        IconButton(
                          icon: const Icon(Icons.restore, color: Colors.blue),
                          onPressed: () {
                            _showConfirmationDialog(context, report["id"]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }

  void _showConfirmationDialog(BuildContext context, int reportId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Restore Report"),
          content: const Text("Are you sure you want to restore this report?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                restoreReport(reportId);
              },
              child: const Text("Yes", style: TextStyle(color: Color.fromARGB(255, 219, 42, 42))),
            ),
          ],
        );
      },
    );
  }
}
