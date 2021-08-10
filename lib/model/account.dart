class Account {
  int id;
  String site;
  String username;
  String password;

  // konstruktor versi 1
  Account({this.id, this.site, this.username, this.password});

  // konstruktor versi 2: konversi dari Map ke Account
  Account.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.site = map['site'];
    this.username = map['username'];
    this.password = map['password'];
  }
  //getter dan setter (mengambil dan mengisi data kedalam object)
  // getter
  int get getId => id;
  String get getSite => site;
  String get getUsername => username;
  String get getPassword => password;

  // setter  
  set setSite(String value) {
    site = value;
  }

  set setUsername(String value){
    username = value;
  }

  set setPassword(String value) {
    password = value;
  }

  // konversi dari Account ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['site'] = site;
    map['username'] = username;
    map['password'] = password;
    return map;
  }

}