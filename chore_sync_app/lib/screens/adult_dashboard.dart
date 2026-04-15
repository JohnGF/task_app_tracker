import 'package:flutter/material.dart';

class AdultDashboard extends StatelessWidget {
  const AdultDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adult Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Pending Approvals', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildPendingApproval(context, 'Clean Room', 10),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Add new chore logic
            },
            child: const Text('Assign New Chore'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Manage rewards logic
            },
            child: const Text('Manage Rewards'),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingApproval(BuildContext context, String title, int points) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: const Text('Image attached. Waiting for review.'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () {
                // Approve and add points
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chore approved!')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                // Deny
              },
            ),
          ],
        ),
        onTap: () {
          // View image logic
        },
      ),
    );
  }
}
