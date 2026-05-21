import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 198, 185, 242), // lavanda claro
              Color.fromARGB(255, 255, 255, 255), // rosa claro
              Color(0xFFE8EEFF), // azul lavanda
              Color.fromARGB(255, 247, 247, 248), // rosa muy claro
            ],
            stops: [0.0, 0.35, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // ── Logotipo 3D ──
                  _buildIllustration(),

                  // ── TÍTULO BIENVENIDA ──
                  _buildTitleSection(),

                  // ── IMAGEN + NOMBRE ──
                  _buildLogoSection(),

                  // ── TARJETA DE FEATURES ──
                  _buildFeaturesCard(),

                  const SizedBox(height: 20),
                  // ── CHECKBOX TÉRMINOS ──
                  _buildTermsCheckbox(),

                  const SizedBox(height: 10),

                  // ── BOTÓN COMENZAR ──
                  _buildPrimaryButton(context),

                  // ── FOOTER ──

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // // ─────────────────────────────────────────
  // // LOGO SECTION
  // // ─────────────────────────────────────────
  Widget _buildLogoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Image.asset(
        'assets/images/img1.png',
        height: 250,
        width: 350,
        fit: BoxFit.contain,
      ),
    );
  }
}

// ─────────────────────────────────────────
// TÍTULO BIENVENIDA
// ─────────────────────────────────────────
Widget _buildTitleSection() {
  return Column(
    children: [
      RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
          children: [
            TextSpan(text: '¡Bienvenido a '),
            TextSpan(
              text: 'CONEXIA',
              style: TextStyle(color: Color(0xFF7C5CBF)),
            ),
            TextSpan(text: '!'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        'Conéctate con personas increíbles,\ncomparte tus opiniones y \n gana recompensas reales.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Color(0xFF666666),
          height: 1.6,
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────
// ILUSTRACIÓN CENTRAL
// ─────────────────────────────────────────
Widget _buildIllustration() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Image.asset(
      'assets/images/LogotipoSinfondo.png',
      height: 100,
      width: 250,
      fit: BoxFit.contain,
    ),
  );
}

// ─────────────────────────────────────────
// TARJETA DE FEATURES
// ─────────────────────────────────────────
Widget _buildFeaturesCard() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF8B5CF6).withValues(alpha: 0.8),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFeatureItem(
          icon: Icons.group,
          iconColor: const Color(0xFF8B5CF6),
          bgColor: const Color(0xFFF3EEFF),
          title: 'Conecta',
          subtitle: 'con personas\ncomo tú',
        ),
        _buildFeatureDivider(),
        _buildFeatureItem(
          icon: Icons.checklist_rtl,
          iconColor: const Color(0xFF3B82F6),
          bgColor: const Color(0xFFEEF4FF),
          title: 'Participa',
          subtitle: 'en encuestas\ny juegos',
        ),
        _buildFeatureDivider(),
        _buildFeatureItem(
          icon: Icons.attach_money,
          iconColor: const Color(0xFFF59E0B),
          bgColor: const Color(0xFFFFFBEB),
          title: 'Gana',
          subtitle: 'recompensas\nreales',
        ),
      ],
    ),
  );
}

Widget _buildFeatureItem({
  required IconData icon,
  required Color iconColor,
  required Color bgColor,
  required String title,
  required String subtitle,
}) {
  return Column(
    children: [
      Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 26),
      ),
      const SizedBox(height: 10),
      Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A1A2E),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF9CA3AF),
          height: 1.4,
        ),
      ),
    ],
  );
}

Widget _buildFeatureDivider() {
  return Container(
    width: 1,
    height: 60,
    color: const Color(0xFFE5E7EB),
  );
}

// ─────────────────────────────────────────
// CHECKBOX TÉRMINOS Y CONDICIONES
// ─────────────────────────────────────────
Widget _buildTermsCheckbox() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Checkbox(
        value: false,
        activeColor: const Color(0xFF8B5CF6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onChanged: (value) {
        },
      ),
      Expanded(
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 13,
            ),
            children: [
              TextSpan(text: 'Acepto los '),
              TextSpan(
                text: 'términos y condiciones',
                style: TextStyle(
                  color: Color(0xFF8B5CF6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────
// BOTONES
// ─────────────────────────────────────────
Widget _buildPrimaryButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 56,
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        // TODO: Navegar a login
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(

          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.center,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Comenzar',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    ),
  );
}
