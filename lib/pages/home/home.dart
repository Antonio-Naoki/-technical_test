import 'package:flutter/material.dart';
import 'package:prueba_tecnica/model/courses.dart';
import 'package:prueba_tecnica/model/mertorias.dart';
import 'package:prueba_tecnica/pages/course_details/course_details.dart';
import 'package:prueba_tecnica/pages/mentoria_details/mentoria_details.dart';
import 'package:prueba_tecnica/service/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Mentoria>> mentorias;
  late Future<List<Course>> cursos;

  @override
  void initState() {
    super.initState();
    mentorias = ApiService().fetchMentorias();
    cursos = ApiService().fetchCursos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSectionTitle('Mentorías', Icons.school),
            _buildMentoriaList(),
            _buildSectionTitle('Cursos', Icons.book),
            _buildCursoList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 28),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMentoriaList() {
    return FutureBuilder<List<Mentoria>>(
      future: mentorias,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.school, color: Colors.teal),
                  title: Text(
                    snapshot.data![index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(snapshot.data![index].description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MentoriaDetails(
                          mentoria: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildCursoList() {
    return FutureBuilder<List<Course>>(
      future: cursos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.book, color: Colors.teal),
                  title: Text(
                    snapshot.data![index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(snapshot.data![index].description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetail(
                          curso: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
