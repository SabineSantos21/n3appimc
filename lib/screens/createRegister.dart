import 'package:app/models/people.dart';
import 'package:app/screens/homeScreen.dart';
import 'package:flutter/material.dart';

import '../services/people_service.dart';

class CreateRegister extends StatefulWidget {
  const CreateRegister({this.people, Key? key}) : super(key: key);

  final People? people;

  @override
  State<StatefulWidget> createState() => _CreateRegisterState();
}

class _CreateRegisterState extends State<CreateRegister> {
  final controllerName = TextEditingController();
  final controllerHeight = TextEditingController();
  final controllerWeight = TextEditingController();

  late People? people;
  late String titleAction = people != null ? 'Editar' : 'Criar';

  @override
  void initState() {
    super.initState();
    people = widget.people;
    if (people != null) {
      controllerName.text = people!.name;
      controllerHeight.text = people!.height.toString();
      controllerWeight.text = people!.weight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titleAction),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 10.0),
                  child: Text(
                    '$titleAction Dados',
                    style: const TextStyle(color: Colors.teal, fontSize: 20.0),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    color: Colors.white,
                    child: widgetTextFieldName(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    color: Colors.white,
                    child: widgetTextFieldHeight(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    color: Colors.white,
                    child: widgetTextFieldWeight(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    // <-- ElevatedButton
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 24.0,
                    ),
                    label: const Text('Voltar'),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                  ),
                  ElevatedButton.icon(
                    // <-- ElevatedButton
                    onPressed: () {
                      if (people == null) {
                        createPeople();
                      } else {
                        updatePeople(people!);
                      }
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.check,
                      size: 24.0,
                    ),
                    label: Text('Cadastrar'),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  widgetTextFieldName() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nome',
      ),
      controller: controllerName,
    );
  }

  widgetTextFieldHeight() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Altura',
      ),
      controller: controllerHeight,
    );
  }

  widgetTextFieldWeight() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Peso',
      ),
      controller: controllerWeight,
    );
  }

  void createPeople() async {
    var imc = await PeopleService.calculateImc(double.parse(controllerWeight.text), double.parse(controllerHeight.text));

    final newPeople = People(
      name: controllerName.text,
      height: double.parse(controllerHeight.text),
      weight: double.parse(controllerWeight.text),
      imc: double.parse(imc.toString()),
    );
    PeopleService.createPeople(newPeople);
  }

  void updatePeople(People people) {
    people.name = controllerName.text;
    people.height = double.parse(controllerHeight.text);
    people.weight = double.parse(controllerWeight.text);
    PeopleService.updatePeople(people);
  }
}
