import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

void main() {
  runApp(HostelApp());
}

class HostelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Общежития КубГАУ',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.light(
          primary: Colors.grey[800]!,
          secondary: Colors.orange,
        ),
      ),
      home: HostelInfoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HostelInfoPage extends StatefulWidget {
  @override
  _HostelInfoPageState createState() => _HostelInfoPageState();
}

class _HostelInfoPageState extends State<HostelInfoPage> {
  bool favFlag = false;
  int likeCount = 0;
  String descriptionText = "Студенческий городок или так называемый кампус Кубанского ГАУ состоит из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях университета, при поселении между администрацией и студентами заключается договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. С целью улучшения условий быта студентов активно работает система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Общежития КубГАУ'),
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'pic.jpg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Общежитие №20',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    'Краснодар, ул. Калинина, 13',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          favFlag ? Icons.favorite : Icons.favorite_border,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          setState(() {
                            favFlag = !favFlag;
                            favFlag ? likeCount++ : likeCount--;
                          });
                        },
                      ),
                      Text(
                        '$likeCount',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _createButton(
                        icon: Icons.call,
                        label: 'Позвонить',
                        action: () => _copyText(context, '+7 (918) ххх хх-хх', 'Номер телефона скопирован:'),
                      ),
                      _createButton(
                        icon: Icons.map,
                        label: 'Маршрут',
                        action: () => _copyText(context, 'Краснодар, ул. Калинина, 13', 'Маршрут скопирован:'),
                      ),
                      _createButton(
                        icon: Icons.share,
                        label: 'Поделиться',
                        action: () => _copyText(context, 'https://zapp.run/', 'Ссылка на приложение скопирована:'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    descriptionText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  Widget _createButton({
    required IconData icon,
    required String label,
    required VoidCallback action,
  }) {
    return TextButton.icon(
      icon: Icon(icon, color: Colors.orange),
      label: Text(
        label,
        style: TextStyle(color: Colors.orange),
      ),
      onPressed: action,
    );
  }

  Future<void> _copyText(BuildContext context, String data, String header) async {
    await Clipboard.setData(ClipboardData(text: data));
    _displayAlert(context, header, data);
  }

  void _displayAlert(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[200],
          title: Text(
            title,
            style: TextStyle(color: Colors.grey[800]),
          ),
          content: Text(
            content,
            style: TextStyle(color: Colors.grey[700]),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.orange),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}