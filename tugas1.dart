import 'dart:async';

// Model Data

class Produk {
  final String namaProduk;
  final double harga;
  final bool stokTersedia;

  Produk({
    required this.namaProduk,
    required this.harga,
    required this.stokTersedia,
  });
}
class Pengguna {
  String nama;
  int umur;
  late List<Produk> daftarProduk;
  Peran? peran;
  Pengguna(this.nama, this.umur, this.peran);
}

enum Peran { admin, pelanggan }

// Interface
abstract class PenggunaInterface {
  void lihatProduk();
}

class AdminPengguna extends Pengguna implements PenggunaInterface {
  AdminPengguna(String nama, int umur) : super(nama, umur, Peran.admin);

  // Method untuk menambah produk ke daftar produk pengguna
  void tambahProduk(Produk produk) {
    if (produk.stokTersedia) {
      daftarProduk.add(produk);
      print("Produk '${produk.namaProduk}' ditambahkan ke daftar pengguna.");
    } else {
      throw Exception("Produk '${produk.namaProduk}' habis stok.");
    }
  }

  // Method untuk menghapus produk dari daftar produk pengguna
  void hapusProduk(Produk produk) {
    daftarProduk.remove(produk);
    print("Produk '${produk.namaProduk}' dihapus dari daftar pengguna.");
  }

  @override
  void lihatProduk() {
    print("Admin Melihat Daftar Produk:");
    for (var produk in daftarProduk) {
      print("Produk: ${produk.namaProduk}, Harga: ${produk.harga}");
    }
  }
}

class PelangganPengguna extends Pengguna implements PenggunaInterface {
  PelangganPengguna(String nama, int umur) : super(nama, umur, Peran.pelanggan);

  @override
  void lihatProduk() {
    print("Pelanggan Melihat Daftar Produk:");
    for (var produk in daftarProduk) {
      print("Produk: ${produk.namaProduk}, Harga: ${produk.harga}");
    }
  }
}

// Pemrograman Asinkron: mengambil detail produk dari "server"
Future<Produk> ambilDetailProduk(String namaProduk) async {
  print("Mengambil detail produk untuk $namaProduk...");
  await Future.delayed(Duration(seconds: 2)); // Simulasi penundaan
  return Produk(namaProduk: namaProduk, harga: 100.0, stokTersedia: true);
}

void main() async {
  // Koleksi produk menggunakan Map dan Set
  Map<String, Produk> katalogProduk = {
    "Laptop": Produk(namaProduk: "Laptop", harga: 1500.0, stokTersedia: true),
    "Headphone": Produk(namaProduk: "Headphone", harga: 200.0, stokTersedia: true),
    "Mouse": Produk(namaProduk: "Mouse", harga: 50.0, stokTersedia: false)
  };

  Set<Produk> produkUnik = Set();

  // Menambahkan produk unik ke dalam set
  produkUnik.add(katalogProduk["Laptop"]!);
  produkUnik.add(katalogProduk["Headphone"]!);
  produkUnik.add(katalogProduk["Laptop"]!); // Duplikat, tidak akan ditambahkan

  // Inisialisasi pengguna
  AdminPengguna admin = AdminPengguna("Alice", 30);
  admin.daftarProduk = []; // Inisialisasi terlambat untuk produk admin

  PelangganPengguna pelanggan = PelangganPengguna("Bob", 25);
  pelanggan.daftarProduk = List.from(produkUnik); // Inisialisasi terlambat untuk produk pelanggan

  // Admin mencoba menambah produk ke daftar pengguna
  try {
    admin.tambahProduk(katalogProduk["Laptop"]!);
    admin.tambahProduk(katalogProduk["Mouse"]!); // Stok habis, akan menyebabkan pengecualian
  } on Exception catch (e) {
    print("Error: ${e.toString()}");
  }

  // Lihat produk
  admin.lihatProduk();
  pelanggan.lihatProduk();

  // Mengambil detail produk secara asinkron
  var produkDiambil = await ambilDetailProduk("Tablet");
  print("Produk Diambil: ${produkDiambil.namaProduk}, Harga: ${produkDiambil.harga}");
}