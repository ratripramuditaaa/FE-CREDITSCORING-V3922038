class Pengajuan {
  final int? id;
  final int? anggotaId;
  final String? penghasilan;
  final String? npwp;
  final String? agunan;
  final String? jenis_kredit;
  final String? jumlah_hutang;
  final String? tanggal_pengajuan;
  final String? tanggal_mulai;
  final String? tanggal_selesai;

  Pengajuan({
    this.id,
    this.anggotaId,
    this.penghasilan,
    this.npwp,
    this.agunan,
    this.jenis_kredit,
    this.jumlah_hutang,
    this.tanggal_pengajuan,
    this.tanggal_mulai,
    this.tanggal_selesai,
  });

  factory Pengajuan.fromJson(Map<String, dynamic> json) {
    return Pengajuan(
      id: json['id'] as int?,
      anggotaId: json['anggotaId'] as int?,
      penghasilan: json['penghasilan'] as String? ?? 'Tidak tersedia',
      npwp: json['npwp'] as String? ?? 'Tidak tersedia',
      agunan: json['agunan'] as String? ?? 'Tidak tersedia',
      jenis_kredit: json['jenis_kredit'] as String? ?? 'Tidak tersedia',
      jumlah_hutang: json['jumlah_hutang'] as String? ?? 'Tidak tersedia',
      tanggal_pengajuan: json['tanggal_pengajuan'] as String? ?? 'Tidak tersedia',
      tanggal_mulai: json['tanggal_mulai'] as String? ?? 'Tidak tersedia',
      tanggal_selesai: json['tanggal_selesai'] as String? ?? 'Tidak tersedia',
    );
  }
}
