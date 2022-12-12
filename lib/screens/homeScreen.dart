import 'package:app/screens/createRegister.dart';
import 'package:flutter/material.dart';

import '../models/people.dart';
import '../services/people_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(right: 5.0, left: 5.0),
          child: Scaffold(
              appBar: AppBar(
                title: const Text('Cadastros'),
              ),
              body: StreamBuilder(
              stream: PeopleService.readPerson(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<People>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                }
                if (snapshot.hasData) {
                  final people = snapshot.data!;
                  return ListView.builder(
                    itemCount: people.length,
                    itemBuilder: (context, index) =>
                        buildPeople(context, people[index]),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateRegister(),
                  ),
                );
              },
            ),
          ),
      ),
    );
  }

  Widget buildPeople(BuildContext context, People people) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(people.name),
      subtitle: Text('Altura: ${people.height.toString()} | Peso: ${people.weight.toString()} | IMC: ${people.imc.toStringAsFixed(2)}'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateRegister(people: people),
          ),
        );
      },
      onLongPress: () {
        PeopleService.deletePeople(people);
      },
    );
  }
}
