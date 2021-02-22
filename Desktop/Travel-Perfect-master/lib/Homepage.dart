import 'package:flutter/material.dart';



Container homepagedestination (String imagevalue,String location){
return Container(
              width: 160.0,
                child: Card(
                  child: Wrap(
                    children: <Widget>[
                      Image.network(imagevalue),
                     
                     ListTile(
                       title: Text(location,
                       style: TextStyle(
                         fontSize: 20.0,
                         fontStyle: FontStyle.normal,
                      
                       ),),
                     )
                    ],
                  ),
                ),
              );

}




class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  
  
  //AssetImage annapurna = AssetImage("images/anna.jpeg");
  
  @override

  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destinations'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ]
      ),


      // drawer: Drawer(
      //   child: ListView(
      //     children: <Widget>[
      //       UserAccountsDrawerHeader(
      //         accountName: Text('Abhishek Joshi'),
      //         accountEmail:  Text('aabhisheekk@gmail.com'),
      //         currentAccountPicture: CircleAvatar(
      //           backgroundColor: Colors.blueAccent,
      //           child: Text('AG'),
      //         ),
      //       ),
      //       ListTile(
      //         title: Text('Home'),
      //         trailing: Icon(Icons.home),
      //       ),

      //       ListTile(
      //         title:  Text('Destinations'),
      //         trailing: Icon(Icons.place),
      //         onTap: () => Navigator.of(context).pushNamed('\a'),

      //       ),

      //       ListTile(
      //         title: Text(' Trek Companions'),
      //         trailing: Icon(Icons.group),
      //       ),

      //       ListTile(
      //         title: Text('Projects'),
            
      //       ),

      //       ListTile(
      //         title: Text('Videos'),
      //         trailing: Icon(Icons.video_label),
      //       ),

      //       ListTile(
      //         title: Text('Feedback'),
      //         trailing: Icon(Icons.feedback),
      //       ),

      //        ListTile(
      //         title: Text('Exit'),
      //         trailing: Icon(Icons.exit_to_app),
      //         onTap: () => Navigator.of(context).pop(),
      //       )
            
      //     ],
      //   ),
      // ),
        
      body: Container(
        
        margin: EdgeInsets.symmetric(vertical:30.0),
        height: 300.0,
        child: ListView(
          
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            homepagedestination("https://images.unsplash.com/photo-1518002054494-3a6f94352e9d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80", "Annapurna Circuit Trek"),
            homepagedestination("https://images.unsplash.com/photo-1517618247143-f9fe3421c096?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80", "Mardi Himal Trek"),
            homepagedestination("https://images.unsplash.com/photo-1546791145-dc60a10d440a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80", "More")

          ],
          
        ),

        
        
      

      
    
      )
      


    );
  }
}
