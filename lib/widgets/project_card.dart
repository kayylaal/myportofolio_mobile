import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/social_work_form.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          if (item.name == 'Tambah Proyek') {
            final allowed = await ensureLoggedIn(context);
            if (!context.mounted || !allowed) return;
            Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const ProjectFormPage()),
            );
            return;
          }

          if (item.name == 'Lihat Proyek') {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const ProjectListScreen(),
              ),
            );
            return;
          }

          if (item.name == 'Logout') {
            final auth = context.read<AuthState>();
            if (auth.isLoggedIn) {
              await auth.logout();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kamu berhasil logout.')),
              );
            } else {
              await Navigator.push<bool>(
                context,
                MaterialPageRoute<bool>(builder: (_) => const LoginScreen()),
              );
            }
            return;
          }

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu telah menekan tombol ${item.name}!'),
              ),
            );

          if (item.name == 'Tambah Social Work') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SocialWorkFormPage(),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: item.foregroundColor, size: 30),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: item.foregroundColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
