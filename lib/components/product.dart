class Product {
  //Инициализация переменных
  int _id;
  double _price;
  String _title;
  String _description;
  String _imageURL;
  int _balance;

  Product(this._id, this._price, this._title, this._description, this._imageURL,
      this._balance);

  //Обработка данных из json
  factory Product.fromJSON(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    } else {
      return Product(json["id"], json["price"], json["title"],
          json["description"], json["imageURL"], json["balance"]);
    }
  }

  //Добавление данных в класс json
  Map<String, dynamic> toJson() => {
        "id": _id,
        "price": _price,
        "title": _title,
        "description": _description,
        "imageURL": _imageURL,
        "balance": _balance
      };

  //Доступ к переменных извне
  get id => this._id;
  get price => this._price;
  get title => this._title;
  get description => this._description;
  get imageURL => this._imageURL;
  get balance => this._balance;
}
