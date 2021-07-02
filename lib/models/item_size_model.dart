class ItemSizeModel{

  ItemSizeModel.fromMap(Map<String, dynamic> map){
    if (map.containsKey("name")) name = map['name'] as String;
    if (map.containsKey("price")) price = map['price'] as num;
    if (map.containsKey("stock")) stock = map['stock'] as int;
  }

  String? name;
  num? price;
  int? stock;

  bool get hasStock => stock! > 0;

  @override
  String toString() {
    return 'ItemSizeModel{name: $name, price: $price, stock: $stock}';
  }
}