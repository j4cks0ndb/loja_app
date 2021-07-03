class SectionItemModel{

  SectionItemModel.fromMap(Map<String,dynamic> map){
    image = map['image'] as String;
    product = (map.containsKey("product")) ?  map['product'] as String : null;
  }

  String? image;
  String? product;

  @override
  String toString() {
    return 'SectionItemModel{image: $image, product: $product}';
  }
}