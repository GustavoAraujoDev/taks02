import 'package:flutter/material.dart';
import 'bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    taskBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: StreamBuilder<List<Task>>(
        stream: taskBloc.tasks,
        initialData: [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskBloc.handleTask(
                        TaskAction.remove, snapshot.data![index]);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Adicionar Tarefa'),
                content: TextField(
                  controller: _taskController,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      taskBloc.handleTask(
                          TaskAction.add, Task(_taskController.text));
                      _taskController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
