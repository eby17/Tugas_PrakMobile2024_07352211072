// Enum untuk status peminjaman alat musik
enum PeminjamanStatus { DIPINJAM, KEMBALI }

// Abstract class untuk ItemPerpustakaan
abstract class ItemPerpustakaan {
  String namaAlat;
  String merk;
  int tahunProduksi;

  ItemPerpustakaan(this.namaAlat, this.merk, this.tahunProduksi);

  void pinjam();
  void kembalikan();
}

// Mixin untuk memantau status peminjaman
mixin PemantauStatus {
  PeminjamanStatus status = PeminjamanStatus.KEMBALI;

  void tampilkanStatus() {
    print("Status: ${status.toString().split('.').last}");
  }

  // Getter dan Setter untuk status
  PeminjamanStatus get getStatus => status;
  set setStatus(PeminjamanStatus newStatus) => status = newStatus;
}

// Kelas Gitar yang mewarisi ItemPerpustakaan dan menggunakan PemantauStatus
class Gitar extends ItemPerpustakaan with PemantauStatus {
  Gitar(String namaAlat, String merk, int tahunProduksi) : super(namaAlat, merk, tahunProduksi);

  @override
  void pinjam() {
    setStatus = PeminjamanStatus.DIPINJAM;
    print("Gitar '$namaAlat' dipinjam.");
  }

  @override
  void kembalikan() {
    setStatus = PeminjamanStatus.KEMBALI;
    print("Gitar '$namaAlat' telah dikembalikan.");
  }
}

// Kelas Peminjam untuk pengguna yang meminjam alat musik
class Peminjam extends Gitar {
  String namaPeminjam;
  int idPeminjam;

  Peminjam(this.namaPeminjam, this.idPeminjam, String namaAlat, String merk, int tahunProduksi)
      : super(namaAlat, merk, tahunProduksi);

  @override
  void tampilkanStatus() {
    print("Peminjam: $namaPeminjam, Status Alat Musik: ${getStatus.toString().split('.').last}");
  }
}

void main() {
  // Contoh peminjaman alat musik dengan positional dan named argument
  var gitar1 = Peminjam("Andi", 101, "Gitar Akustik", "Yamaha", 2019);
  
  gitar1.pinjam(); // Alat musik dipinjam
  gitar1.tampilkanStatus(); // Tampilkan status setelah dipinjam
  
  gitar1.kembalikan(); // Alat musik dikembalikan
  gitar1.tampilkanStatus(); // Tampilkan status setelah dikembalikan
}
