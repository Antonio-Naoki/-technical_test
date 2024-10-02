import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/model/courses.dart';
import 'package:prueba_tecnica/model/mertorias.dart';

class ApiService {
  final String baseUrl = 'https://load-qv4lgu7kga-uc.a.run.app';

  Future<List<Mentoria>> fetchMentorias() async {
    final response = await http.get(Uri.parse('$baseUrl/mentorings/all'));

    print('Status code: ${response.statusCode}');
    print('MENTORIAS: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] != null &&
          jsonResponse['data']['mentorings'] != null) {
        List<dynamic> mentoriasList = jsonResponse['data']['mentorings'];
        return mentoriasList.map((data) => Mentoria.fromJson(data)).toList();
      } else {
        throw Exception('no mentorias found');
      }
    } else {
      throw Exception('failed to load mentorias... exception');
    }
  }

  Future<List<Course>> fetchCursos() async {
    final response = await http.get(Uri.parse('$baseUrl/courses/all'));

    print('Status code: ${response.statusCode}');
    print('CURSOS: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] != null &&
          jsonResponse['data']['items'] != null) {
        List<dynamic> coursesList = jsonResponse['data']['items'];
        return coursesList.map((data) => Course.fromJson(data)).toList();
      } else {
        throw Exception('no courses found');
      }
    } else {
      throw Exception('failed to load cursos');
    }
  }
}
