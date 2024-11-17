class Anggota {
  int id;  // id bisa nullable
  final String nama;
  final String nik; // Gunakan camelCase untuk NIK
  final String tgl_lahir;
  final String alamat;
  final String pekerjaan;
  final String no_tlp;

  // Konstruktor
  Anggota({
    required this.id,
    required this.nama,
    required this.nik,
    required this.tgl_lahir,
    required this.alamat,
    required this.pekerjaan,
    required this.no_tlp,
  });

  // Metode untuk memetakan dari JSON ke objek Anggota
  factory Anggota.fromJson(Map<String, dynamic> json) {
    return Anggota(
      id: json['id'], // Bisa null jadi tidak masalah
      nama: json['nama'],
      nik: json['nik'], // Pastikan JSON field tetap 'NIK' jika memang di API seperti ini
      tgl_lahir: json['tgl_lahir'],
      alamat: json['alamat'],
      pekerjaan: json['pekerjaan'],
      no_tlp: json['no_tlp'],
    );
  }

  // Metode untuk memetakan dari objek Anggota ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'nik': nik, // Tetap 'NIK' sesuai dengan format di JSON
      'tgl_lahir': tgl_lahir,
      'alamat': alamat,
      'pekerjaan': pekerjaan,
      'no_tlp': no_tlp
    };
  }
}
