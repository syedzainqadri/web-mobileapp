class SignUpModel {
  String fName;
  String lName;
  String phone;
  String password;
  String cnic;

  SignUpModel({
    this.fName,
    this.lName,
    this.phone,
    this.password,
    this.cnic,
  });

  SignUpModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    password = json['password'];
    cnic = json['cnic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['cnic'] = this.cnic;
    return data;
  }
}
