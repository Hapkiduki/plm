import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plm/src/models/user_model.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel user = UserModel();
  bool _loading = false;
  File photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Formulario'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarphoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarphoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarphoto(),
                _crearNombre(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: user.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre'),
      onSaved: (value) => user.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'El nombre debe contener al menos 3 caracteres';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Enviar'),
      icon: Icon(Icons.send),
      onPressed: (_loading) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _loading = true;
    });

    /*if ( photo != null ) {
      producto.photoUrl = await productoProvider.subirImagen(photo);
    }



    if ( producto.id == null ) {
      productoProvider.crearProducto(producto);
    } else {
      productoProvider.editarProducto(producto);
    }*/

    // setState(() {_loading = false; });
    mostrarSnackbar('Registro guardado');
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarphoto() {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image(
              image: AssetImage(photo?.path ?? 'assets/no-image.png'),
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          FloatingActionButton(
            tooltip: 'Subir foto',
            onPressed: () {
              
              showModalBottomSheet(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
                enableDrag: true,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 100,
                  );
                },
              );
            },
            child: Icon(Icons.camera),
            mini: true,
          ),
        ],
      ),
    );
  }

  _seleccionarphoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarphoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    var localPhoto = await ImagePicker.pickImage(source: origen);

    setState(() {
      photo = localPhoto;
    });
  }
}
