import 'package:buku_tabungan/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaksi {
  String tanggal;
  double pemasukan;
  double pengeluaran;
  String catatan;

  Transaksi({
    required this.tanggal,
    required this.pemasukan,
    required this.pengeluaran,
    required this.catatan,
  });
}

class Belanjaan {
  String nama;
  int jumlah;
  bool sudahDibeli;

  Belanjaan({
    required this.nama,
    required this.jumlah,
    this.sudahDibeli = false,
  });
}

class Catatan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CatatanBar(),
    );
  }
}

class CatatanBar extends StatefulWidget {
  @override
  _CatatanBarBawah createState() => _CatatanBarBawah();
}

class _CatatanBarBawah extends State<CatatanBar> {
  int _selectedIndex = 0;
  double saldo = 0.0;
  List<Transaksi> catatanTransaksi = [];
  List<Belanjaan> belanjaanList = [];
  TextEditingController pemasukanController = TextEditingController();
  TextEditingController pengeluaranController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  TextEditingController belanjaanController = TextEditingController();
  TextEditingController jumlahBelanjaanController = TextEditingController();

  void _catatPemasukan() {
    double pemasukan = double.parse(pemasukanController.text);
    double pengeluaran = double.parse(pengeluaranController.text);
    String catatan = catatanController.text;
    saldo += pemasukan - pengeluaran;

    // Format tanggal
    String tanggal = DateFormat('dd/MM/yyyy').format(DateTime.now());

    Transaksi transaksi = Transaksi(
      tanggal: tanggal,
      pemasukan: pemasukan,
      pengeluaran: pengeluaran,
      catatan: catatan,
    );

    catatanTransaksi.add(transaksi);

    pemasukanController.clear();
    pengeluaranController.clear();
    catatanController.clear();

    setState(() {});
  }

    void _resetPemasukan() {
    // Clear controllers and reset saldo
    pemasukanController.clear();
    pengeluaranController.clear();
    catatanController.clear();
    saldo = 0.0;
    setState(() {});
  }

  void _tambahBelanjaan() {
    String namaBelanjaan = belanjaanController.text;
    int jumlahBelanjaan = int.parse(jumlahBelanjaanController.text);

    Belanjaan belanjaan = Belanjaan(
      nama: namaBelanjaan,
      jumlah: jumlahBelanjaan,
    );

    belanjaanList.add(belanjaan);

    belanjaanController.clear();
    jumlahBelanjaanController.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buku Catatan"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingApp()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _selectedIndex == 0
                ? SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            TextField(
                              controller: pemasukanController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Pemasukan (dalam 1 bulan)'),
                            ),
                            TextField(
                              controller: pengeluaranController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Pengeluaran (selama 1 hari)'),
                            ),
                            TextField(
                              controller: catatanController,
                              decoration: InputDecoration(
                                  labelText: 'Catatan yang dibeli'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: () => {
                                _resetPemasukan()
                              }, 
                              child: Text("Reset")),
                            SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: _catatPemasukan,
                              child: Text('Catat Transaksi'),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Total Transaksi: Rp. $saldo',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : _selectedIndex == 1
                    ? SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                TextField(
                                  controller: belanjaanController,
                                  decoration: InputDecoration(
                                      labelText: 'Nama Barang'),
                                ),
                                TextField(
                                  controller: jumlahBelanjaanController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: 'Jumlah Barang'),
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: _tambahBelanjaan,
                                  child: Text('Tambah Belanjaan'),
                                ),
                                SizedBox(height: 15),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: belanjaanList.length,
                                  itemBuilder: (context, index) {
                                    Belanjaan belanjaan =
                                        belanjaanList[index];
                                    return ListTile(
                                      title: Text(
                                          '${belanjaan.nama} (${belanjaan.jumlah})'),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          belanjaanList.removeAt(index);
                                          setState(() {});
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
            Expanded(
              child: _selectedIndex == 0
                  ? ListView.builder(
                      itemCount: catatanTransaksi.length,
                      itemBuilder: (context, index) {
                        Transaksi transaksi = catatanTransaksi[index];
                        return ListTile(
                          title: Text('Tanggal: ${transaksi.tanggal}'),
                          subtitle: Text(
                              'Pemasukan per bulan: Rp. ${transaksi.pemasukan}\n'
                              'Pengeluaran per hari: Rp. ${transaksi.pengeluaran}\n'
                              'Catatan yang dibeli: ${transaksi.catatan}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              catatanTransaksi.removeAt(index);
                              setState(() {});
                            },
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sync_alt_outlined),
            label: 'Pemasukan dan Pengeluaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List Belanja',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Tanggal',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 17, 13, 134),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
