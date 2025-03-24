import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'municipality_reports_page.dart';
import 'municipality_settings_page.dart';

class MunicipalityHomePage extends StatefulWidget {
  const MunicipalityHomePage({Key? key}) : super(key: key);

  @override
  _MunicipalityHomePageState createState() => _MunicipalityHomePageState();
}

class _MunicipalityHomePageState extends State<MunicipalityHomePage> {
  int _selectedIndex = 0;
  bool _showSuccessAnimation = false;

  final List<String> _pageTitles = ["Home", "Completed Reports", "Settings"];

  List<Map<String, dynamic>> reports = [
    {
      "id": 1,
      "location": "Main Street, City Center (17.367751, 78.475570)",
      "photo": "assets/trash_photo.jpg",
      "description": "Garbage bin overflowing",
      "status": false,
    },
    {
      "id": 2,
      "location": "Park Avenue (16.495757, 80.658647)",
      "photo": "assets/trash_photo2.jpg",
      "description": "Plastic waste scattered",
      "status": false,
    },
  ];

  List<Map<String, dynamic>> completedReports = [];

  void _updateReportStatus(int id) {
    setState(() {
      _showSuccessAnimation = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        final index = reports.indexWhere((report) => report["id"] == id);
        if (index != -1) {
          reports[index]["status"] = true;
          completedReports.add(reports[index]);
          reports.removeAt(index);
        }
        _showSuccessAnimation = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Report marked as completed!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  void _restoreReport(int id) {
    setState(() {
      final index = completedReports.indexWhere((report) => report["id"] == id);
      if (index != -1) {
        var restoredReport = completedReports[index];
        if (!reports.any((report) => report["id"] == id)) {
          reports.add(restoredReport);
        }
        completedReports.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _showSuccessAnimation
          ? Center(
              child: Lottie.asset(
                'assets/success.json',
                width: 200,
                height: 200,
                repeat: false,
              ),
            )
          : _buildHomePage(),
      MunicipalityReportsPage(completedReports: completedReports, restoreReport: _restoreReport),
      const MunicipalitySettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        automaticallyImplyLeading: false,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: "Completed Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const {
          0: FractionColumnWidth(0.1),
          1: FractionColumnWidth(0.3),
          2: FractionColumnWidth(0.15),
          3: FractionColumnWidth(0.3),
          4: FractionColumnWidth(0.15),
        },
        children: [
          _buildTableHeader(),
          ...reports.map((report) => _buildTableRow(report)).toList(),
        ],
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[300]),
      children: const [
        TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text("S.No", textAlign: TextAlign.center))),
        TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text("Location", textAlign: TextAlign.center))),
        TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text("Photo", textAlign: TextAlign.center))),
        TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text("Description", textAlign: TextAlign.center))),
        TableCell(child: Padding(padding: EdgeInsets.all(8), child: Text("Action", textAlign: TextAlign.center))),
      ],
    );
  }

  TableRow _buildTableRow(Map<String, dynamic> report) {
    return TableRow(
      children: [
        TableCell(
          child: Center(
            child: Text(report["id"].toString()),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(report["location"]),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _showFullScreenImage(context, report["photo"]);
              },
              child: Image.asset(report["photo"], height: 50, width: 50, fit: BoxFit.cover),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(report["description"]),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle, // Aligns button vertically
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 120, // Fixed width
              height: 40, // Fixed height
              child: ElevatedButton(
                onPressed: () {
                  _updateReportStatus(report["id"]);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: const Text(
                  "Done",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14), // Adjusted font size
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFullScreenImage(BuildContext context, String photoPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              child: Image.asset(photoPath, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
