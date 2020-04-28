import 'package:contacts/android/views/address.view.dart';
import 'package:contacts/android/views/editor-contact.view.dart';
import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/android/views/loading.view.dart';
import 'package:contacts/android/widgets/contact-list-item.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:contacts/repositories/contact.repository.dart';
import 'package:contacts/shared/widgets/contact-details-description.widget.dart';
import 'package:contacts/shared/widgets/contact-details-image.widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailView extends StatefulWidget {
  final int id;

  DetailView({
    @required this.id,
  });

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final _repository = new ContactRepository();

  onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    );
  }

  onError(err) {
    print(err);
  }

  onDelete() {
    showDialog(
      context: context,
      builder: (ctx) {
        return new AlertDialog(
          title: new Text("Exclusão de Contato"),
          content: new Text("Deseja Exluir este contato?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {},
              child: Text("Cancelar"),
            ),
            FlatButton(onPressed: delete, child: Text("Excluir"))
          ],
        );
      },
    );
  }

  delete() {
    _repository.delete(widget.id).then((_) {
      onSuccess();
    }).catchError((err) {
      onError(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repository.getContact(widget.id),
      builder: (ctx, snp) {
        if (snp.hasData) {
          ContactModel contact = snp.data;
          return page(context, contact);
        } else {
          return LoadingView();
        }
      },
    );
  }

  @override
  Widget page(BuildContext context, ContactModel model) {
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
          ContactDetailsImage(
            image: model.image,
          ),
          SizedBox(
            height: 50,
          ),
          ContactDetailsDescription(
            name: model.name,
            email: model.email,
            phone: model.phone,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  launch("tel://${model.phone}");
                },
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
                onPressed: () {
                  launch("mailto://${model.email}");
                },
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
                Text(
                  model.addressLine1 ?? "Nenhum endereço cadastrado",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  model.addressLine2 ?? "",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )
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
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              color: Color(0xFFFF0000),
              child: FlatButton(
                onPressed: onDelete,
                child: Text("Excluir contato",
                    style: TextStyle(color: Theme.of(context).accentColor)),
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
                model: model,
              ),
            ),
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
