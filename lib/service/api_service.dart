import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/model/courses.dart';
import 'package:prueba_tecnica/model/mertorias.dart';

class ApiService {
  final String baseUrl = 'https://load-qv4lgu7kga-uc.a.run.app';

  Future<List<Mentoria>> fetchMentorias() async {
    final response = await http.get(Uri.parse('$baseUrl/mentorings/all'));

    print('Status code: ${response.statusCode}');
    print('MENTORIAS: ${response.body}'); // Para depuración

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      // Verificar si 'mentorings' existe y no es nulo
      if (jsonResponse['data'] != null &&
          jsonResponse['data']['mentorings'] != null) {
        List<dynamic> mentoriasList = jsonResponse['data']['mentorings'];
        return mentoriasList.map((data) => Mentoria.fromJson(data)).toList();
      } else {
        throw Exception('No mentorias found');
      }
    } else {
      throw Exception('Failed to load mentorias');
    }
  }

  Future<List<Course>> fetchCursos() async {
    final response = await http.get(Uri.parse('$baseUrl/courses/all'));

    print('Status code: ${response.statusCode}');
    print('CURSOS: ${response.body}'); // Para depuración

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      // Accede a la lista de cursos desde 'items'
      if (jsonResponse['data'] != null &&
          jsonResponse['data']['items'] != null) {
        List<dynamic> coursesList = jsonResponse['data']['items'];
        return coursesList.map((data) => Course.fromJson(data)).toList();
      } else {
        throw Exception('No courses found'); // Para manejar ausencia de cursos
      }
    } else {
      throw Exception('Failed to load cursos'); // Manejo de error de conexión
    }
  }
}
