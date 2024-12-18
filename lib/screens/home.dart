import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_1/Colors/colors.dart';
import 'package:project_1/db/db_services.dart';
import 'package:project_1/model/todo.dart';
import 'package:project_1/screens/Navigation_Drawer.dart';
import 'package:project_1/widgets/ToDoitem.dart';
import 'package:random_string/random_string.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool Personal=true, College=false, Office=false;
  bool suggest=false;
  TextEditingController todocontroller =TextEditingController();
  Stream?todoStream;
  gotoTheLoad()async{
    todoStream=await DatabaseService()
        .getTask(Personal?"Personal":College?"College":"Office");
    setState(() {

    });

  }
  @override
  void initState() {
    /// user will search over here
    // TODO: implement initState
    // _foundTodo = todosList;
    super.initState();
  }

  Widget getWork(){
    return StreamBuilder(
        stream: todoStream,
        builder: (context,AsyncSnapshot snapshot){
          return snapshot.hasData?
              Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                      itemBuilder: (context,index){
                      DocumentSnapshot docSnap=snapshot.data.docs[index];
                      return  CheckboxListTile(
                        activeColor: Colors.greenAccent.shade400,
                        title: Text(docSnap["work"]),

                        value:docSnap['yes'] , onChanged: (newValue)async
                      {
                        // setState(() async{
                          await DatabaseService().tickmethod(docSnap["id"],
                              Personal?"Personal":College?"College":"Office");
                          // suggest=newValue!;
                         //});
                        setState(() {
                          Future.delayed(Duration(seconds: 1),(){
                            DatabaseService().removemethod(docSnap["id"], Personal?"Personal":College?"College":"Office");

                          });
                          // DatabaseService().removemethod(docSnap["Id"], Personal?"Personal":College?"College":"Office");

                        });
                      },
                        controlAffinity: ListTileControlAffinity.leading ,
                      );
                      }
                  )
              ):Center(child: CircularProgressIndicator());
        }
    );
  }

  // represent in screen


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent.shade400,
        onPressed:(){
          openBox();
        } ,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      body: Container(
        // color: Colors.black,
        padding: EdgeInsets.only(top: 70,left: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white38,
              Colors.white12,
            ],
                begin: Alignment.topLeft,
            end: Alignment.topRight,
            
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text("Hii !!",
                style: GoogleFonts.akshar(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black


                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Text("Have a great day🎯 !!",
                style: GoogleFonts.aldrich(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black


                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Text("Let the work begin !!",
                style: GoogleFonts.alegreya(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.blue


                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Personal ?
                Material(
            elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Personal",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ): GestureDetector(
                  onTap: ()async{
                    Personal=true;
                    College=false;
                    Office=false;
                    await gotoTheLoad();
                    setState(() {


                    });
                  },
                  child: Text("Personal",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  ),
                ),
                Office ?
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Office",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ): GestureDetector(
                  onTap: ()async{
                    Personal=false;
                    College=false;
                    Office=true;
                    await gotoTheLoad();
                    setState(() {


                    });
                  },
                  child: Text("Office",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  ),
                ),

                College ?
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "College",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ): GestureDetector(
                  onTap: ()async{
                    Personal=false;
                    College=true;
                    Office=false;
                    await gotoTheLoad();
                    setState(() {


                    });
                  },
                  child: Text("College",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  ),
                ),

              ],
            ),


            SizedBox(height: 20,),
            getWork(),
            
            // CheckboxListTile(
            //   activeColor: Colors.greenAccent.shade400,
            //   title: Text("Go for breakfast"),
            //
            //   value: suggest, onChanged: (newValue)
            // {
            //   setState(() {
            //     suggest=newValue!;
            //   });
            // },
            //   controlAffinity: ListTileControlAffinity.leading ,
            // ),
            // CheckboxListTile(
            //   activeColor: Colors.greenAccent.shade400,
            //   title: Text("Go for lunch"),
            //
            //   value: suggest, onChanged: (newValue)
            // {
            //   setState(() {
            //     suggest=newValue!;
            //   });
            // },
            //   controlAffinity: ListTileControlAffinity.leading ,
            // ),
            // CheckboxListTile(
            //   activeColor: Colors.greenAccent.shade400,
            //   title: Text("Go for dinner"),
            //
            //   value: suggest, onChanged: (newValue)
            // {
            //   setState(() {
            //     suggest=newValue!;
            //   });
            // },
            //   controlAffinity: ListTileControlAffinity.leading ,
            // )

          ],
        ),

      ),
    );
  }
  Future openBox(){
    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);

                        },child: Icon(Icons.cancel),
                      ),
                      SizedBox(width: 60,),
                      Text('Add Todo Task',
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Add Text"),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      )
                    ),
                    child: TextField(
                      controller: todocontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter the task",
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: GestureDetector(
                        onTap: (){
                          String id=randomAlphaNumeric(10);
                          Map<String,dynamic>userTodo={
                            "work":todocontroller.text,
                            "id":id,
                            "yes":false,

                          };
                          Personal? DatabaseService()
                          .addPersonalTask(userTodo,id)
                          :College? DatabaseService()
                              .addCollegeTask(userTodo, id)
                              :DatabaseService().addOfficeTask(userTodo, id);
                          Navigator.pop(context);


                        },

                        child: Center(
                          child: Text('Add',style: TextStyle(
                            color: Colors.black
                          ),),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),

        )
    );
  }

}

//       backgroundColor: tdBGColor,
//       drawer: _buildDrawer(),
//       appBar: _buildAppbar(),
//       // drawer: _buildDrawer(),
//       body: Stack(
//         children: [Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             child: Column(
//               children: [
//                 searchBar(),
//                 Expanded( // all
//                   child: ListView(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(top: 50, bottom: 20),
//                         child: const Text('All ToDos',
//                           style: TextStyle(fontSize: 30, fontWeight: FontWeight
//                               .w500),),
//
//                       ),
//                       for(Todo todoo in _foundTodo
//                           .reversed ) // reversed is basically used to put the addition of item at  the top of the list
//                       //print('Type of todoo: ${todoo.runtimeType}');
//                         ToDoItem(todo: todoo,
//                           onToDoChanged: _handleToDoChange,
//                           onDeleteItem: _deleteTodoItem,
//                         ),
//
//                     ],
//                   ),
//                 )
//               ],
//             )
//         ),
//           Align(
//             alignment: Alignment.bottomCenter,
//
//             /// bottom box //
//             child: Row(children: [
//               Expanded(
//                 child: Container(margin: const EdgeInsets.only(bottom: 20,
//                     right: 20,
//                     left: 20),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: const [BoxShadow(
//                         color: Colors.grey,
//                         offset: Offset(0.0, 0.0),
//                         blurRadius: 10.0,
//                         // error of boxShadow is removed with square brackets//
//                         spreadRadius: 0.0,
//                       ),
//                       ],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: TextField(
//                       controller: _todoController,
//                       decoration: const InputDecoration(
//                         hintText: 'Add a new Todo Item',
//                         border: InputBorder.none,
//
//
//                       ),
//                     )
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(bottom: 20
//                     , right: 20),
//                 child: ElevatedButton(
//                   child: const Text('+', style: TextStyle(fontSize: 40,color: Colors.white),),
//                   onPressed: () {
//                     _addTodoItem(_todoController.text);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: tdBlue,
//                     minimumSize: const Size(60, 60),
//                     elevation: 10,
//                   ),
//                 ),
//
//
//               )
//
//             ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void _handleToDoChange(Todo todo) {
//     setState(() {
//       // Update the state of the todo item
//       todo.isDone = !todo.isDone;
//     });
//   }
//
//   void _deleteTodoItem(String id) {
//     setState(() {
//       todosList.removeWhere((item) => item.id == id);
//     });
//   }
//
//   void _addTodoItem(String todo) {
//     setState(() {
//       todosList.add(Todo(id: DateTime
//           .now()
//           .millisecondsSinceEpoch
//           .toString(), todoText: todo));
//     });
//     _todoController.clear();
//   }
//
//   void _runfilter(String enteredKEyword) {
//     List<Todo> results = [];
//     if (enteredKEyword.isEmpty) {
//       results = todosList;
//     }
//     else {
//       results = todosList.where((item) =>
//           item.todoText!.toLowerCase().contains(enteredKEyword.toLowerCase()))
//           .toList();
//     }
//     setState(() {
//       _foundTodo = results;
//     });
//   }
//
//
// //////////////////// Search Bar /////////////////////////////////
//
//   Widget searchBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: TextField(
//         onChanged: (value) => _runfilter(value),
//         decoration: const InputDecoration(
//           contentPadding: EdgeInsets.all(0),
//           prefixIcon: Icon(Icons.search,
//               color: tdBlack,
//               size: 20),
//           prefixIconConstraints: BoxConstraints( // prefixConstraints basically changes in prefix icon
//             maxHeight: 20,
//             minWidth: 25,
//           ),
//           border: InputBorder.none,
//           hintText: 'Search',
//           hintStyle: TextStyle(color: tdGrey),
//
//         ),
//       ),
//
//     );
//   }
//
//   /// Build the Drawer widget
//   Widget _buildDrawer() {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: tdBlue, // You can customize the header color
//             ),
//             child: const Text(
//               'Menu',
//               style: TextStyle(color: Colors.white, fontSize: 24),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('Home'),
//             onTap: () {
//               // Add navigation to Home logic if required
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Logout'),
//             onTap: () {
//               // Add your logout logic here
//               print('Logout button pressed');
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//
// ////////////////// Appbar //////////////////////////
//
//   AppBar _buildAppbar() {
//     return AppBar(
//       backgroundColor: tdBGColor,
//       elevation: 0,
//       automaticallyImplyLeading: false, // Removes the default back arrow
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("Events of the day!!!",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.blueAccent,
//               fontSize: 26,
//
//               shadows:[
//
//               // Shadow(
//               //   offset: Offset(2.0, 2.0), // Position of the shadow
//               //   blurRadius: 3.0,          // Blurring effect
//               //   color: Colors.pinkAccent,       // Shadow color
//               // ),
//               Shadow(
//                 offset: Offset(-2.0, -2.0),
//                 blurRadius: 3.0,
//                 color: Colors.yellow,
//               ),
//       ]
//             ),
//           ),
//           // _buildDrawer(),
//           // drawer: _buildDrawer(),
//           // IconButton(
//           //   icon: const Icon(
//           //     Icons.logout,
//           //     color: tdBlack,
//           //     size: 30,
//           //   ),
//           //   onPressed: () {
//           //     // Add your logout logic here
//           //     print('Logout button pressed');
//           //   },
//           // ),
//           Container(
//             height: 100,
//             width: 40,
//             child: ClipRect(
//               child: Image.asset('assets/todo.jpg'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
