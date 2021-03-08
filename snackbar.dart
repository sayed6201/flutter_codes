=============================================================================================
showSnackBar(..)
=============================================================================================

scaffold.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));


      Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },


=============================================================================================
Scaffold - snackbar
=============================================================================================
            final _scaffoldKey = GlobalKey<ScaffoldState>();
            final snackBar = SnackBar(content: Text('Please choose a date'),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'Ok',
                        onPressed: () {
                        },
                      ),);
                  _scaffoldKey.currentState.showSnackBar(snackBar);