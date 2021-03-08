=============================================================================================
Gridtile Designing
=============================================================================================

GridTile(
        child: Image.network(
          imageUrl, fit: BoxFit.cover,),
        footer: GridTileBar(
          backgroundColor: Colors.black.withOpacity(0.8),
          title: Text(title, textAlign: TextAlign.center,),
          leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.favorite,
              color: Theme.of(context).accentColor,),
          ),
          trailing: IconButton(
            onPressed: (){},
            icon: Icon(Icons.local_shipping,
              color: Theme.of(context).accentColor,),
          ),
        ),
      ),