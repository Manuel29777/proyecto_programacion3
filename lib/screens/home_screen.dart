import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import '../data_structures/linked_list.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final int totalLogins;

  HomeScreen(this.totalLogins, {super.key});

  final UserService userService = UserService();
  final LinkedList usersList = LinkedList();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String fecha = DateTime.now().toString().substring(0, 16);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),

      body: FutureBuilder<List<UserModel>>(
        future: userService.getUsers(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!;

          if (usersList.head == null) {
            for (var user in users) {
              usersList.insert(user);
            }
          }

          return Column(
            children: [
              Card(
                child: ListTile(
                  title: const Text('Ingresos'),

                  trailing: Text('$totalLogins'),
                ),
              ),

              Card(
                child: ListTile(
                  title: const Text('Usuarios'),

                  trailing: Text('${users.length}'),
                ),
              ),

              Card(
                child: ListTile(
                  title: const Text('Lista enlazada'),

                  trailing: const Text('Activa'),
                ),
              ),

              Card(
                child: ListTile(
                  title: const Text('Último ingreso'),

                  trailing: Text(fecha),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),

                child: TextField(
                  controller: searchController,

                  decoration: const InputDecoration(
                    labelText: 'Buscar usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  ElevatedButton(
                    onPressed: () {
                      var result = usersList.search(searchController.text);

                      if (result != null) {
                        showDialog(
                          context: context,

                          builder: (_) => AlertDialog(
                            title: const Text('Usuario'),

                            content: Text(
                              'Correo: ${result.email}\n'
                              'Ciudad: ${result.city}',
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuario no encontrado'),
                          ),
                        );
                      }

                      searchController.clear();
                    },

                    child: const Text('Buscar'),
                  ),

                  const SizedBox(width: 20),

                  ElevatedButton(
                    onPressed: () {
                      usersList.delete(searchController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuario eliminado')),
                      );

                      searchController.clear();
                    },

                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
