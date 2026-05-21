import 'package:flutter/material.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  bool _showPassword = false;
  bool _captchaChecked = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_captchaChecked) {
      _showSnack('Por favor confirma que no eres un robot');
      return;
    }
    setState(() => _isLoading = true);
    // TODO: Integrar Firebase Auth
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //   email: _userController.text.trim(),
    //   password: _passController.text,
    // );
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    if (mounted) {
      // TODO: Navegar al Home
      // Navigator.pushAndRemoveUntil(context,
      //   MaterialPageRoute(builder: (_) => const HomeScreen()), (_) => false);
      _showSnack('¡Inicio de sesión exitoso!');
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: const Color(0xFF7C3AED),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildSparkles(),
          SafeArea(
            child: Column(
              children: [
                _buildBackButton(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        _buildHeader(),
                        const SizedBox(height: 28),
                        _buildFormCard(context),
                        const SizedBox(height: 24),
                        _buildIllustration(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // FONDO
  // ─────────────────────────────────────────
  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEDE8FF),
            Color(0xFFFFE8F8),
            Color(0xFFE8F0FF),
            Color(0xFFF5E8FF),
          ],
          stops: [0.0, 0.35, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            left: -60,
            child: _glowCircle(220, const Color(0xFFC4B5FD).withValues(alpha: 0.3)),
          ),
          Positioned(
            top: 160,
            right: -80,
            child: _glowCircle(260, const Color(0xFFFDA4AF).withValues(alpha: 0.2)),
          ),
          Positioned(
            bottom: -40,
            left: -20,
            child: _glowCircle(200, const Color(0xFF93C5FD).withValues(alpha: 0.2)),
          ),
          // Swirl diagonal
          Positioned(
            top: 80,
            left: -40,
            child: Transform.rotate(
              angle: -0.35,
              child: Container(
                width: 420,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.35),
                      const Color(0xFFC4B5FD).withValues(alpha: 0.1)
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

  Widget _glowCircle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );

  // ─────────────────────────────────────────
  // DESTELLOS
  // ─────────────────────────────────────────
  Widget _buildSparkles() {
    return Stack(
      children: [
        _spark(top: 110, left: 28, size: 14, color: const Color(0xFF8B5CF6)),
        _spark(top: 200, right: 30, size: 10, color: const Color(0xFFFBBF24)),
        _spark(top: 320, right: 20, size: 12, color: const Color(0xFFFBBF24)),
        _spark(
            top: 420,
            left: 22,
            size: 10,
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.5)),
      ],
    );
  }

  Widget _spark(
      {double? top,
      double? bottom,
      double? left,
      double? right,
      required double size,
      required Color color}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Icon(Icons.auto_awesome, size: size, color: color),
    );
  }

  // ─────────────────────────────────────────
  // BOTÓN ATRÁS
  // ─────────────────────────────────────────
  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8)
              ],
            ),
            child: const Icon(Icons.chevron_left,
                size: 24, color: Color(0xFF4C1D95)),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────
  Widget _buildHeader() {
    return Column(
      children: [
        // Ícono chat morado
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6)),
            ],
          ),
          child: const Icon(Icons.people, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 14),
        // CONEXIA + destello
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CONEXIA',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2D1B69),
                  letterSpacing: 1.5),
            ),
            SizedBox(width: 4),
            Icon(Icons.auto_awesome, size: 18, color: Color(0xFF8B5CF6)),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          '¡Bienvenido de nuevo!',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937)),
        ),
        const SizedBox(height: 6),
        const Text(
          'Inicia sesión para seguir conectado',
          style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // FORM CARD
  // ─────────────────────────────────────────
  Widget _buildFormCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8)),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── USUARIO ──
              const Text('Usuario',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937))),
              const SizedBox(height: 10),
              _buildField(
                controller: _userController,
                hint: 'Introduce tu usuario',
                icon: Icons.person_outline,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Ingresa tu usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // ── CONTRASEÑA ──
              const Text('Contraseña',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937))),
              const SizedBox(height: 10),
              _buildPasswordField(),
              const SizedBox(height: 16),

              // ── reCAPTCHA ──
              _buildCaptcha(),
              const SizedBox(height: 20),

              // ── BOTÓN LOGIN ──
              _buildLoginButton(),
              const SizedBox(height: 16),

              // ── OLVIDASTE CONTRASEÑA ──
              Center(
                child: GestureDetector(
                  onTap: () => _showForgotPasswordSheet(context),
                  child: const Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7C3AED),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Divider(color: Color(0xFFF3F4F6)),
              const SizedBox(height: 14),

              // ── REGISTRO ──
              Center(
                child: Column(
                  children: [
                    const Text('¿No tienes cuenta?',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navegar a registro
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterStep1Screen()));
                      },
                      child: const Text(
                        'Regístrate aquí',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7C3AED)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // CAMPO TEXTO
  // ─────────────────────────────────────────
  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFD1D5DB)),
        prefixIcon: Container(
          width: 48,
          margin: const EdgeInsets.only(right: 4),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F3FF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF8B5CF6)),
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 52, minHeight: 52),
        filled: true,
        fillColor: const Color(0xFFFAF9FF),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFEDE9FE))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFEDE9FE), width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  // ─────────────────────────────────────────
  // CAMPO CONTRASEÑA
  // ─────────────────────────────────────────
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passController,
      obscureText: !_showPassword,
      validator: (v) {
        if (v == null || v.isEmpty) return 'Ingresa tu contraseña';
        if (v.length < 6) return 'Mínimo 6 caracteres';
        return null;
      },
      style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
      decoration: InputDecoration(
        hintText: 'Introduce tu contraseña',
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFD1D5DB)),
        prefixIcon: Container(
          width: 48,
          margin: const EdgeInsets.only(right: 4),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F3FF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
          ),
          child: const Icon(Icons.lock_outline,
              size: 20, color: Color(0xFF8B5CF6)),
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 52, minHeight: 52),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _showPassword = !_showPassword),
          child: Icon(
            _showPassword
                ? Icons.visibility_off_outlined
                : Icons.remove_red_eye_outlined,
            size: 20,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFFAF9FF),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFEDE9FE))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFEDE9FE), width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  // ─────────────────────────────────────────
  // CAPTCHA SIMULADO
  // ─────────────────────────────────────────
  Widget _buildCaptcha() {
    return GestureDetector(
      onTap: () => setState(() => _captchaChecked = !_captchaChecked),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF9FF),
          border: Border.all(
            color: _captchaChecked
                ? const Color(0xFF10B981)
                : const Color(0xFFEDE9FE),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // Checkbox simulado
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _captchaChecked ? const Color(0xFF10B981) : Colors.white,
                border: Border.all(
                  color: _captchaChecked
                      ? const Color(0xFF10B981)
                      : const Color(0xFFD1D5DB),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: _captchaChecked
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            const Text(
              'No soy un robot',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            // Logo reCAPTCHA
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A90D9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text('rC',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                const Text('reCAPTCHA',
                    style: TextStyle(fontSize: 8, color: Color(0xFF9CA3AF))),
                const Text('Privacidad · Términos',
                    style: TextStyle(fontSize: 7, color: Color(0xFF9CA3AF))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BOTÓN LOGIN
  // ─────────────────────────────────────────
  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _login,
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
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Iniciar sesión',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(width: 10),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: const Icon(Icons.arrow_forward,
                  color: Colors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // ILUSTRACIÓN INFERIOR
  // ─────────────────────────────────────────
  Widget _buildIllustration() {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ícono chat izquierda
          Positioned(
            left: 40,
            top: 10,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF8B5CF6),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                      blurRadius: 10)
                ],
              ),
              child: const Icon(Icons.people, color: Colors.white, size: 26),
            ),
          ),
          // Coin arriba centro
          Positioned(
            top: 0,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFF59E0B),
                      blurRadius: 12,
                      offset: Offset(0, 4))
                ],
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 24),
            ),
          ),
          // Ícono chart derecha
          Positioned(
            right: 40,
            top: 10,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                      blurRadius: 10)
                ],
              ),
              child: const Icon(Icons.bar_chart, color: Colors.white, size: 26),
            ),
          ),
          // Destellos
          const Positioned(
              left: 100,
              top: 14,
              child:
                  Icon(Icons.auto_awesome, size: 12, color: Color(0xFFFBBF24))),
          const Positioned(
              right: 105,
              bottom: 60,
              child: Icon(Icons.favorite, size: 12, color: Color(0xFFEC4899))),
          const Positioned(
              right: 130,
              top: 30,
              child:
                  Icon(Icons.auto_awesome, size: 10, color: Color(0xFF8B5CF6))),
          // Avatares personajes (placeholder)
          Positioned(
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildAvatar(const Color(0xFFA855F7), 60),
                _buildAvatar(const Color(0xFF3B82F6), 75),
                _buildAvatar(const Color(0xFFEC4899), 60),
              ],
            ),
          ),
          // Nota: Reemplazar los avatares con:
          // Image.asset('assets/images/hero_illustration.png', height: 160, fit: BoxFit.contain)
        ],
      ),
    );
  }

  Widget _buildAvatar(Color color, double size) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
      ),
      child: Icon(Icons.person, color: color, size: size * 0.5),
    );
  }

  // ─────────────────────────────────────────
  // FORGOT PASSWORD SHEET
  // ─────────────────────────────────────────
  void _showForgotPasswordSheet(BuildContext context) {
    final emailCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              const Text('🔑', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 12),
              const Text('¿Olvidaste tu contraseña?',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937))),
              const SizedBox(height: 8),
              const Text(
                  'Ingresa tu correo y te enviaremos un enlace para restablecerla.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
              const SizedBox(height: 20),
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'tu@correo.com',
                  prefixIcon: const Icon(Icons.mail_outline,
                      color: Color(0xFF8B5CF6), size: 20),
                  filled: true,
                  fillColor: const Color(0xFFF9F8FF),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFEDE9FE))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFEDE9FE))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(color: Color(0xFF8B5CF6), width: 2)),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _showSnack('Enlace enviado a ${emailCtrl.text}');
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Center(
                    child: Text('Enviar enlace',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // LOADING OVERLAY
  // ─────────────────────────────────────────
  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black26,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Color(0xFF8B5CF6)),
              SizedBox(height: 16),
              Text('Iniciando sesión...',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4C1D95),
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
