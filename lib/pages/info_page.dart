import 'package:flutter/material.dart';
import 'package:register_form_flutter/models/user.dart';

class InfoPage extends StatelessWidget {
  //const InfoPage({ Key? key }) : super(key: key);

  User user;
  InfoPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Page'),
        centerTitle: true,
      ),
      body: Card(
        child: ListView(
          children: [
            ListTile(
              title: Text(user.name),
              subtitle: Text(user.story),
              leading: Icon(Icons.person),
              trailing: Text(user.country),
            ),
            ListTile(
              title: Text(user.phone),
              leading: user.phone.isEmpty ? null : const Icon(Icons.phone),
            ),
            ListTile(
              title: Text(user.mail),
              leading: user.mail.isEmpty ? null : const Icon(Icons.mail),
            ),
          ],
        ),
      ),
    );
  }
}
