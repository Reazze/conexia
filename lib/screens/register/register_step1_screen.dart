import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'register_step2_screen.dart';

class RegisterStep1Screen extends StatefulWidget {
  const RegisterStep1Screen({super.key});

  @override
  State<RegisterStep1Screen> createState() => _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends State<RegisterStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime? _selectedDate;
  File? _profileImage;

  // Simulación de picker de imagen — integrar image_picker en producción
  void _pickImage() {
    // TODO: Integrar image_picker
    // final picker = ImagePicker();
    // final picked = await picker.pickImage(source: ImageSource.gallery);
    // if (picked != null) setState(() => _profileImage = File(picked.path));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Integra el paquete image_picker para seleccionar foto'),
        backgroundColor: Color(0xFF8B5CF6),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year - 13),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8B5CF6),
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _goToStep2() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RegisterStep2Screen(
            nombre: _nameController.text.trim(),
            correo: _emailController.text.trim(),
            telefono: _phoneController.text.trim(),
            fechaNacimiento: _selectedDate!,
            profileImage: _profileImage,
          ),
        ),
      );
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona tu fecha de nacimiento'),
          backgroundColor: Color(0xFF8B5CF6),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                          _buildStepIndicator(currentStep: 1),
                          const SizedBox(height: 24),
                          _buildSectionTitle(
                            title: 'Tus datos personales',
                            subtitle: 'Cuéntanos un poco sobre ti',
                          ),
                          const SizedBox(height: 34),

                          // ── FOTO DE PERFIL ──
                          _buildAvatarPicker(),
                          const SizedBox(height: 36),

                          // ── NOMBRE ──
                          _buildTextField(
                            controller: _nameController,
                            label: 'Nombre completo',
                            hint: 'Ej: María García López',
                            icon: Icons.person_outline,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Ingresa tu nombre';
                              if (v.trim().length < 3) return 'Mínimo 3 caracteres';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // ── CORREO ──
                          _buildTextField(
                            controller: _emailController,
                            label: 'Correo electrónico',
                            hint: 'ejemplo@correo.com',
                            icon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Ingresa tu correo';
                              final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$');
                              if (!emailRegex.hasMatch(v.trim())) return 'Correo no válido';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // ── TELÉFONO ──
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Teléfono',
                            hint: '+51 999 999 999',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return 'Ingresa tu teléfono';
                              if (v.trim().length < 9) return 'Número inválido';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // ── FECHA DE NACIMIENTO ──
                          _buildDatePicker(),
                          const SizedBox(height: 32),

                          // ── BOTÓN SIGUIENTE ──
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
            Color(0xFFE8F2FF),
            Color(0xFFF0E8FF),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF4C1D95)),
            ),
          ),
          const Expanded(
            child: Text(
              'Crear cuenta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B1F8C),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // STEP INDICATOR
  // ─────────────────────────────────────────
  Widget _buildStepIndicator({required int currentStep}) {
    return Row(
      children: List.generate(3, (i) {
        final step = i + 1;
        final isActive = step == currentStep;
        final isDone = step < currentStep;
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
                                colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                              )
                            : null,
                        color: isActive || isDone ? null : const Color(0xFFE5E7EB),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      step == 1 ? 'Datos' : step == 2 ? 'Contraseña' : 'Verificar',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        color: isActive ? const Color(0xFF6D28D9) : const Color(0xFF9CA3AF),
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

  // ─────────────────────────────────────────
  // SECTION TITLE
  // ─────────────────────────────────────────
  Widget _buildSectionTitle({ required String title, required String subtitle}) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF3B1F8C))),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
      ],
    );
  }

  // ─────────────────────────────────────────
  // AVATAR PICKER
  // ─────────────────────────────────────────
  Widget _buildAvatarPicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 96, height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFEDE9FE), Color(0xFFDDD6FE)],
              ),
              border: Border.all(color: const Color(0xFF8B5CF6), width: 2.5),
              image: _profileImage != null
                  ? DecorationImage(image: FileImage(_profileImage!), fit: BoxFit.cover)
                  : null,
            ),
            child: _profileImage == null
                ? const Icon(Icons.person, size: 44, color: Color(0xFF8B5CF6))
                : null,
          ),
          Container(
            width: 30, height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
              ),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // TEXT FIELD REUTILIZABLE
  // ─────────────────────────────────────────
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4C1D95))),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFD1D5DB)),
            prefixIcon: Icon(icon, size: 20, color: const Color(0xFF8B5CF6)),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // DATE PICKER
  // ─────────────────────────────────────────
  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Fecha de nacimiento', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4C1D95))),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _selectedDate != null ? const Color(0xFF8B5CF6) : const Color(0xFFE5E7EB),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 20, color: Color(0xFF8B5CF6)),
                const SizedBox(width: 12),
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
                      : 'DD / MM / AAAA',
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectedDate != null ? const Color(0xFF1F2937) : const Color(0xFFD1D5DB),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_drop_down, color: Color(0xFF8B5CF6)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // BOTÓN SIGUIENTE
  // ─────────────────────────────────────────
  Widget _buildNextButton() {
    return GestureDetector(
      onTap: _goToStep2,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Continuar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}