class Product {
  //Инициализация переменных
  int _price;
  String _title;
  String _description;
  String _imageURL;
  int _balance;

  Product(this._price, this._title, this._description, this._imageURL,
      this._balance);

  //Обработка данных из json
  factory Product.fromJSON(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    } else {
      return Product(json["price"], json["title"], json["description"], json["imageURL"], json["balance"]);
    }
  }

  //Доступ к переменных извне
  get price => this._price;
  get title => this._title;
  get description => this._description;
  get imageURL => this._imageURL;
  get balance => this._balance;
}
