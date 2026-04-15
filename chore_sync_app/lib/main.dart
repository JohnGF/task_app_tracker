import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chore_sync_app/providers/app_state.dart';
import 'package:chore_sync_app/screens/kid_dashboard.dart';
import 'package:chore_sync_app/screens/adult_dashboard.dart';
import 'package:chore_sync_app/src/rust/frb_generated.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chore Sync App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RoleSelectionScreen(),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Who is using the app?')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<AppState>(context, listen: false).setRole('kid');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const KidDashboard()));
              },
              child: const Text('Kid'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<AppState>(context, listen: false).setRole('adult');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdultDashboard()));
              },
              child: const Text('Adult'),
            ),
          ],
        ),
      ),
    );
  }
}
