import 'package:flutter/material.dart';
import 'package:novo_projeto/models/task_model.dart';
import 'package:novo_projeto/services/task_services.dart';
import 'package:novo_projeto/views/form_view_tasks.dart';

class ListViewTasks extends StatefulWidget {
  const ListViewTasks({super.key});

  @override
  State<ListViewTasks> createState() => _ListViewTasksState();
}

class _ListViewTasksState extends State<ListViewTasks> {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _getAllTasks();
  }

  Future<void> _getAllTasks() async {
    try {
      List<Task> fetchedTasks = await _taskService.getTasks();
      setState(() {
        _tasks = fetchedTasks;
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Alta':
        return Colors.red;
      case 'Média':
        return Colors.amber;
      case 'Baixa':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          var task = _tasks[index];
          bool localIsDone = task.isDone;

          return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          task.title ?? 'Sem Título',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, 
                            decoration: localIsDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      Checkbox(
                        value: localIsDone,
                        onChanged: (value) async {
                          if (value != null) {
                            await _taskService.editTask(
                              index,
                              task.title ?? '',
                              task.description ?? '',
                              value,
                              task.priority,
                            );
                            setState(() {
                              _tasks[index].isDone = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Text(
                    task.description ?? 'Sem Descrição',
                    style: TextStyle(
                      fontSize: 17,
                      color: localIsDone ? Colors.grey[700] : Colors.grey[800], 
                      decoration: localIsDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Prioridade: ${task.priority}',
                      style: TextStyle(
                        fontSize: 16,
                        color: _getPriorityColor(task.priority),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!localIsDone)
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormTasks(
                                  task: task,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      IconButton(
                        onPressed: () async {
                          await _taskService.deleteTask(index);
                          _getAllTasks();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: localIsDone ? Colors.grey : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
