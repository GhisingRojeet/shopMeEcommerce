// ignore_for_file: prefer_const_constructors

import 'package:admin_panel/constants/routes.dart';
import 'package:admin_panel/models/user_model/user_model.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/user_view/edit_user/edit_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleUserCard extends StatefulWidget {
  final UserModel userModel;
  final  int index;
  const SingleUserCard({super.key, required this.userModel,required this.index });

  @override
  State<SingleUserCard> createState() => _SingleUserCardState();
}

class _SingleUserCardState extends State<SingleUserCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
            AppProvider appProvider = Provider.of<AppProvider>(context,);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            widget.userModel.image != null
                ?
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.userModel.image!,),
                   
                  )
                : CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
            SizedBox(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userModel.name),
                Text(widget.userModel.email)
              ],
            ),
            const Spacer(),
            isLoading
                ? CircularProgressIndicator()
                : GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await appProvider
                          .deleteUserFromFirebase(widget.userModel);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColor,
                    )),

                    SizedBox(width: 8.0,),
                    GestureDetector(
                    onTap: () async {
                    Routes.instance.push(widget: EditUser(index: widget.index,userModel: widget.userModel), context: context);
                    },
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    )),
          ],
        ),
      ),
    );
  }
}
