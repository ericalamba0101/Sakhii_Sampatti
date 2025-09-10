import 'package:flutter/material.dart';

class Stock {
  final String name;
  final String exchange;
  final double price;
  final double change;
  final double percent;
  bool isSelected;
  int quantity;

  Stock({
    required this.name,
    required this.exchange,
    required this.price,
    required this.change,
    required this.percent,
    this.isSelected = false,
    this.quantity = 0,
  });
}

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  String searchQuery = "";
  int selectedWatchlist = 0;

  List<String> watchlistNames = ["Watchlist 1"];

  // Simulated stock universe
  final List<Stock> allStocks = [
    Stock(name: "HDFCBANK", exchange: "BSE", price: 951.45, change: -6.55, percent: -0.68),
    Stock(name: "INFY", exchange: "NSE", price: 1469.60, change: -30.50, percent: -2.03),
    Stock(name: "TCS", exchange: "BSE", price: 3084.40, change: -12.25, percent: -0.39),
    Stock(name: "ONGC", exchange: "NSE", price: 233.71, change: 0.32, percent: 0.13),
    Stock(name: "HINDUNILVR", exchange: "BSE", price: 2656.00, change: 3.75, percent: 0.14),
    Stock(name: "GOLDBEES", exchange: "NSE", price: 85.34, change: 0.92, percent: 1.08),
    Stock(name: "SILVERBEES", exchange: "NSE", price: 113.58, change: 0.80, percent: 0.70),
    Stock(name: "APPLE", exchange: "NASDAQ", price: 225.50, change: 2.35, percent: 1.05),
    Stock(name: "TESLA", exchange: "NASDAQ", price: 702.12, change: -12.40, percent: -1.73),
    Stock(name: "RELIANCE", exchange: "NSE", price: 2460.40, change: 15.60, percent: 0.64),
  ];

  void _addWatchlist() {
    setState(() {
      watchlistNames.add("Watchlist ${watchlistNames.length + 1}");
    });
  }

  void _removeWatchlist() {
    if (watchlistNames.length > 1) {
      setState(() {
        watchlistNames.removeAt(selectedWatchlist);
        if (selectedWatchlist >= watchlistNames.length) {
          selectedWatchlist = watchlistNames.length - 1;
        }
      });
    }
  }

  void _renameWatchlist(int index) {
    TextEditingController controller = TextEditingController(text: watchlistNames[index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rename Watchlist"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter new name"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              setState(() {
                watchlistNames[index] = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Stock> filteredStocks = allStocks
        .where((stock) => stock.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView( // ✅ whole page scrollable
      child: Column(
        children: [
          // Watchlist Tabs with Action Buttons
          Row(
            children: List.generate(watchlistNames.length, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedWatchlist = index),
                  onLongPress: () => _renameWatchlist(index), // ✅ dialog on long press
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: selectedWatchlist == index ? Colors.green : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        watchlistNames[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedWatchlist == index ? Colors.green : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          // Add & Remove Watchlist Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _addWatchlist,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Watchlist"),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _removeWatchlist,
                  icon: const Icon(Icons.delete),
                  label: const Text("Remove"),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search stocks...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
            ),
          ),

          // Stock List inside shrinkWrap ListView
          ListView.builder(
            shrinkWrap: true, // ✅ allows scroll inside SingleChildScrollView
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredStocks.length,
            itemBuilder: (context, index) {
              final stock = filteredStocks[index];
              bool isPositive = stock.change >= 0;

              return ListTile(
                leading: GestureDetector(
                  onTap: () {
                    setState(() {
                      stock.isSelected = !stock.isSelected;
                    });
                  },
                  child: Icon(
                    stock.isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: stock.isSelected ? Colors.green : Colors.grey,
                  ),
                ),
                title: Text(stock.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(stock.exchange),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Stock price info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          stock.price.toStringAsFixed(2),
                          style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 16),
                        ),
                        Text(
                          "${stock.change > 0 ? "+" : ""}${stock.change.toStringAsFixed(2)} (${stock.percent.toStringAsFixed(2)}%)",
                          style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    // Quantity control
                    Row(
                      children: [
                        if (stock.quantity > 0)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (stock.quantity > 0) stock.quantity--;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text("-", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        if (stock.quantity > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              stock.quantity.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              stock.quantity++;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text("+", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
