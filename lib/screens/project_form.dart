import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _link = '';
  String _thumbnail = '';
  bool _isSubmitting = false;

  String? _required(String? value, String label) =>
      value == null || value.trim().isEmpty ? '$label wajib diisi.' : null;

  String? _validateOptionalUrl(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final uri = Uri.tryParse(value.trim());
    if (uri == null ||
        !uri.hasScheme ||
        uri.host.isEmpty ||
        !{'http', 'https'}.contains(uri.scheme)) {
      return 'Masukkan URL valid yang diawali http:// atau https://.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final allowed = await ensureLoggedIn(context);
    if (!mounted || !allowed) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;
    setState(() => _isSubmitting = true);

    try {
      final project = Project(
        title: _title.trim(),
        description: _description.trim(),
        link: _link.trim().isEmpty ? null : _link.trim(),
        thumbnail: _thumbnail.trim().isEmpty ? null : _thumbnail.trim(),
      );
      await context.read<ApiClient>().createProject(project, token: token);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Project created'),
          content: const Text('Project berhasil ditambahkan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (mounted) Navigator.pop(context);
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        final loggedIn = await ensureLoggedIn(context);
        if (!mounted || !loggedIn) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan kirim ulang form proyek.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan (${error.statusCode}).')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) => _title = value,
              validator: (value) => _required(value, 'Title'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 4,
              onChanged: (value) => _description = value,
              validator: (value) => _required(value, 'Description'),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Project link (optional)',
              ),
              keyboardType: TextInputType.url,
              onChanged: (value) => _link = value,
              validator: _validateOptionalUrl,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Thumbnail URL (optional)',
              ),
              keyboardType: TextInputType.url,
              onChanged: (value) => _thumbnail = value,
              validator: _validateOptionalUrl,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const CircularProgressIndicator()
                  : const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
