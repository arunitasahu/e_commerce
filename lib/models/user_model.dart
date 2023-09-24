class UserModel{
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.orderCount,
});
   factory UserModel.fromJson(Map<String,dynamic> json){

     return UserModel(
       id: json['id'],
       name: json['f_name'],
       email: json['email'],
       phone: json['phone'],
       orderCount: json['order_count'],
     );


   }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data= new Map<String,dynamic>();
    data["id"] = this.id;
    data["f_name"] = this.name;
    data["phone"]=this.phone;
    data["email"]=this.email;
    data["order_count"]=this.orderCount;
    return data;
  }




}
