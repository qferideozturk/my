import 'package:flutter/material.dart';

void main() => runApp(EDevletApp());

class EDevletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Devlet',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// GİRİŞ SAYFASI
// GİRİŞ SAYFASI (TC kontrolü ile)
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tcController = TextEditingController();
  final _sifreController = TextEditingController();

  void _login() {
    String tc = _tcController.text.trim();
    String sifre = _sifreController.text;

    if (tc.length != 11 || !RegExp(r'^[0-9]{11}$').hasMatch(tc)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('TC Kimlik Numarası 11 haneli rakam olmalıdır.')),
      );
    } else if (sifre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen şifrenizi giriniz.')),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('e-Devlet Girişi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextFormField(
                controller: _tcController,
                decoration: InputDecoration(labelText: 'T.C. Kimlik No'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _sifreController,
                decoration: InputDecoration(labelText: 'Şifre'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _login,
                icon: Icon(Icons.login),
                label: Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ANA SAYFA
class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'title': 'e-Hizmetler', 'desc': 'Sorgulama, Başvuru ve Ödeme', 'icon': Icons.sync},
    {'title': 'Kurumlar', 'desc': 'Resmi kurum hizmetleri', 'icon': Icons.account_balance},
    {'title': 'Belediyeler', 'desc': 'Belediye hizmetleri', 'icon': Icons.location_city},
    {'title': 'Firmalar', 'desc': 'Şirket bilgileri', 'icon': Icons.factory},
    {'title': 'Üniversiteler', 'desc': 'Üniversite hizmetleri', 'icon': Icons.school},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Column(
          children: [
            // Üst bar
            Container(
              color: Colors.blue[900],
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'turkiye.gov.tr',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.help_outline), color: Colors.white, onPressed: () {}),
                      IconButton(icon: Icon(Icons.search), color: Colors.white, onPressed: () {}),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          );
                        },
                        icon: Icon(Icons.logout),
                        label: Text('Çıkış'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arama kutusu
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Size nasıl yardım edebilirim?',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),

            // Açıklama
            Text(
              'e-Devlet Kapısı ile bilgi ve belgelerinize tek noktadan ulaşabilirsiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue[900], fontSize: 14),
            ),

            SizedBox(height: 10),

            // Kategori kartları
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item['title']} açılıyor...')),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item['icon'], size: 48, color: Colors.blue[800]),
                          SizedBox(height: 10),
                          Text(
                            item['title'],
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                            child: Text(
                              item['desc'],
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[700], fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
