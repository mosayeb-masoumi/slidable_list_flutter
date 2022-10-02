import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:slideable_listview/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();

    setList();
  }

  void setList() {
    users.add(User("Ali", "Rezai"));
    users.add(User("milad", "Ahmadi"));
    users.add(User("hassan", "nabi"));
    users.add(User("shadi", "Rezai"));
    users.add(User("shahram", "gholi"));
    users.add(User("shirzad", "rima"));
    users.add(User("shams", "iconi"));
    users.add(User("sajad", "hassani"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slidable list"),
        centerTitle: true,
      ),
      body: SlidableAutoCloseBehavior(  // to just be able to slide one item , the other will be closed

        closeWhenOpened: true,
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Slidable(

               key:Key(user.name),

                startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    dismissible: DismissiblePane(   // to be able to scroll to right to the end and delete item
                      onDismissed: () => _deleteItem(index),
                    ),
                    children: [
                      SlidableAction(
                          backgroundColor: Colors.green,
                          icon: Icons.share,
                          label: "Share",
                          onPressed: (context) => _showSnackbar(message:"share")),

                      SlidableAction(
                          backgroundColor: Colors.blue,
                          icon: Icons.archive,
                          label: "archive",
                          onPressed: (context) => _showSnackbar(message:"archive")),
                    ]
                ),

                 endActionPane: ActionPane(

                     motion: const BehindMotion(),
                     dismissible: DismissiblePane(   // to be able to scroll to left to the end and delete item
                       onDismissed: () => _deleteItem(index),
                     ),

                     children: [
                       SlidableAction(
                           backgroundColor: Colors.red,
                           icon: Icons.delete,
                           label: "delete",
                           onPressed: (context) => _deleteItem(index)),
                     ]
                 ),

                  child: buildUserListTile(user)
              );
            }),
      ),
    );
  }

  Widget buildUserListTile(User user) {

    return Builder(  // use builder for if we onTap on item slidable will be open or close
      builder: (context) => ListTile(
        contentPadding: const EdgeInsets.all(16),
         title: Text(user.name),
        subtitle: Text(user.family),
        leading: CircleAvatar(
          radius: 30,
          // backgroundImage: NetworkImage("https://jpeg.org/images/jpeg-home.jpg")
          backgroundColor: Colors.green
        ),

        trailing: Text("1986/05/22"),

        // to open slidable by click item
        onTap: (){
          final slidable = Slidable.of(context)!;
          final isClosed = slidable.actionPaneType.value == ActionPaneType.none;

          if(isClosed){
            slidable.openStartActionPane();
          }else {
            slidable.close();
          }

        },

      ),
    );

  }

  _showSnackbar({required String message}) {

    final snackbar = SnackBar(content: Text(message) ,backgroundColor: Colors.pink,);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _deleteItem(int index) {

    setState(() {
      users.removeAt(index);
    });
  }
}
