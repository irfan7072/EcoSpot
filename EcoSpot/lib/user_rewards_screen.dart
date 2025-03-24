import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'storage_service.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  _RewardsScreenState createState() => _RewardsScreenState();

  static void refreshReports() {}
}

class _RewardsScreenState extends State<RewardsScreen> {
  int totalPoints = 0;
  List<Map<String, String>> reports = [];

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    List<Map<String, String>> storedReports = await StorageService.getReports();
    
    if (mounted) {
      setState(() {
        reports = storedReports.reversed.toList();
        totalPoints = reports.length * 50;
      });
    }
  }

  Future<void> _deleteReport(int index) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Report?"),
        content: const Text("Are you sure you want to delete this report?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      if (reports.isNotEmpty) {
        await StorageService.deleteReport(reports.length - 1 - index);
        await _loadReports();

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/success.json', height: 100),
                const SizedBox(height: 10),
                const Text("Report deleted successfully!"),
              ],
            ),
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards & Reports'),
        leading: const SizedBox(),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.green.shade100,
            child: Text(
              'Total Points: $totalPoints',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: reports.isEmpty
                ? const Center(child: Text("No reports submitted yet."))
                : ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: const Icon(Icons.report, color: Colors.blue),
                          title: Text(report['description'] ?? 'No description'),
                          subtitle: Text(report['location'] ?? 'No location'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteReport(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
