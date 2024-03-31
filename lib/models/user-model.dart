class UserModel{
  String ? Uid ;
  String ? name ;
  String ? email;
  String ? phone ;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.Uid
  });
  UserModel.fromjson(Map<String,dynamic> Json){
    name=Json['name'];
    email=Json['email'];
    phone=Json['phone'];
    Uid=Json['Uid'];
  }
  Map<String,dynamic> usermodelTomap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'Uid':Uid

    };

  }
}