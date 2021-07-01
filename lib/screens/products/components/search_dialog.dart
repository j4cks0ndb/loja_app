import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {

  //final TextEditingController searchController = TextEditingController();

  //final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String aux = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 2,
            left: 4,
            right: 4,
            child: Card(
          child: TextFormField(
            //controller: searchController,
            textInputAction: TextInputAction.search,
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Colors.grey[700],
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              prefixIcon: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.grey[700],
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
            onFieldSubmitted: (text){
              Navigator.of(context).pop(text);

            },
           
          ),
        ))
      ],
    );
  }
}
