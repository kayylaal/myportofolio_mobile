import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class SocialWorkFormPage extends StatefulWidget {
  const SocialWorkFormPage({super.key});

  @override
  State<SocialWorkFormPage> createState() => _SocialWorkFormPageState();
}

class _SocialWorkFormPageState extends State<SocialWorkFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _photo = "";
  String _year = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Social Work Form')),
        backgroundColor: const Color(0xFF060201),
        foregroundColor: const Color(0xFFFFF8ED),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Social Work Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 255,
                  decoration: InputDecoration(
                    hintText: "Nama Social Work",
                    labelText: "Nama Social Work",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama social work tidak boleh kosong!";
                    }
                    if (value.length > 255) {
                      return "Nama Social Work maksimal 255 karakter.";
                    }
                    return null;
                  },
                ),
              ),
              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Social Work",
                    labelText: "Deskripsi Social Work",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi social work tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              // === Photo ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "URL foto (opsional)",
                    labelText: "Tautan Foto",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _photo = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    final photo = value?.trim() ?? "";
                    if (photo.isEmpty) return null;

                    final uri = Uri.tryParse(photo);
                    if (uri == null ||
                        !uri.hasScheme ||
                        (uri.scheme != "http" && uri.scheme != "https") ||
                        uri.host.isEmpty) {
                      return "Masukkan URL foto yang valid (http/https)!";
                    }
                    return null;
                  },
                ),
              ),
              // === Tahun ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Tahun Social Work (opsional)",
                    labelText: "Tahun",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _year = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    final yearText = value?.trim() ?? "";
                    if (yearText.isEmpty) return null;

                    final year = int.tryParse(yearText);
                    if (year == null ||
                        year < 1900 ||
                        year > DateTime.now().year) {
                      return "Masukkan tahun antara 1900 dan ${DateTime.now().year}!";
                    }
                    return null;
                  },
                ),
              ),
              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0xFFE5CCD2),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Social Work berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Nama Social Work: $_title'),
                                    Text('Deskripsi: $_description'),
                                    if (_photo.trim().isNotEmpty)
                                      Text('URL Foto: $_photo'),
                                    if (_year.trim().isNotEmpty)
                                      Text('Tahun: $_year'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Color(0xFF060201)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
