import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do List", style: TextStyle())),
      body: Consumer<to_do_provider>(
        builder: (context, provider, child) {
          final tasks = provider.todoList;
          if (tasks.isEmpty) {
            return Center(
              child: Text("No tasks available", style: TextStyle(fontSize: 18)),
            );
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.romove_task(index);
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 8, spreadRadius: 1),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  height: 250,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add New",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                          hintText: "Enter task",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final task = taskController.text;
                            if (task.trim().isNotEmpty) {
                              context.read<to_do_provider>().add_task(task);
                            }
                            // taskController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text("Add Task"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor: const Color(0xFFFF0A80),
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 48),
        ),
      ),
    );
  }
}
