import 'package:flutter/material.dart';
import 'package:prueba_tecnica/model/courses.dart';
import 'package:prueba_tecnica/model/mertorias.dart';
import 'package:prueba_tecnica/pages/mentoria_details/mentoria_details.dart';
import 'package:prueba_tecnica/service/api_service.dart';

class CourseDetail extends StatelessWidget {
  final Course curso;

  CourseDetail({required this.curso});

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        "https://load-qv4lgu7kga-uc.a.run.app/images/${curso.image}";
    return Scaffold(
      appBar: AppBar(
        title: Text(curso.title),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjeta de imagen del curso
            Card(
              margin: EdgeInsets.all(16.0),
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error, size: 50));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curso.description,
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Características:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...curso.characteristics.map((char) => Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.teal),
                          SizedBox(width: 5),
                          Text('${char.description}',
                              style: TextStyle(fontSize: 16)),
                        ],
                      )),
                ],
              ),
            ),
            Divider(thickness: 2, color: Colors.teal),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mentorías Relacionadas',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            // Lista de mentorías relacionadas
            FutureBuilder<List<Mentoria>>(
              future: ApiService().fetchMentorias(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].description,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(snapshot.data![index].detail,
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                          leading: Icon(Icons.school, color: Colors.teal),
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
            ),
          ],
        ),
      ),
    );
  }
}
