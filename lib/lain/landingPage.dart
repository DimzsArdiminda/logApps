import 'package:buku_tabungan/menuCatatan/catatan.dart';
import 'package:flutter/material.dart';

class landingPage extends StatelessWidget {
  // ketika aplikasi berjalan di latar belakang
  // maka ini yang berkerja
  @override
  Widget build(BuildContext context) {
    MaterialColor warna = Colors.grey;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: warna,
        // warna background
         scaffoldBackgroundColor: Color.fromARGB(255, 122, 147, 168),
      ),
      title: "Buku Tabungan",
      home: landingPageHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class landingPageHome extends StatefulWidget {
  @override
  _kontenLandingPage createState() => _kontenLandingPage();
}

class _kontenLandingPage extends State<landingPageHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 1, vsync: this); // Length is the number of tabs
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catatan Keuangan'),
          actions: [
            // setting
            IconButton(
                onPressed: () {
                  print("bismillah bisa");
                },
                icon: Icon(Icons.monitor_heart_outlined)),
            // chat
                IconButton(
                onPressed: () {
                  print("bismillah bisa");
                },
                icon: Icon(Icons.settings)),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.notes_rounded),
                text: "catatan ",
              ),
              Tab(
                icon: Icon(Icons.calculate),
                text: "kalkulator",
              ),
              Tab(
                icon: Icon(Icons.history),
                text: "history",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CatatanBar(),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
