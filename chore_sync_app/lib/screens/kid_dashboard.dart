import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chore_sync_app/providers/app_state.dart';
import 'package:image_picker/image_picker.dart';

class KidDashboard extends StatelessWidget {
  const KidDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kid Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text('Points: \${state.points}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('My Chores', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildChoreItem(context, 'Clean Room', 10),
          _buildChoreItem(context, 'Do Homework', 15),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Propose chore logic
            },
            child: const Text('Propose a New Chore'),
          ),
          const SizedBox(height: 30),
          const Text('Rewards', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildRewardItem(context, 'Ice Cream', 50),
          _buildRewardItem(context, 'Movie Night', 100),
        ],
      ),
    );
  }

  Widget _buildChoreItem(BuildContext context, String title, int points) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text('Reward: \$points points'),
        trailing: ElevatedButton(
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(source: ImageSource.camera);

            if (image != null) {
              // TODO: Send image path to Rust backend to update chore status to pending_approval
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chore marked as done! Waiting for approval.')));
            }
          },
          child: const Text('Done'),
        ),
      ),
    );
  }

  Widget _buildRewardItem(BuildContext context, String title, int cost) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: ElevatedButton(
          onPressed: () {
            // Redeem logic
          },
          child: Text('Redeem (\$cost pts)'),
        ),
      ),
    );
  }
}
