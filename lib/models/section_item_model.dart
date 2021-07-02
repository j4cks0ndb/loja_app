class SectionItemModel{

  SectionItemModel.fromMap(Map<String,dynamic> map){
    image = map['image'] as String;
  }

  String? image;

  @override
  String toString() {
    return 'SectionItemModel{image: $image}';
  }
}