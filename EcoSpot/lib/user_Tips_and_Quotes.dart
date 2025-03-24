import 'package:flutter/material.dart';

class TipsAndQuotesScreen extends StatelessWidget {
  const TipsAndQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips and Quotes'),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Sustainability Tips'),
          const SizedBox(height: 10),
          _buildSustainabilityTips(),
          const SizedBox(height: 30),
          _buildSectionTitle('Quotes'),
          const SizedBox(height: 10),
          _buildInspirationalQuotes(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  Widget _buildSustainabilityTips() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SustainabilityTipCard(
          tip: "1. Use cloth bags instead of plastic bags to reduce waste.",
        ),
        SustainabilityTipCard(
          tip: "2. Reduce, Reuse, and Recycle to minimize the impact on the environment.",
        ),
        SustainabilityTipCard(
          tip: "3. Conserve water by using it wisely and fixing leaks promptly.",
        ),
        SustainabilityTipCard(
          tip: "4. Switch to energy-efficient appliances to reduce your carbon footprint.",
        ),
        SustainabilityTipCard(
          tip: "5. Support local and sustainable farming to promote eco-friendly practices.",
        ),
      ],
    );
  }

  Widget _buildInspirationalQuotes() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SustainabilityQuoteCard(
          quote: "“The Earth is not a resource, it's a living organism. Our problem is that we have begun to treat it as an object to be used, abused, and thrown away.” – Vandana Shiva",
        ),
        SustainabilityQuoteCard(
          quote: "“In nature, nothing is wasted, everything is transformed.” – Anonymous",
        ),
        SustainabilityQuoteCard(
          quote: "“The Earth belongs to no one, but to the people who need it.” – Karl Marx",
        ),
      ],
    );
  }
}

class SustainabilityTipCard extends StatelessWidget {
  final String tip;
  const SustainabilityTipCard({required this.tip, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          tip,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class SustainabilityQuoteCard extends StatelessWidget {
  final String quote;
  const SustainabilityQuoteCard({required this.quote, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.green[50],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '"$quote"',
          style: const TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
