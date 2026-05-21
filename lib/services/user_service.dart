import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);

      return data.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception('Error al cargar usuarios');
    }
  }
}
