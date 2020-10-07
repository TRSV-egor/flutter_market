
class JSONPartsList {

  int _price;
  String _title;
  String _description;
  String _imageURL;
  int _balance;

  JSONPartsList(this._price, this._title, this._description, this._imageURL, this._balance);

  factory JSONPartsList.fromJSON(Map<String,dynamic> json){
    if (json == null) {
      return null;
    }else{
      return JSONPartsList(json["price"], json["title"],  json["description"], json["imageURL"], json["balance"]);
    }
  }

  get price => this._price;
  get title => this._title;
  get description => this._description;
  get imageURL => this._imageURL;
  get balance => this._balance;

}