import 'package:flutter/material.dart';
import 'user_login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String firstName = "Irfan";
  String age = "19";
  String gender = "Male";
  String phoneNumber = "+91 630256726";
  String email = "irfan.shaik@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevents overflow when keyboard appears
      appBar: AppBar(
        title: const Text("Settings"),
        automaticallyImplyLeading: false, // Removes back button
      ),
      body: SingleChildScrollView( // Makes the entire settings screen scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              _buildEditableTile("First Name", firstName, (newValue) {
                setState(() => firstName = newValue);
              }),
              _buildEditableTile("Age", age, (newValue) {
                setState(() => age = newValue);
              }),
              _buildEditableTile("Gender", gender, (newValue) {
                setState(() => gender = newValue);
              }),
              _buildEditableTile("Phone Number", phoneNumber, (newValue) {
                setState(() => phoneNumber = newValue);
              }),
              _buildEditableTile("Email", email, (newValue) {
                setState(() => email = newValue);
              }),

              ListTile(
                title: const Text("Change Password",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.lock, color: Colors.blue),
                onTap: () {
                  _showChangePasswordDialog(context);
                },
              ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text("Sign Out"),
                onTap: () {
                  _showSignOutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableTile(String title, String value, Function(String) onSave) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value),
      trailing: IconButton(
        icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
        onPressed: () {
          _showEditDialog(title, value, onSave);
        },
      ),
    );
  }

  void _showEditDialog(String field, String currentValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit $field"),
          content: SingleChildScrollView( // Ensures dialog doesn't overflow when keyboard appears
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: field,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$field updated successfully!")),
                );
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: SingleChildScrollView( // Ensures dialog doesn't overflow
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: currentPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Current Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "New Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm New Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                if (newPasswordController.text == confirmPasswordController.text) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password changed successfully!")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords do not match!")),
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Sign Out"),
          content: const Text("Are you sure you want to sign out?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text("Sign Out"),
            ),
          ],
        );
      },
    );
  }
}
