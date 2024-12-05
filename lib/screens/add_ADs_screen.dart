import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaqman/models/new_ADs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../providers/http_providers.dart';

class AddADsScreen extends StatelessWidget {
  final focus = FocusNode();
  final _form = GlobalKey<FormState>();

  var new_ADs = NewADs(image_url: '', webpage_url: '');

  void saveItem() {
    _form.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    final newADs = Provider.of<HttpProviders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add ADs'),
      ),
      body: Form(
          key: _form,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('AD Image'),
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(focus),
                  onSaved: (newValue) {
                    new_ADs = NewADs(
                        image_url: newValue!, webpage_url: new_ADs.webpage_url);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('AD Webpage'),
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(focus),
                  onSaved: (newValue) {
                    new_ADs = NewADs(
                        image_url: new_ADs.image_url, webpage_url: newValue!);
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    saveItem();
                    newADs.postNewADs(new_ADs).then((value) {
                      Navigator.of(context).pushReplacementNamed('/ADs_screen');
                    });
                  },
                  child: Text('Add'))
            ],
          )),
    );
  }
}
