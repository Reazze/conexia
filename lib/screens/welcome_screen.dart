import 'package:flutter/material.dart';

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
              Color(0xFFEDE8FF), // lavanda claro
              Color(0xFFFFE8F5), // rosa claro
              Color(0xFFE8EEFF), // azul lavanda
              Color(0xFFFFF0FA), // rosa muy claro
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
                  const SizedBox(height: 5),

                  // ── Logotipo 3D ──
                  _buildIllustration(),

                  const SizedBox(height: 24),

                  // ── IMAGEN + NOMBRE ──
                  _buildLogoSection(),

                  const SizedBox(height: 28),

                  // ── TÍTULO BIENVENIDA ──
                  _buildTitleSection(),

                  const SizedBox(height: 24),

                  

                  // ── TARJETA DE FEATURES ──
                  _buildFeaturesCard(),

                  const SizedBox(height: 28),

                  // ── BOTÓN COMENZAR ──
                  _buildPrimaryButton(context),

                  const SizedBox(height: 14),

                  // ── BOTÓN INICIAR SESIÓN ──
                  _buildSecondaryButton(context),

                  const SizedBox(height: 20),

                  // ── FOOTER ──
                  _buildFooter(context),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // LOGO SECTION
  // ─────────────────────────────────────────
  Widget _buildLogoSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono de la app
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFFA78BFA),
                      Color(0xFF60D8FA),
                      Color(0xFFF472B6),
                    ],
                  ).createShader(bounds),
                  child: const Text(
                    'e',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'CONEXIA',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Conecta. Crece. Gana.',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF888888),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
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
          'Conéctate con personas increíbles,\ncomparte tus opiniones y gana\nrecompensas reales.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
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
      height: 220,
      fit: BoxFit.contain,
    ),
  );
}
  }

  
  // ─────────────────────────────────────────
  // TARJETA DE FEATURES
  // ─────────────────────────────────────────
  Widget _buildFeaturesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.08),
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
  // BOTONES
  // ─────────────────────────────────────────
  Widget _buildPrimaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Navegar a registro
          // context.go('/register');
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
                color: const Color(0xFF8B5CF6).withOpacity(0.4),
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

  Widget _buildSecondaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: () {
          // TODO: Navegar a login
          // context.go('/login');
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF8B5CF6), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF7C5CBF),
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // FOOTER
  // ─────────────────────────────────────────
  Widget _buildFooter(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: WidgetSpan(
        child: GestureDetector(
          onTap: () {
            // TODO: Navegar a login
          },
          child: RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
              children: [
                TextSpan(text: '¿Ya tienes cuenta? '),
                TextSpan(
                  text: 'Inicia sesión',
                  style: TextStyle(
                    color: Color(0xFF7C5CBF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

