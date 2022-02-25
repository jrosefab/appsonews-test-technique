class Country {
  String name;
  String code;
  String flag;

  Country({required this.name, required this.code, required this.flag});

  Country.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        code = map['code'],
        flag = map['flag'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'flag': flag,
    };
  }
}
