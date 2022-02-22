 -------------------------------------------------------------
Image fitting
-------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? Column(children: <Widget>[
        Text(
          'No image to display',
          style: Theme.of(context).textTheme.title,
        ),
        Container(
          height: 200,
          child:  Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)
        )

      ]) 

      :

      ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${transactions[index].amount}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
      
  }


=============================================================================================
SizeBox: Image.file()
Note:
picking image from gallary
=============================================================================================

   Widget buildImageRow(BuildContext context, File file) {
    return SizedBox(
        height: 500.0,
        child: Image.file(file, fit: BoxFit.fitWidth,)
    );
  }



=============================================================================================
Image Loading from Network
=============================================================================================
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'http://honeymoonair.com/media/preview/${hotel['image_id']}/thumb',
                                  placeholder: (context, url) =>
                                      Container(
                                        height: 20,
                                        width: 20,
                                        margin: EdgeInsets.all(5),
                                        child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).primaryColor),
                                  )),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),

//                                FadeInImage.assetNetwork(
//                                    placeholder: 'target.png',
//                                    fit: BoxFit.cover,
//                                    image:
//                                        'http://honeymoonair.com/media/preview/${hotel['image_id']}/thumb'))
//                            Image(
//                              height: 150.0,
//                              width: 220.0,
//                              image: Image.network('http://honeymoonair.com/media/preview/36/thumb'),
//                              fit: BoxFit.cover,
//                            ),

//fit image++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Container(
  width: MediaQuery.of(context).size.width,
  height: 100,
  decoration: BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: NetworkImage("https://picsum.photos/250?image=9"),
    ),
  ),
)


ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Image.network(
        subject['images']['large'],
        height: 150.0,
        width: 100.0,
    ),
)