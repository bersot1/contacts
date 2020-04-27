import 'package:flutter/material.dart';

class AddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Endereço do Contato"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: ListTile(
              title: Text(
                "Endereço atual",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Rua Desenvolvedor, 256"),
                  Text("Espirito Santo/ES"),
                ],
              ),
              isThreeLine: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Container(
              height: 80,
              child: TextFormField(
                decoration: InputDecoration(labelText: "Pesquisar...."),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue.withOpacity(0.2),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.my_location,
        ),
      ),
    );
  }
}
