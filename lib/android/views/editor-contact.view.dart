import 'package:contacts/android/views/home.view.dart';
import 'package:contacts/models/contact.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts/repositories/contact.repository.dart';

class EditorContactView extends StatefulWidget {
  final ContactModel model;

  EditorContactView({this.model});

  @override
  _EditorContactViewState createState() => _EditorContactViewState();
}

class _EditorContactViewState extends State<EditorContactView> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  final _repository = ContactRepository();

  _onSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    if (widget.model.id == 0)
      _create();
    else
      _update();
  }

  _create() {
    widget.model.id = null;
    widget.model.image = null;

    _repository.create(widget.model).then((_) {
      onSUcess();
    }).catchError((onError) {
      onError();
    });
  }

  _update() {
    _repository.update(widget.model).then((onValue) {
      onSUcess();
    }).catchError((onError) {
      onError();
    });
  }

  onSUcess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    );
  }

  onError() {
    final snackBar = SnackBar(
      content: Text("ops, algo deu errado!"),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: widget.model.id == 0
            ? Text("Novo Contato")
            : Text("Editar Contato"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                initialValue: widget.model?.name,
                onChanged: (val) {
                  widget.model.name = val;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Nome inválido";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Telefone"),
                keyboardType: TextInputType.phone,
                initialValue: widget.model?.phone,
                onChanged: (val) {
                  widget.model.phone = val;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Telefone inválido";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.model?.email,
                onChanged: (val) {
                  widget.model.email = val;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Email inválido";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton.icon(
                  onPressed: _onSubmit,
                  color: Theme.of(context).primaryColor,
                  icon: Icon(
                    Icons.save,
                    color: Theme.of(context).accentColor,
                  ),
                  label: Text(
                    "Salver",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
