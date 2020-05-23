import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/models/carro.dart';

class FavoritosService {

  CollectionReference get _carros => Firestore.instance.collection("carros");

  Stream<QuerySnapshot> get stream => _carros.snapshots();

  Future<bool> Favoritar(Carro carro) async {
    
    DocumentReference docRef = _carros.document("${carro.id}");

    DocumentSnapshot doc = await docRef.get();

    bool exist = doc.exists;
    if (exist) {
      docRef.delete();
      return false;
    } else {
      docRef.setData(carro.toMap());
      return true;
    }
  }

  Future<bool> isFavorito(Carro carro) async {
    DocumentReference docRef = _carros.document("${carro.id}");
    DocumentSnapshot doc = await docRef.get();
    bool exist = doc.exists;
    return exist;
  }
}
