import 'package:flutter/material.dart';

void main() {
  runApp(SakhiSampattiApp());
}

class SakhiSampattiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sakhi Sampatti',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<String> _pageTitles = [
    "Stocks Page",
    "Watchlist Page",
    "Add Page",
    "Explore Page",
    "Govt Schemes Page"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _navItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.green : Colors.grey),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallVerticalDivider() {
    return Container(
      height: 20,
      width: 1,
      color: Colors.grey[400],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sakhi Sampatti"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
            child: const CircleAvatar(child: Text("EL")),
          ),
          const SizedBox(width: 12),
        ],
      ),

      body: Center(
        child: _selectedIndex == 2
            ? AddPage()
            : Text(
          _pageTitles[_selectedIndex],
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navItem(Icons.show_chart, "Stocks", 0),
            _smallVerticalDivider(),
            _navItem(Icons.bookmark, "Watchlist", 1),
            _smallVerticalDivider(),
            _navItem(Icons.add_circle_outline, "Add", 2),
            _smallVerticalDivider(),
            _navItem(Icons.play_arrow, "Explore", 3),
            _smallVerticalDivider(),
            _navItem(Icons.account_balance, "Govt", 4),
          ],
        ),
      ),
    );
  }
}

// ----------------- Profile Page -----------------
class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Text("AR", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                _showMessage("Upload DP tapped");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: Icon(Icons.add, size: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text("User Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("user@email.com", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),


                // Update Info
                ListTile(
                  leading: Icon(Icons.edit, color: Colors.blue),
                  title: Text("Update Info"),
                  onTap: () => _showMessage("Update Info tapped"),
                ),
                Divider(),

                // My Account
                ExpansionTile(
                  leading: Icon(Icons.account_circle, color: Colors.blue),
                  title: Text("My Account"),
                  children: [
                    ListTile(
                      title: Text("Personal Info"),
                      onTap: () => _showMessage("Personal Info tapped"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("PAN"),
                      onTap: () => _showMessage("PAN tapped"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Aadhaar"),
                      onTap: () => _showMessage("Aadhaar tapped"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Bank Account Details"),
                      onTap: () => _showMessage("Bank Account Details tapped"),
                    ),
                  ],
                ),
                Divider(),

                // Support & Help
                ListTile(
                  leading: Icon(Icons.support, color: Colors.blue),
                  title: Text("Support & Help"),
                  onTap: () => _showMessage("Support tapped"),
                ),
                Divider(),

                // Chatbot
                ListTile(
                  leading: Icon(Icons.chat, color: Colors.blue),
                  title: Text("Chatbot"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatbotPage()),
                    );
                  },
                ),
                Divider(),

                // Activity
                ListTile(
                  leading: Icon(Icons.history, color: Colors.blue),
                  title: Text("Activity"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _showMessage("Activity tapped"),
                ),
                Divider(),

                // Summary
                ListTile(
                  leading: Icon(Icons.summarize, color: Colors.blue),
                  title: Text("Summary"),
                  onTap: () => _showMessage("Summary tapped"),
                ),
                Divider(),

                // Privacy & Security
                ExpansionTile(
                  leading: Icon(Icons.lock, color: Colors.blue),
                  title: Text("Privacy & Security"),
                  children: [
                    ListTile(
                      title: Text("Password"),
                      onTap: () => _showMessage("Password tapped"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("2FA"),
                      onTap: () => _showMessage("2FA tapped"),
                    ),
                  ],
                ),
                Divider(),

                // App Settings
                ExpansionTile(
                  leading: Icon(Icons.settings, color: Colors.blue),
                  title: Text("App Settings"),
                  children: [
                    ListTile(
                      title: Text("Language Preferences"),
                      onTap: () => _showMessage("Language Preferences tapped"),
                    ),
                  ],
                ),
                Divider(),

                // Logout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.logout),
                    label: Text("Logout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () => _showMessage("Logged out"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------- Chatbot Page -----------------
class ChatbotPage extends StatefulWidget {
  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _chatController = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({"sender": "user", "text": text});
      _messages.add({
        "sender": "bot",
        "text": _getBotResponse(text),
      });
    });
    _chatController.clear();
  }

  String _getBotResponse(String query) {
    query = query.toLowerCase();
    if (query.contains("loan")) {
      return "You can apply for small business loans via government schemes like PM Mudra Yojana.";
    } else if (query.contains("save")) {
      return "Start with a simple savings account or recurring deposit to build your habit.";
    } else if (query.contains("invest")) {
      return "You can invest in mutual funds, stocks, fixed deposits, or government bonds.";
    } else if (query.contains("insurance")) {
      return "Consider getting health insurance or life insurance to secure yourself and your family.";
    } else if (query.contains("scheme")) {
      return "Check government schemes like Jan Dhan, PM Kisan, and others for financial support.";
    } else if (query.contains("budget")) {
      return "Make a monthly budget to track expenses and savings effectively.";
    } else if (query.contains("emergency")) {
      return "Always keep an emergency fund that covers at least 3-6 months of your expenses.";
    } else if (query.contains("interest")) {
      return "Interest rates vary across schemes; fixed deposits and savings accounts offer different rates.";
    } else if (query.contains("tax")) {
      return "You may be eligible for tax exemptions on investments like PPF and ELSS mutual funds.";
    } else {
      return "I'm here to guide you! Ask about loans, savings, investments, insurance, or schemes.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatbot"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[_messages.length - 1 - index];
                bool isUser = msg["sender"] == "user";
                return Column(
                  children: [
                    Container(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue[100] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(msg["text"] ?? ""),
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                      hintText: "Ask about loans, savings...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () => _sendMessage(_chatController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.business),
              label: Text("Add Business"),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AddBusinessForm()));
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.flag),
              label: Text("Add Financial Goal"),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AddGoalForm()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddBusinessForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // In a real app, you'd integrate file upload here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Business"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Business Name"),
                validator: (value) => value!.isEmpty ? "Enter business name" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Enter phone number" : null,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.upload_file),
                label: Text("Upload Documents"),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Upload documents tapped")),
                  );
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Business Registered!")),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddGoalForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Financial Goal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _goalController,
                decoration: InputDecoration(labelText: "Goal Name"),
                validator: (value) => value!.isEmpty ? "Enter goal name" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: "Target Amount"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter amount" : null,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.upload_file),
                label: Text("Upload Documents"),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Upload documents tapped")),
                  );
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Financial Goal Added!")),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
