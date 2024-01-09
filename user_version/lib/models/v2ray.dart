class v2rays {
  v2rays({
    required this.v2ray,
  });
  late final int id;
  late final String v2ray;
  
  v2rays.fromJson(Map<String, dynamic> json){
    id = json['id'];
    v2ray = json['v2ray'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['v2ray'] = v2ray;
    return _data;
  }
}