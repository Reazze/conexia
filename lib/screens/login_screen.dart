import 'package:flutter/material.dart';
import 'register/register_step1_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── FONDO HOLOGRÁFICO ──
          _buildHolographicBackground(),

          // ── DESTELLOS DECORATIVOS ──
          _buildSparkles(),

          // ── CONTENIDO PRINCIPAL ──
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),

                      // ── TÍTULO ──
                      _buildTitle(),

                      const SizedBox(height: 18),
                    

                      // ── LOGO + TAGLINE ──
                      _buildIllustration(),

                      const SizedBox(height: 16),

                      // ── SUBTÍTULO ──
                      _buildSubtitle(),

                      const SizedBox(height: 28),

                      // ── BOTONES SOCIALES ──
                      _buildGoogleButton(),
                      const SizedBox(height: 14),
                      _buildFacebookButton(),
                      const SizedBox(height: 14),
                      _buildAppleButton(),
                      const SizedBox(height: 14),
                      _buildEmailButton(context),

                      const Spacer(flex: 2),

                      // ── FOOTER ──
                      _buildFooter(context),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // FONDO HOLOGRÁFICO
  // ─────────────────────────────────────────
  Widget _buildHolographicBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEDE8FF), // lavanda
            Color(0xFFFFE8F8), // rosa claro
            Color(0xFFE8F2FF), // azul celeste
            Color(0xFFF0E8FF), // lavanda medio
            Color(0xFFFFECF8), // rosa pálido
          ],
          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Ola decorativa superior izquierda
          Positioned(
            top: -40,
            left: -60,
            child: _buildGlowCircle(
              size: 250,
              color: const Color(0xFFC4B5FD).withValues(alpha: 0.35),
            ),
          ),
          // Ola decorativa centro
          Positioned(
            top: 200,
            right: -80,
            child: _buildGlowCircle(
              size: 300,
              color: const Color(0xFFFDA4AF).withValues(alpha: 0.2),
            ),
          ),
          // Ola decorativa inferior
          Positioned(
            bottom: -60,
            left: -40,
            child: _buildGlowCircle(
              size: 280,
              color: const Color(0xFF93C5FD).withValues(alpha: 0.2),
            ),
          ),
          // Ola diagonal tipo swirl
          Positioned(
            top: 100,
            left: -30,
            child: Transform.rotate(
              angle: -0.4,
              child: Container(
                width: 420,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.4),
                      const Color(0xFFC4B5FD).withValues(alpha: 0.15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowCircle({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  // ─────────────────────────────────────────
  // DESTELLOS
  // ─────────────────────────────────────────
  Widget _buildSparkles() {
    return Stack(
      children: [
        // Destellos dorados
        _sparkle(top: 80, left: 30, size: 16, color: const Color(0xFFFBBF24)),
        _sparkle(top: 120, right: 40, size: 12, color: const Color(0xFFFBBF24)),
        _sparkle(top: 300, right: 25, size: 10, color: const Color(0xFFFBBF24)),
        // Destellos morados
        _sparkle(top: 180, left: 20, size: 10, color: const Color(0xFF8B5CF6)),
        _sparkle(
            top: 450,
            left: 35,
            size: 14,
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.6)),
        // Corazón decorativo
        Positioned(
          bottom: 180,
          left: 28,
          child: Text(
            '💜',
            style: TextStyle(
                fontSize: 18, color: Colors.purple.withValues(alpha: 0.7)),
          ),
        ),
        // Destellos tipo ✦
        _sparkle(top: 560, right: 30, size: 12, color: const Color(0xFFFBBF24)),
        _sparkle(
            bottom: 140, left: 50, size: 10, color: const Color(0xFF60D8FA)),
      ],
    );
  }

  Widget _sparkle({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Icon(Icons.auto_awesome, size: size, color: color),
    );
  }

  // ─────────────────────────────────────────
  // TÍTULO
  // ─────────────────────────────────────────
  Widget _buildTitle() {
    return const Text(
      '¡Bienvenido/a!',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color(0xFF3B1F8C),
        letterSpacing: 0.3,
      ),
    );
  }

  // ─────────────────────────────────────────
  // LOGO
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
// SUBTÍTULO
// ─────────────────────────────────────────
Widget _buildSubtitle() {
  return const Text(
    'Iniciar sesión con...',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color(0xFF4C1D95),
      letterSpacing: 0.2,
    ),
  );
}

// ─────────────────────────────────────────
// BOTÓN GOOGLE
// ─────────────────────────────────────────
Widget _buildGoogleButton() {
  return _SocialButton(
    onTap: () {
      // TODO: implementar Google Sign In
      // GoogleSignIn().signIn();
    },
    backgroundColor: Colors.white,
    borderColor: const Color(0xFFE5E7EB),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo Google multicolor
        SizedBox(
          width: 22,
          height: 22,
          child: CustomPaint(painter: _GoogleLogoPainter()),
        ),
        const SizedBox(width: 12),
        const Text(
          'Continuar con Google',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────
// BOTÓN FACEBOOK
// ─────────────────────────────────────────
Widget _buildFacebookButton() {
  return _SocialButton(
    onTap: () {
      // TODO: implementar Facebook Login
    },
    backgroundColor: const Color(0xFF1877F2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Center(
            child: Text(
              'f',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1877F2),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Continuar con Facebook',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────
// BOTÓN APPLE
// ─────────────────────────────────────────
Widget _buildAppleButton() {
  return _SocialButton(
    onTap: () {
      // TODO: implementar Apple Sign In
    },
    backgroundColor: const Color(0xFF1A1A1A),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.apple, color: Colors.white, size: 24),
        SizedBox(width: 12),
        Text(
          'Continuar con Apple',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────
// BOTÓN CORREO
// ─────────────────────────────────────────
Widget _buildEmailButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (_) => const HomeScreen()),
  (route) => false,
);
      // TODO: Navegar a pantalla de email/registro
      // context.go('/register-email');
    },
    child: Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.5),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                const Icon(Icons.mail_outline, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),
          const Text(
            'Continuar con correo electrónico',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          const Text('✦',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────
// FOOTER
// ─────────────────────────────────────────
Widget _buildFooter(BuildContext context) {
  return Column(
    children: [
      // Decoradores
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('💜', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
              children: [
                const TextSpan(text: '¿No tienes cuenta? '),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const RegisterStep1Screen()));
                              },
                    child: const Text(
                      'Regístrate aquí',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6D28D9),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF6D28D9),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

// ─────────────────────────────────────────
// WIDGET REUTILIZABLE — BOTÓN SOCIAL
// ─────────────────────────────────────────
class _SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color? borderColor;
  final Widget child;

  const _SocialButton({
    required this.onTap,
    required this.backgroundColor,
    required this.child,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

// ─────────────────────────────────────────
// CUSTOM PAINTER — LOGO GOOGLE
// ─────────────────────────────────────────
class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final colors = [
      const Color(0xFF4285F4), // azul
      const Color(0xFFEA4335), // rojo
      const Color(0xFFFBBC05), // amarillo
      const Color(0xFF34A853), // verde
    ];

    final paint = Paint()..style = PaintingStyle.fill;
    const sweepAngle = (2 * 3.14159) / 4;

    for (int i = 0; i < 4; i++) {
      paint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * sweepAngle - 3.14159 / 4,
        sweepAngle,
        true,
        paint,
      );
    }

    // Centro blanco
    paint.color = Colors.white;
    canvas.drawCircle(center, radius * 0.55, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
