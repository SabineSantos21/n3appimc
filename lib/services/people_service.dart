import 'dart:math';

import 'package:app/models/people.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PeopleService {
  static Future<void> createPeople(People people) async {
    final docUser = FirebaseFirestore.instance.collection('imcPeople').doc();
    people.id = docUser.id;
    final json = people.toJson();
    await docUser.set(json);
  }

  static Future<void> updatePeople(People people) async {
    final docPeople = FirebaseFirestore.instance
        .collection('imcPeople').doc(people.id);
    final json = people.toJson();
    await docPeople.update(json);
  }

  static Stream<List<People>> readPerson() {
    return FirebaseFirestore.instance.collection('imcPeople')
        .snapshots().map(
            (snapshot) =>
            snapshot.docs.map((doc) =>
                People.fromJson(doc.data())).toList());
  }

  static Future<void> deletePeople(People people) async {
    final docPeople = FirebaseFirestore.instance
        .collection('imcPeople').doc(people.id);
    await docPeople.delete();
  }

  static Future<double> calculateImc(double width, double heigth) async {
    return width/(pow(heigth, 2));
  }
}