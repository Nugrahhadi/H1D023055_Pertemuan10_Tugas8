class Registrasi {
  int? code;
  bool? status;
  String? data;
  String? token; 

  Registrasi({this.code, this.status, this.data, this.token});

  factory Registrasi.fromJson(Map<String, dynamic> obj) {
    return Registrasi(
      code: obj['code'],
      status: obj['status'],
      data: obj['data'] != null ? obj['data'].toString() : null,
      token: obj['data'] != null && obj['data'] is Map
          ? obj['data']['token']
          : null,
    );
  }
}