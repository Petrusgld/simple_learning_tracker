import 'package:flutter/material.dart';
import 'package:simple_learning_tracker/models/todo.dart';
import 'package:simple_learning_tracker/components/CButton.dart';
import 'package:simple_learning_tracker/components/CTextfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(name: _controller.text));
      });
      _controller.clear();
      Navigator.pop(context);
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Tambah Tugas"),
        content: CTextField(controller: _controller, hintText: "Tulis tugas di sini..."),
        actions: [
          CButton(text: "Batal", color: Colors.red, onPressed: () => Navigator.pop(context)),
          CButton(text: "Simpan", onPressed: _addTodo),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App"), centerTitle: true),
      body: _todos.isEmpty
          ? const Center(child: Text("Belum ada tugas hari ini."))
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ListTile(
                    leading: Checkbox(
                      value: _todos[index].isDone,
                      onChanged: (val) {
                        setState(() => _todos[index].isDone = val!);
                      },
                    ),
                    title: Text(
                      _todos[index].name,
                      style: TextStyle(
                        decoration: _todos[index].isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => setState(() => _todos.removeAt(index)),
                    ),
                  ),
                );
              },
            ),
      
      
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CButton(
            text: "+ Tambah Tugas Baru",
            isFullWidth: true, 
            onPressed: _showAddDialog,
          ),
        ),
      ),
    );
  }
}