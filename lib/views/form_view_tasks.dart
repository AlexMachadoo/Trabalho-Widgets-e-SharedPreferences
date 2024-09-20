import 'package:flutter/material.dart';
import 'package:novo_projeto/models/task_model.dart';
import 'package:novo_projeto/services/task_services.dart';

class FormTasks extends StatefulWidget {
  final Task? task;
  final int? index;

  const FormTasks({super.key, this.task, this.index});

  @override
  State<FormTasks> createState() => _FormTasksState();
}

class _FormTasksState extends State<FormTasks> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final TaskService _taskService = TaskService();

  String _priority = 'Baixa';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title ?? '';
      _descriptionController.text = widget.task!.description ?? '';
      _priority = widget.task!.priority;
    }
  }

  Future<void> _saveTask() async {
    String title = _titleController.text;
    String description = _descriptionController.text;
    bool isDone = widget.task?.isDone ?? false;

    if (widget.index != null) {
      await _taskService.editTask(
        widget.index!,
        title,
        description,
        isDone,
        _priority,
      );
    } else {
      await _taskService.saveTask(title, description, _priority);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Nova Tarefa' : 'Editar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            Text('Prioridade:'),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Baixa'),
                    leading: Radio<String>(
                      value: 'Baixa',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value ?? 'Baixa';
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Média'),
                    leading: Radio<String>(
                      value: 'Média',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value ?? 'Baixa';
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Alta'),
                    leading: Radio<String>(
                      value: 'Alta',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value ?? 'Baixa';
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text(widget.task == null ? 'Criar Tarefa' : 'Alterar Tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}
