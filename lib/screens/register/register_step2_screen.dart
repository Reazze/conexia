import 'dart:io';
import 'package:flutter/material.dart';
import 'register_step3_screen.dart';

class RegisterStep2Screen extends StatefulWidget {
  final String nombre;
  final String correo;
  final String telefono;
  final DateTime fechaNacimiento;
  final File? profileImage;

  const RegisterStep2Screen({
    super.key,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.fechaNacimiento,
    this.profileImage,
  });

  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirm = false;

  // Indicadores de fortaleza
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecial = false;

  void _checkStrength(String value) {
    setState(() {
      _hasMinLength = value.length >= 8;
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasSpecial = value.contains(RegExp(r'[!@#\$&*~%^]'));
    });
  }

  int get _strengthScore => [
        _hasMinLength,
        _hasUppercase,
        _hasNumber,
        _hasSpecial
      ].where((e) => e).length;

  Color get _strengthColor {
    if (_strengthScore <= 1) return const Color(0xFFEF4444);
    if (_strengthScore == 2) return const Color(0xFFF59E0B);
    if (_strengthScore == 3) return const Color(0xFF3B82F6);
    return const Color(0xFF10B981);
  }

  String get _strengthLabel {
    if (_strengthScore <= 1) return 'Débil';
    if (_strengthScore == 2) return 'Regular';
    if (_strengthScore == 3) return 'Buena';
    return 'Fuerte ✓';
  }

  void _goToStep3() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RegisterStep3Screen(
            nombre: widget.nombre,
            correo: widget.correo,
            telefono: widget.telefono,
            fechaNacimiento: widget.fechaNacimiento,
            profileImage: widget.profileImage,
            password: _passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          _buildStepIndicator(),
                          const SizedBox(height: 28),

                          // Ícono y título
                          const Text('🔐', style: TextStyle(fontSize: 40)),
                          const SizedBox(height: 10),
                          const Text(
                            'Crea tu contraseña',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3B1F8C)),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Elige una contraseña segura para proteger tu cuenta',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF9CA3AF)),
                          ),
                          const SizedBox(height: 28),

                          // Resumen de datos del step 1
                          _buildDataSummary(),
                          const SizedBox(height: 24),

                          // Campo contraseña
                          _buildPasswordField(),
                          const SizedBox(height: 12),

                          // Indicador de fortaleza
                          if (_passwordController.text.isNotEmpty)
                            _buildStrengthIndicator(),
                          const SizedBox(height: 16),

                          // Campo confirmar
                          _buildConfirmField(),
                          const SizedBox(height: 12),

                          // Requisitos
                          _buildRequirements(),
                          const SizedBox(height: 32),

                          _buildNextButton(),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEDE8FF),
            Color(0xFFFFE8F8),
            Color(0xFFE8F2FF),
            Color(0xFFF0E8FF),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  size: 16, color: Color(0xFF4C1D95)),
            ),
          ),
          const Expanded(
            child: Text(
              'Crear cuenta',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B1F8C)),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final steps = ['Datos', 'Contraseña', 'Verificar'];
    return Row(
      children: List.generate(3, (i) {
        final step = i + 1;
        final isActive = step == 2;
        final isDone = step < 2;
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: isActive || isDone
                            ? const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)])
                            : null,
                        color:
                            isActive || isDone ? null : const Color(0xFFE5E7EB),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      steps[i],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                        color: isActive
                            ? const Color(0xFF6D28D9)
                            : isDone
                                ? const Color(0xFF8B5CF6)
                                : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              if (i < 2) const SizedBox(width: 6),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDataSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE9FE), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                  colors: [Color(0xFFEDE9FE), Color(0xFFDDD6FE)]),
              border: Border.all(color: const Color(0xFF8B5CF6), width: 1.5),
              image: widget.profileImage != null
                  ? DecorationImage(
                      image: FileImage(widget.profileImage!), fit: BoxFit.cover)
                  : null,
            ),
            child: widget.profileImage == null
                ? const Icon(Icons.person, size: 22, color: Color(0xFF8B5CF6))
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.nombre,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937))),
                Text(widget.correo,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF9CA3AF))),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 20),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Contraseña',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4C1D95))),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_showPassword,
          onChanged: _checkStrength,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Ingresa una contraseña';
            if (v.length < 8) return 'Mínimo 8 caracteres';
            return null;
          },
          style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: const TextStyle(color: Color(0xFFD1D5DB)),
            prefixIcon: const Icon(Icons.lock_outline,
                size: 20, color: Color(0xFF8B5CF6)),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _showPassword = !_showPassword),
              child: Icon(
                  _showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: const Color(0xFF9CA3AF)),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Color(0xFFE5E7EB), width: 1.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Color(0xFF8B5CF6), width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Color(0xFFEF4444), width: 1.5)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildStrengthIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(
              4,
              (i) => Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: i < _strengthScore
                            ? _strengthColor
                            : const Color(0xFFE5E7EB),
                      ),
                    ),
                  )),
        ),
        const SizedBox(height: 6),
        Text(
          'Seguridad: $_strengthLabel',
          style: TextStyle(
              fontSize: 12, color: _strengthColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildConfirmField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Confirmar contraseña',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4C1D95))),
        const SizedBox(height: 8),
        TextFormField(
          controller: _confirmController,
          obscureText: !_showConfirm,
          validator: (v) {
            if (v == null || v.isEmpty) return 'Confirma tu contraseña';
            if (v != _passwordController.text) {
              return 'Las contraseñas no coinciden';
            }
            return null;
          },
          style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: const TextStyle(color: Color(0xFFD1D5DB)),
            prefixIcon: const Icon(Icons.lock_outline,
                size: 20, color: Color(0xFF8B5CF6)),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _showConfirm = !_showConfirm),
              child: Icon(
                  _showConfirm
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: const Color(0xFF9CA3AF)),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Color(0xFFE5E7EB), width: 1.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Color(0xFF8B5CF6), width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Color(0xFFEF4444), width: 1.5)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildRequirements() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDE9FE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Requisitos',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C1D95))),
          const SizedBox(height: 10),
          _reqRow('Mínimo 8 caracteres', _hasMinLength),
          _reqRow('Una letra mayúscula', _hasUppercase),
          _reqRow('Un número', _hasNumber),
          _reqRow('Un carácter especial (!@#\$)', _hasSpecial),
        ],
      ),
    );
  }

  Widget _reqRow(String label, bool met) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: met ? const Color(0xFF10B981) : const Color(0xFFD1D5DB),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color:
                      met ? const Color(0xFF10B981) : const Color(0xFF9CA3AF))),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: _goToStep3,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6))
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Continuar',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
