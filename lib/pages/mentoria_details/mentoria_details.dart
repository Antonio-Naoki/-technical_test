import 'package:flutter/material.dart';
import 'package:prueba_tecnica/model/mertorias.dart';
import 'package:prueba_tecnica/service/api_service.dart';

class MentoriaDetails extends StatelessWidget {
  final Mentoria mentoria;

  const MentoriaDetails({Key? key, required this.mentoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mentoria.title),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjeta de descripción de la mentoría
            Card(
              margin: EdgeInsets.all(16.0),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Muestra el diálogo con el texto completo
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(mentoria.title),
                            content: Text(mentoria.description),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Cerrar'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        mentoria.description,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Muestra el diálogo con el texto completo
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(mentoria.title),
                            content: SingleChildScrollView(child: Text(mentoria.detail)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Cerrar'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        mentoria.detail,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(thickness: 2, color: Colors.teal),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Características:',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ),
            // Lista de características
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mentoria.characteristics.length,
              itemBuilder: (context, index) {
                final characteristic = mentoria.characteristics[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.teal),
                    title: Text(characteristic.description),
                    subtitle: Text(characteristic.icon,
                        style: TextStyle(color: Colors.grey[600])),
                  ),
                );
              },
            ),
            Divider(thickness: 2, color: Colors.teal),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mentorías Relacionadas',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
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
                          subtitle: Text(
                            snapshot.data![index].detail,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
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
