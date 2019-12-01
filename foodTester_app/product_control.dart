import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget{

  final Function addProductMathod;
  ProductControl(this.addProductMathod);

  @override
  Widget build(BuildContext context) {

    return RaisedButton(
    
      color: Theme.of(context).primaryColor,

      onPressed: (){

        //informing parent widget about state change
        addProductMathod('Sweets');
      },

      child: Text("Add Product"),);
  }

}