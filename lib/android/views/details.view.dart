import 'package:contacts/android/views/address.view.dart';
import 'package:contacts/android/views/editor-contact.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("teste"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 10,
          ),
          Container(
            height: 200,
            width: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Theme.of(context).primaryColor.withOpacity(0.1)),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image:
                      NetworkImage("https://balta.io/imgs/andrebaltieri.jpg"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            "André Baltieri",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "1 999999",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "asdasd@gmail.com",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.phone,
                  color: Theme.of(context).accentColor,
                ),
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
              ),
              FlatButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.email,
                  color: Theme.of(context).accentColor,
                ),
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
              ),
              FlatButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.camera_enhance,
                  color: Theme.of(context).accentColor,
                ),
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text(
              "Endereço",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Rua Doutor Mario Ribeiro, n8"),
                Text("Espirito Santo/ES")
              ],
            ),
            isThreeLine: true,
            trailing: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressView()),
                );
              },
              child: Icon(
                Icons.pin_drop,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditorContactView(
                      model: ContactModel(
                        id: "1",
                        email: "baltiere@gmail.com",
                        name: "André Baltieri",
                        phone: "99999999",
                      ),
                    )),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.edit,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
