import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterStep3Screen extends StatefulWidget {
  final String nombre;
  final String correo;
  final String telefono;
  final DateTime fechaNacimiento;
  final File? profileImage;
  final String password;

  const RegisterStep3Screen({
    super.key,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.fechaNacimiento,
    required this.password,
    this.profileImage,
  });

  @override
  State<RegisterStep3Screen> createState() => _RegisterStep3ScreenState();
}

class _RegisterStep3ScreenState extends State<RegisterStep3Screen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;
  bool _isVerifying = false;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining == 0) {
        t.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    // Auto-verificar cuando los 6 dígitos están completos
    final fullOtp = _otpControllers.map((c) => c.text).join();
    if (fullOtp.length == 6) _verifyOtp(fullOtp);
  }

  Future<void> _verifyOtp(String otp) async {
    setState(() => _isVerifying = true);
    // TODO: Integrar verificación real con Firebase Auth
    // await FirebaseAuth.instance.verifyPhoneNumber(...)
    await Future.delayed(const Duration(seconds: 2)); // Simulación

    setState(() {
      _isVerifying = false;
      _isSuccess = true;
    });

    await Future.delayed(const Duration(seconds: 1));
    if (mounted) _showSuccessAndNavigate();
  }

  void _showSuccessAndNavigate() {
    // TODO: Navegar al Home después del registro exitoso
    // context.go('/home');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _SuccessDialog(nombre: widget.nombre),
    );
  }

  void _resendCode() {
    if (!_canResend) return;
    for (final c in _otpControllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
    _startTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Código reenviado al ${widget.telefono}'),
        backgroundColor: const Color(0xFF8B5CF6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
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
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildStepIndicator(),
                        const SizedBox(height: 32),
                        _buildTopSection(),
                        const SizedBox(height: 32),
                        _buildPhoneCard(),
                        const SizedBox(height: 32),
                        _buildOtpFields(),
                        const SizedBox(height: 24),
                        _buildTimerSection(),
                        const SizedBox(height: 32),
                        _buildVerifyButton(),
                        const SizedBox(height: 24),
                        _buildChangePhone(context),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isVerifying) _buildLoadingOverlay(),
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
        final isActive = i == 2;
        final isDone = i < 2;
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

  Widget _buildTopSection() {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _isSuccess
              ? const Text('✅',
                  key: ValueKey('success'), style: TextStyle(fontSize: 52))
              : const Text('📱',
                  key: ValueKey('phone'), style: TextStyle(fontSize: 52)),
        ),
        const SizedBox(height: 12),
        Text(
          _isSuccess ? '¡Código verificado!' : 'Verifica tu número',
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3B1F8C)),
        ),
        const SizedBox(height: 6),
        Text(
          _isSuccess
              ? '¡Bienvenido/a a Conexia, ${widget.nombre.split(' ').first}!'
              : 'Ingresa el código de 6 dígitos que enviamos a tu teléfono',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 13, color: Color(0xFF9CA3AF), height: 1.5),
        ),
      ],
    );
  }

  Widget _buildPhoneCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE9FE), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEDE9FE),
            ),
            child: const Icon(Icons.phone_outlined,
                size: 18, color: Color(0xFF8B5CF6)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Número verificado',
                  style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              Text(
                '+51 ${widget.telefono}',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937)),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.lock_outline, size: 18, color: Color(0xFF8B5CF6)),
        ],
      ),
    );
  }

  Widget _buildOtpFields() {
    return Column(
      children: [
        const Text(
          'Código de verificación',
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4C1D95)),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (i) => _buildOtpBox(i)),
        ),
      ],
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 46,
      height: 56,
      child: TextFormField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        onChanged: (v) => _onOtpChanged(v, index),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B1F8C)),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.85),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFFE5E7EB), width: 1.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFF8B5CF6), width: 2.5)),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildTimerSection() {
    return Column(
      children: [
        if (!_canResend) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer_outlined,
                  size: 16, color: Color(0xFF9CA3AF)),
              const SizedBox(width: 6),
              Text(
                'Reenviar código en 0:${_secondsRemaining.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Barra de progreso del timer
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _secondsRemaining / 60,
              backgroundColor: const Color(0xFFEDE9FE),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
              minHeight: 4,
            ),
          ),
        ] else
          GestureDetector(
            onTap: _resendCode,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, size: 16, color: Color(0xFF8B5CF6)),
                  SizedBox(width: 6),
                  Text(
                    'Reenviar código',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6D28D9)),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildVerifyButton() {
    final fullOtp = _otpControllers.map((c) => c.text).join();
    final isComplete = fullOtp.length == 6;

    return GestureDetector(
      onTap: isComplete ? () => _verifyOtp(fullOtp) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: isComplete
              ? const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)])
              : null,
          color: isComplete ? null : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isComplete
              ? [
                  BoxShadow(
                      color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6))
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_outlined,
                color: isComplete ? Colors.white : const Color(0xFF9CA3AF),
                size: 20),
            const SizedBox(width: 10),
            Text(
              'Verificar y crear cuenta',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isComplete ? Colors.white : const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePhone(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Text(
        '¿Número incorrecto? Cambiarlo',
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF8B5CF6),
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFF8B5CF6)),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black26,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20)
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Color(0xFF8B5CF6)),
              SizedBox(height: 16),
              Text('Verificando código...',
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

// ─────────────────────────────────────────
// DIÁLOGO DE ÉXITO
// ─────────────────────────────────────────
class _SuccessDialog extends StatelessWidget {
  final String nombre;
  const _SuccessDialog({required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEDE8FF), Color(0xFFFFE8F8)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🎉', style: TextStyle(fontSize: 52)),
            const SizedBox(height: 14),
            const Text(
              '¡Cuenta creada!',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B1F8C)),
            ),
            const SizedBox(height: 8),
            Text(
              '¡Bienvenido/a a Conexia, ${nombre.split(' ').first}!\nYa puedes conectar, crecer y ganar.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14, color: Color(0xFF6B7280), height: 1.5),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                // TODO: context.go('/home');
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ir al inicio',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(width: 8),
                    Icon(Icons.rocket_launch, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
