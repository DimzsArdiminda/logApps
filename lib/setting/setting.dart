import 'package:buku_tabungan/menuCatatan/catatan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DarkModeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class SettingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        // Wrap with Builder to get the context
        return ChangeNotifierProvider(
          create: (context) => DarkModeNotifier(),
          child: Builder(
            builder: (context) {
              // Access the DarkModeNotifier from the context
              DarkModeNotifier darkModeNotifier = context.watch<DarkModeNotifier>();

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Buku Tabungan',
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: darkModeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                home: Setting(),
              );
            },
          ),
        );
      },
    );
  }
}

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DarkModeNotifier darkModeNotifier = context.watch<DarkModeNotifier>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CatatanBar()),
              );
            },
            icon: Icon(Icons.arrow_back_sharp),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: darkModeNotifier.isDarkMode,
            onChanged: (value) {
              darkModeNotifier.toggleDarkMode();
            },
          ),
        ],
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Uri.parse('https://www.instagram.com/penggalan.reformasi_/');
        },
        child:Icon(Icons.call,
        textDirection: TextDirection.ltr,
        ) ,
        ),
    );
  }
}

