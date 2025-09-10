import 'package:flutter/material.dart';
import 'watchlist_page.dart';

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

  final List<Widget> _pages = [
    StocksPage(),
    WatchlistScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? buildSakhiAppBar(context, title: "Stocks") // ✅ show search bar only on Stocks
          : AppBar(
        title: const Text("Watchlist"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: const CircleAvatar(child: Text("EL")),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Stocks"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Watchlist"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Govt"),
        ],
      ),
    );
  }
}

PreferredSizeWidget buildSakhiAppBar(BuildContext context, {String title = "Sakhi Sampatti"}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        },
        child: const CircleAvatar(child: Text("EL")),
      ),
      const SizedBox(width: 12),
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search...",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    ),
  );
}

// ----------------- Stocks Page -----------------
class StocksPage extends StatelessWidget {
  final List<Map<String, dynamic>> stocks = [
    {
      "name": "Farmer Agro Ltd",
      "owner": "Ramesh Kumar",
      "details": "Organic Vegetables",
      "value": 921.25,
      "change": -6.56,
    },
    {
      "name": "Goat Milk Co.",
      "owner": "Sita Devi",
      "details": "Dairy Products",
      "value": 1120.50,
      "change": 8.20,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              color: Colors.grey[300],
              child: const Icon(Icons.store, color: Colors.black54),
            ),
            title: Text("${stock['name']}"),
            subtitle: Text("Owner: ${stock['owner']}\n${stock['details']}"),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${stock['value']}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${stock['change']}%",
                  style: TextStyle(
                    color: stock['change'] >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ----------------- Profile Page -----------------
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            Text("User Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("user@email.com"),
            const SizedBox(height: 24),
            ListTile(leading: Icon(Icons.account_balance_wallet), title: Text("Add Money")),
            ListTile(leading: Icon(Icons.group), title: Text("Invite Friends")),
            ListTile(leading: Icon(Icons.update), title: Text("Update Now")),
          ],
        ),
      ),
    );
  }
}
