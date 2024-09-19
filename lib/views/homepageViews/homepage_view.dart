import 'package:flutter/material.dart';
import 'package:shopnewversion/views/categoriesView/categoriesmainPage.dart';

class HomePage extends StatelessWidget{
  final String storeName;
  const HomePage({super.key, required this.storeName});


 
  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       
drawer: const Drawer(),
 backgroundColor: const Color.fromARGB(255, 209, 216, 225),
appBar: AppBar(
  backgroundColor: const  Color.fromARGB(255, 20, 58, 74),
  title: Text(storeName,
            style:const TextStyle(
                         fontSize: 20,
                         color:  Color.fromARGB(255, 216, 222, 220),
                       )),
),
body: SingleChildScrollView(
  child: 
       
          Column(
            
            children: [
              // graphsells(),
              const Card(
                color: Colors.black,
                child: SizedBox(
                  height: 200,
                  width: 400,
                 
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                
                children: [ 
                 
                 Expanded(child: _inkWell('Categories',3,context,Categoriesmainpage())),
                 Expanded(child: _inkWell('Items',3,context,Categoriesmainpage()))
                       
                ],
              ),
              Row(
                
                children: [ 
                        
                 Expanded(child: _inkWell('Suppliers',3,context,Categoriesmainpage())),
                 Expanded(child: _inkWell('Clients',3,context,Categoriesmainpage())) 
                ],
              ),
             Row(
                
                children: [ 
                  
                 Expanded(child: _inkWell('Purchase',3,context,Categoriesmainpage())),
                 Expanded(child: _inkWell('Deliveries',3,context,Categoriesmainpage()))     
                ],
              ),
              Row(
                
                children: [ 
                 
                 Expanded(child: _inkWell('Bills',3,context,Categoriesmainpage())),
                 Expanded(child: _inkWell('Historicals',3,context,Categoriesmainpage()))     
                ],
              ),
            ],
          )
        ,
       
       )  
       
      );
  }

  InkWell _inkWell(String object,int ? qty,BuildContext context,Widget nextPage){
    return InkWell(
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );

          },
          child: Column(
            children: [
          Card(
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10), 
                       ),
               elevation: 12,
               color:  const  Color.fromARGB(255, 20, 58, 74),
               shadowColor: const Color.fromARGB(255, 216, 222, 220),
               child: ClipRRect(
               borderRadius: BorderRadius.circular(10), 
               child: SizedBox(
               width: 180,
               height: 120,
               child: Center(
                child: Text(object,
                       style:const TextStyle(
                         fontSize: 20,
                         color:  Color.fromARGB(255, 216, 222, 220),
                       ),),
               )
                  ),
                ),
              ),
          const SizedBox(height: 3.0),
         
            ],
          ),
    );
  }
}