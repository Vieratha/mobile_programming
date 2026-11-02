import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box settingsBox;
  String username = '';
  bool isDarkMode = false;
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    settingsBox = Hive.box('settings');

    loadData();
  }

  Future<void> loadData() async {
    // final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = settingsBox.get('username', defaultValue: '');
      isDarkMode = settingsBox.get('isDarkMode', defaultValue: false);
      // username = prefs.getString('username') ?? '';
      // isDarkMode = prefs.getBool('isDarkMode') ?? false;
      isLoading = false;
    });
  }

  Future<void> saveUsername(String name) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('username', name);
    await settingsBox.put('username', name);

    setState(() {
      username = name;
    });
  }

  Future<void> saveTheme(String theme) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isDarkMode', theme == 'dark');
    await settingsBox.put('isDarkMode', theme == 'dark');

    setState(() {
      isDarkMode = theme == 'dark';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        colorSchemeSeed: Colors.blue, brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue, brightness: Brightness.dark,
      ),

      home: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: Colors.blue,
          ),
        body: isLoading ?
        const Center(child: CircularProgressIndicator()) :
        SettingsPage(
            username: username,
            isDarkMode: isDarkMode,
            onSave: saveUsername,
            onThemeChanged: saveTheme,
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final String username;
  final bool isDarkMode;
  final Future<void> Function(String) onSave;
  final Future<void> Function(String) onThemeChanged;
  // final Future<void> Function(String) onClear;

  const SettingsPage({
    super.key,
    required this.username,
    required this.isDarkMode,
    required this.onSave,
    required this.onThemeChanged,
    // required this.onClear,
});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController controller;

  @override
  void initState(){
    super.initState();
    controller = TextEditingController(text: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Icon(Icons.account_circle, size: 100),
          const SizedBox(height: 16),

          Text(
            widget.username.isEmpty ? 'Selamat datang!' : 'Halo, ${widget.username}!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),

          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Nama Pengguna',
              border: OutlineInputBorder(),
            ),
          ),

          ElevatedButton(
              onPressed: () async{
                final name = controller.text.trim();
                
                if(name.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nama tidak boleh kosong'))
                  );
                  return;
                }

                await widget.onSave(name);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nama berhasil disimpan'))
                );
              },
              child: Text('Simpan Nama',),
          ),
          const SizedBox(height: 12),

          //Cara 1
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text(
          //           'Mode Gelap',
          //           style: TextStyle(fontSize: 18),
          //         ),
          //         Text(
          //           widget.isDarkMode
          //               ? 'Tema gelap aktif'
          //               : 'Tema terang aktif',
          //         ),
          //       ],
          //     ),
          //
          //     ElevatedButton(
          //       onPressed: () async {
          //         await widget.onThemeChanged(
          //           widget.isDarkMode ? 'light' : 'dark',
          //         );
          //       },
          //       child: Text(
          //         widget.isDarkMode ? 'ON' : 'OFF',
          //       ),
          //     ),
          //   ],
          // ),

          //Cara 2
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Mode Gelap'),
            subtitle: Text(
              widget.isDarkMode ? 'Tema gelap aktif' : 'Tema terang aktif',
            ),
            value: widget.isDarkMode,
            onChanged: (value) async {
              await widget.onThemeChanged(
                value ? 'dark' : 'light',
              );
            },
          ),
        ],
      ),
    );
  }
}