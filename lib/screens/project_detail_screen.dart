import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final thumbnail = project.thumbnail?.trim();
    final thumbnailUrl = thumbnail == null || thumbnail.isEmpty
        ? null
        : (Uri.tryParse(thumbnail)?.hasScheme ?? false)
        ? thumbnail
        : Uri.parse(apiBaseUrl).resolve(thumbnail).toString();

    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (thumbnailUrl != null) ...[
            Image.network(
              thumbnailUrl,
              height: 220,
              fit: BoxFit.cover,
              webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
              errorBuilder: (context, error, stackTrace) => SizedBox(
                height: 220,
                child: ColoredBox(
                  color: const Color(0xFFE5CCD2),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Gagal memuat thumbnail.\n$thumbnailUrl\n$error',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(project.description),
          if (project.link?.isNotEmpty ?? false) ...[
            const SizedBox(height: 12),
            Text('Project link: ${project.link}'),
          ],
        ],
      ),
    );
  }
}
