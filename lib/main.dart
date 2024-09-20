import 'package:flutter/material.dart';
import 'package:novo_projeto/views/list_view_tasks.dart';
import 'package:novo_projeto/views/form_view_tasks.dart'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 19, 72, 146),
        ),
        useMaterial3: false,
      ),
      home: const HomeScreen(),
      routes: {
        '/listarTarefas': (context) => const ListViewTasks(), 
        '/formulariosTarefas': (context) => const FormTasks(), 
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tarefas')),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Alex Sandro Machado', style: TextStyle(fontSize: 24)),
              accountEmail: Text('alexmachado@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Listagem de Tarefas'),
              onTap: () {
                Navigator.pushNamed(context, '/listarTarefas');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          const Center(child: Text('Tela Inicial')),
          Positioned(
            bottom: 20,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/formulariosTarefas');
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
