=============================================================================================
Traversing List

=============================================================================================

Iterable list = decoded['hotel']['locations']['data'];
List<Hotel> hotelList = list.map((data) => Hotel.fromJson(data)).toList();