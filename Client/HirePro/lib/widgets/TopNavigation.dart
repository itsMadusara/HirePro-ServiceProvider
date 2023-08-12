import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';

class AppBarAll extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  AppBarAll({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop(); // This will pop the current route and go back
        },
      ),
      title: Text(title, style:
        TextStyle(color: Colors.black,fontWeight: FontWeight.w400, fontSize: 20
        ),),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.more_horiz, color: Colors.black),
          color: kMainYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onSelected: (value) {
            // Handle the selected menu item
            print(value);
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              padding: EdgeInsets.all(25.0),
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_rounded, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Edit Account', style: TextStyle(fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            PopupMenuDivider(height: 1,),
            PopupMenuItem<String>(
              padding: EdgeInsets.all(25.0),
              value: 'sign-out',
              child: Row(
                children: [
                  Icon(Icons.logout_rounded, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            // Add more menu items as needed
          ],
        ),
      ],
    );
  }
}


class AppBarBackButton extends StatelessWidget implements PreferredSizeWidget {

  AppBarBackButton();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop(); // This will pop the current route and go back
        },
      ),
    );
  }
}


class AppBarTitle extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  AppBarTitle({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop(); // This will pop the current route and go back
        },
      ),
      title: Text(title, style:
      TextStyle(color: Colors.black,fontWeight: FontWeight.w400, fontSize: 20
        ),
      ),
    );
  }
}

class AppBarBackAndMore extends StatelessWidget implements PreferredSizeWidget {
  AppBarBackAndMore();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop(); // This will pop the current route and go back
        },
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.more_horiz, color: Colors.black),
          color: kMainYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onSelected: (value) {
            if (value == 'edit') {
              Navigator.pushNamed(context, '/edit_profile');
            } else if (value == 'sign-out') {
              Navigator.pushNamed(context, '');
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              padding: EdgeInsets.all(25.0),
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_rounded, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Edit Account', style: TextStyle(fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            PopupMenuDivider(height: 1,),
            PopupMenuItem<String>(
              padding: EdgeInsets.all(25.0),
              value: 'sign-out',
              child: Row(
                children: [
                  Icon(Icons.logout_rounded, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            // Add more menu items as needed
          ],
        ),
      ],
    );
  }
}

class AppBarWillPopAndMore extends StatelessWidget implements PreferredSizeWidget {
  final bool isEdited;
  AppBarWillPopAndMore(this.isEdited);

  Future<bool> showWarning(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Exit'),
        content: Text('Are you sure you want to exit?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return result ?? false; // Return false if the result is null
  }



  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{
        print('Back button Pressed');
        if(isEdited){
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        }else{
          return true;
        }
    },
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop(); // This will pop the current route and go back
            },
          ),
          actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz, color: Colors.black),
              color: kMainYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (value) {
                // Handle the selected menu item
                print(value);
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  padding: EdgeInsets.all(25.0),
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_rounded, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Edit Account', style: TextStyle(fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                PopupMenuDivider(height: 1,),
                PopupMenuItem<String>(
                  padding: EdgeInsets.all(25.0),
                  value: 'sign-out',
                  child: Row(
                    children: [
                      Icon(Icons.logout_rounded, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                // Add more menu items as needed
              ],
            ),
          ],
        ),
    );
  }
}

