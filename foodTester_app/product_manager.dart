import 'package:flutter/material.dart';
import 'package:flutter_test_app/product_control.dart';
import 'package:flutter_test_app/products.dart';

class ProductManager extends StatefulWidget{

  final String startingProduct;

  //possesional arguments, and named args, default value
  ProductManager({this.startingProduct = 'sweets tester'});

  @override
  State<StatefulWidget> createState() {
    print('Product Widget createstate()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager>{

  //=====================================================================================
  //final doesn't  allow us reassigning ( = ),
  //but you can call method on the existing object, _product.add('new')
  //final List<String> _products = const []; will not allow any modification..
  //=====================================================================================
  final List<String> _products = [];


  //can be used to initialize with values from ProductManager
  //initState runs before build
  @override
  void initState() {
    print('Product Widget initState()');
    _products.add(widget.startingProduct);
    super.initState();
  }

  //calls when data is updated
  @override
  void didUpdateWidget(ProductManager oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(String product){

  //setState() informs flutter about stateChange
    setState(() {
      _products.add(product);
      print(_products);
    });

  }

  @override
  Widget build(BuildContext context) {
    print('Product Widget build()');

    return Column(
        children:[

          //container allows adding margin and padding..
          Container(
              margin: EdgeInsets.all(10.0),

              //_addProduct is not executed here, just method ref is passed,
              //execution will be _addProduct()
              child: ProductControl(_addProduct)
          ),
          Products(_products)
        ]);
  }

}