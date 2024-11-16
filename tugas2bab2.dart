// 1. Manajemen Produk Digital
class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;
  int jumlahTerjual;

  ProdukDigital(this.namaProduk, this.harga, this.kategori, this.jumlahTerjual) {
    // Validasi harga sesuai kategori
    if (kategori == "NetworkAutomation" && harga < 200000) {
      harga = 200000;
    } else if (kategori == "DataManagement" && harga >= 200000) {
      harga = 199999;
    }
  }

  // 2. Diskon Khusus Produk Premium
  void terapkanDiskon() {
    if (kategori == "NetworkAutomation" && jumlahTerjual > 50) {
      harga *= 0.85;
      if (harga < 200000) {
        harga = 200000;
      }
    }
  }
}

// 3. Jenis Karyawan dan Peran
abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja();
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("$nama bekerja pada hari kerja reguler.");
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("$nama bekerja pada proyek dengan periode waktu spesifik.");
  }
}

// 4. Evaluasi Kinerja Karyawan
mixin Kinerja {
  int produktivitas = 0;
  DateTime? lastUpdate;

  void updateProduktivitas(int nilai) {
    final now = DateTime.now();
    if (lastUpdate == null || now.difference(lastUpdate!).inDays >= 30) {
      if (nilai >= 0 && nilai <= 100) {
        produktivitas = nilai;
        lastUpdate = now;
      }
    }
  }
}

class Manager extends Karyawan with Kinerja {
  Manager(String nama, {required int umur})
      : super(nama, umur: umur, peran: "Manager") {
    if (produktivitas < 85) produktivitas = 85;
  }

  @override
  void bekerja() {
    print("$nama bekerja sebagai Manager dengan produktivitas $produktivitas.");
  }
}

// 5. Enum FaseProyek untuk Konsistensi Proyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class Proyek {
  FaseProyek fase;
  int hariBerjalan;
  List<Karyawan> timProyek;

  Proyek(this.fase, this.hariBerjalan, this.timProyek);

  void nextFase() {
    if (fase == FaseProyek.Perencanaan && timProyek.length >= 5) {
      fase = FaseProyek.Pengembangan;
    } else if (fase == FaseProyek.Pengembangan && hariBerjalan > 45) {
      fase = FaseProyek.Evaluasi;
    }
  }
}

// 6. Mekanisme Pembatasan Jumlah Karyawan Aktif
class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  final int maxKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < maxKaryawanAktif) {
      karyawanAktif.add(karyawan);
    } else {
      print("Tidak dapat menambah lebih banyak karyawan aktif.");
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    if (karyawanAktif.contains(karyawan)) {
      karyawanAktif.remove(karyawan);
      karyawanNonAktif.add(karyawan);
    }
  }
}

void main() {
  // Manajemen Produk
  var produk1 = ProdukDigital("Sistem Otomasi Jaringan", 250000, "NetworkAutomation", 60);
  produk1.terapkanDiskon();
  print("Harga setelah diskon: ${produk1.harga}");

  // Jenis Karyawan dan Peran
  var karyawan1 = KaryawanTetap("Budi", umur: 30, peran: "Developer");
  var manager = Manager("Siti", umur: 45);

  // Perusahaan
  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawan1);
  perusahaan.tambahKaryawan(manager);

  // Evaluasi Kinerja
  karyawan1.bekerja();
  manager.bekerja();
  manager.updateProduktivitas(90);

  // Proyek dan Fase
  var proyek = Proyek(FaseProyek.Perencanaan, 0, [karyawan1, manager]);
  proyek.nextFase();
  print("Fase proyek saat ini: ${proyek.fase}");
}
