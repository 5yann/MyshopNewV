import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shopnewversion/models/categoriesModel/categoriesModel.dart';
import 'package:shopnewversion/views/itemsViews/itemUpdate.dart';
import 'package:shopnewversion/views/itemsViews/itemdetails.dart';
import 'package:shopnewversion/views/itemsViews/newItemform.dart';



SpeedDial floatButtonItems(BuildContext context){
  return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child:const  Icon(Icons.search),
            backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
            label: 'Search',
            onTap: () => print('Recherche tapped'),
          ),
          SpeedDialChild(
            child:const  Icon(Icons.delete),
            backgroundColor: Colors.red,
            label: 'Delete',
            onTap: () {},
          ),
          
        ],
      );
}

SpeedDial floatButtonItemsPerCategory(BuildContext context,String category,Function(bool) selectedMode ){
  return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child:const  Icon(Icons.search),
            backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
            label: 'Search',
            onTap: () => print('Recherche tapped'),
          ),
          SpeedDialChild(
            child:const  Icon(Icons.delete),
            backgroundColor: Colors.red,
            label: 'Delete',
            onTap: () {
              selectedMode(true);
            },
          ),
          SpeedDialChild(
            child:const  Icon(Icons.add),
            backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
            label: 'Add',
            onTap: (){
               Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Newitemform(ctgy: category,)),
          );
            },
          ),
          
        ],
      );
}


SpeedDial floatButtonItemDetails(BuildContext context,Item item,String currency, Function(bool) selectedMode ){
  return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(color:  Color.fromARGB(255, 209, 216, 225),),
        backgroundColor: const  Color.fromARGB(255, 20, 58, 74),  
        overlayColor: Colors.black,
        children: [
          SpeedDialChild(
            child:const  Icon(Icons.edit,color:  Color.fromARGB(255, 209, 216, 225), ),
            backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
            label: 'Overwrite',
            onTap: () async {
              print('Modify');
            await      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemUpdateform (item: item)),
          );
           selectedMode(true);
            }  
          ),
          SpeedDialChild(
            child:const  Icon(Icons.delete,color:  Color.fromARGB(255, 209, 216, 225),),
            backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
            label: 'Delete',
            onTap: () {
              selectedMode(true);
            },
          ),
          SpeedDialChild(
            child:const  Icon(Icons.add,color:  Color.fromARGB(255, 209, 216, 225),),
            backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
            label: 'Add Supplier',
            onTap: (){
              /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Newitemform(ctgy: category,)),
          );*/
            },
          ),
                    SpeedDialChild(
            child:const  Icon(Icons.delivery_dining,color:  Color.fromARGB(255, 209, 216, 225),),
            backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
            label: 'Delivery',
            onTap: (){
               /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Newitemform(ctgy: category,)),
          );*/
            },
          ),
        ],
      );
}



InkWell inkWellItem(Item item,BuildContext context,String currency){
    
    return  InkWell(
  onTap: () {
     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemsDetailsPage(item: item, currency: currency)),
            );

  },
  child: Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 20,
    shadowColor: const Color.fromARGB(255, 69, 128, 77),
    color: const Color.fromARGB(255, 20, 58, 74),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 250, 
        height: 150, 
        child: Row(
          children: [
            
            const SizedBox(width: 10), 
            ClipRRect(
              borderRadius: BorderRadius.circular(10), 
              child: Image.network(
                item.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover, 
              ),
            ),
            const SizedBox(width: 10), 
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold, 
                      color: Color.fromARGB(255, 216, 222, 220),
                    ),
                  ),
                  const SizedBox(height: 5), 
                  Text(
                    item.description!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 216, 222, 220),
                    ),
                    overflow: TextOverflow.ellipsis, 
                  ),
                  const SizedBox(height: 10),
                  
                  Row(
                    children: [
                      const Icon(
                        Icons.inventory, 
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Quantity: ${item.quantity}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.price_check,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Price: $currency${item.saleprice}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

  }