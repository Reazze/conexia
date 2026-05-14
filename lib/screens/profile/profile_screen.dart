import 'dart:io';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ── Data simulada — reemplazar con Firestore ──
  String userName = 'Jose Palomino';
  String userHandle = '@josepalomino';
  String userLocation = 'Huancayo, Perú';
  String userBio = 'Apasionado por la tecnología y el emprendimiento.';
  File? profileImage;

  final int nivelActual = 4;
  final String nivelNombre = 'Explorer';
  final int xpActual = 1250;
  final int xpTotal = 2000;
  final int coins = 2450;
  final double balanceSoles = 24.50;
  final double gananciasTotales = 320.50;

  final List<String> intereses = [
    'Tecnología',
    'Emprendimiento',
    'Finanzas',
    'Videojuegos',
    'Desarrollo Personal',
    'Viajes',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildHeroProfile(context),
                    const SizedBox(height: 16),
                    _buildXPCard(),
                    const SizedBox(height: 16),
                    _buildWalletCard(context),
                    const SizedBox(height: 24),
                    _buildEstadisticas(),
                    const SizedBox(height: 24),
                    _buildIntereses(context),
                    const SizedBox(height: 24),
                    _buildLogros(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // APP BAR
  // ─────────────────────────────────────────
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Image.asset(
            'assets/images/LogotipoSinfondo.png',
            height: 45,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          // Campana
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined,
                    size: 26, color: Color(0xFF4B5563)),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: Color(0xFFEC4899), shape: BoxShape.circle)),
              ),
            ],
          ),
          // Configuración
          IconButton(
            onPressed: () => _showSettingsSheet(context),
            icon: const Icon(Icons.settings_outlined,
                size: 26, color: Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // HERO PROFILE
  // ─────────────────────────────────────────
  Widget _buildHeroProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar con editar
          Stack(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE0D9FF),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                        blurRadius: 16)
                  ],
                  image: profileImage != null
                      ? DecorationImage(
                          image: FileImage(profileImage!), fit: BoxFit.cover)
                      : null,
                ),
                child: profileImage == null
                    ? const Icon(Icons.person,
                        size: 44, color: Color(0xFF8B5CF6))
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _showEditProfileSheet(context),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child:
                        const Icon(Icons.edit, size: 13, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(userName,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827))),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.verified,
                        size: 18, color: Color(0xFF7C3AED)),
                  ],
                ),
                const SizedBox(height: 3),
                Text(userHandle,
                    style: const TextStyle(
                        fontSize: 13, color: Color(0xFF9CA3AF))),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: Color(0xFF9CA3AF)),
                    const SizedBox(width: 3),
                    Text(userLocation,
                        style: const TextStyle(
                            fontSize: 13, color: Color(0xFF6B7280))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Badge nivel
          Container(
            width: 80,
            height: 88,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 22),
                ),
                const SizedBox(height: 6),
                Text('Nivel $nivelActual',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827))),
                Text(nivelNombre,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF9CA3AF))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // XP CARD
  // ─────────────────────────────────────────
  Widget _buildXPCard() {
    final progress = xpActual / xpTotal;
    final xpRestante = xpTotal - xpActual;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04), blurRadius: 12)
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tu progreso',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827))),
                Text('$xpActual / $xpTotal XP',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7C3AED))),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color(0xFFEDE9FE),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF7C3AED)),
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '¡Sigue así! Estás a $xpRestante XP de subir al nivel ${nivelActual + 1}.',
              style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // WALLET CARD
  // ─────────────────────────────────────────
  Widget _buildWalletCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8))
          ],
        ),
        child: Row(
          children: [
            // Lado izquierdo — Coins
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Coins disponibles',
                        style: TextStyle(fontSize: 12, color: Colors.white70)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
                          ),
                          child: const Icon(Icons.star,
                              color: Colors.white, size: 18),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatNumber(coins),
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '≈ S/ ${balanceSoles.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Lado derecho — Balance
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    _buildBalanceRow(
                        'Tu balance',
                        'S/ ${balanceSoles.toStringAsFixed(2)}',
                        const Color(0xFF10B981)),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildBalanceRow(
                        'Ganancias totales',
                        'S/ ${gananciasTotales.toStringAsFixed(2)}',
                        const Color(0xFF111827)),
                    const Divider(height: 1),
                    // Botón Wallet
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_balance_wallet_outlined,
                                color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text('Ir a Wallet',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF9CA3AF))),
                const SizedBox(height: 2),
                Text(value,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: valueColor)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 16, color: Color(0xFF9CA3AF)),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // ESTADÍSTICAS
  // ─────────────────────────────────────────
  Widget _buildEstadisticas() {
    final stats = [
      _StatItem(
          icon: Icons.sports_esports_outlined,
          iconColor: const Color(0xFF8B5CF6),
          iconBg: const Color(0xFFF3EEFF),
          value: '128',
          label: 'Juegos jugados'),
      _StatItem(
          icon: Icons.assignment_turned_in_outlined,
          iconColor: const Color(0xFF10B981),
          iconBg: const Color(0xFFD1FAE5),
          value: '87',
          label: 'Encuestas completadas'),
      _StatItem(
          icon: Icons.people_outline,
          iconColor: const Color(0xFFEC4899),
          iconBg: const Color(0xFFFCE7F3),
          value: '56',
          label: 'Conexiones realizadas'),
      _StatItem(
          icon: Icons.emoji_events_outlined,
          iconColor: const Color(0xFFF59E0B),
          iconBg: const Color(0xFFFEF3C7),
          value: '12',
          label: 'Logros obtenidos'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Mis estadísticas',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827))),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Text('Ver todas',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7C3AED),
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: 2),
                    Icon(Icons.chevron_right,
                        size: 16, color: Color(0xFF7C3AED)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: stats
                .map((s) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: stats.indexOf(s) < 3 ? 10 : 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10)
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                    color: s.iconBg, shape: BoxShape.circle),
                                child:
                                    Icon(s.icon, color: s.iconColor, size: 22),
                              ),
                              const SizedBox(height: 8),
                              Text(s.value,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF111827))),
                              const SizedBox(height: 2),
                              Text(s.label,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF9CA3AF),
                                      height: 1.3)),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // INTERESES
  // ─────────────────────────────────────────
  Widget _buildIntereses(BuildContext context) {
    final colors = [
      const Color(0xFF8B5CF6),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFF3B82F6),
      const Color(0xFFEC4899),
      const Color(0xFF06B6D4),
    ];
    final icons = ['💻', '🚀', '💰', '🎮', '👤', '✈️'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Mis intereses',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827))),
              GestureDetector(
                onTap: () => _showEditInteresesSheet(context),
                child: const Row(
                  children: [
                    Text('Editar',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7C3AED),
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: 4),
                    Icon(Icons.edit_outlined,
                        size: 14, color: Color(0xFF7C3AED)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ...List.generate(
                  intereses.length,
                  (i) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              colors[i % colors.length].withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: colors[i % colors.length]
                                  .withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(icons[i % icons.length],
                                style: const TextStyle(fontSize: 13)),
                            const SizedBox(width: 6),
                            Text(intereses[i],
                                style: TextStyle(
                                    fontSize: 13,
                                    color: colors[i % colors.length],
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      )),
              // Agregar interés
              GestureDetector(
                onTap: () => _showEditInteresesSheet(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFFD1D5DB),
                        style: BorderStyle.solid),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 14, color: Color(0xFF9CA3AF)),
                      SizedBox(width: 4),
                      Text('Agregar interés',
                          style: TextStyle(
                              fontSize: 13, color: Color(0xFF9CA3AF))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // LOGROS
  // ─────────────────────────────────────────
  Widget _buildLogros() {
    final logros = [
      _LogroItem(
          icon: Icons.sports_esports,
          color: const Color(0xFF7C3AED),
          bg: const Color(0xFF5B21B6),
          nombre: 'Jugador Activo',
          desc: 'Juega 10 veces'),
      _LogroItem(
          icon: Icons.assignment_turned_in,
          color: const Color(0xFF10B981),
          bg: const Color(0xFF065F46),
          nombre: 'Encuestado',
          desc: 'Completa 10 encuestas'),
      _LogroItem(
          icon: Icons.people,
          color: const Color(0xFFEC4899),
          bg: const Color(0xFF9D174D),
          nombre: 'Conector',
          desc: 'Realiza 10 conexiones'),
      _LogroItem(
          icon: Icons.emoji_events,
          color: const Color(0xFFF59E0B),
          bg: const Color(0xFF92400E),
          nombre: 'Racha de 7 días',
          desc: 'Usa la app 7 días'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Mis logros recientes',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827))),
              GestureDetector(
                onTap: () {},
                child: const Text('Ver todos',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7C3AED),
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: logros
                .map((l) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: logros.indexOf(l) < 3 ? 10 : 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10)
                            ],
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [l.color, l.bg],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Icon(l.icon,
                                        color: Colors.white, size: 26),
                                  ),
                                  Container(
                                    width: 18,
                                    height: 18,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFF10B981),
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.check,
                                        color: Colors.white, size: 11),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(l.nombre,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF111827))),
                              const SizedBox(height: 2),
                              Text(l.desc,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF9CA3AF),
                                      height: 1.3)),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // BOTTOM NAV
  // ─────────────────────────────────────────
  // ─────────────────────────────────────────
  // BOTTOM SHEETS
  // ─────────────────────────────────────────

  // Editar Perfil
  void _showEditProfileSheet(BuildContext context) {
    final nameCtrl = TextEditingController(text: userName);
    final handleCtrl = TextEditingController(text: userHandle);
    final bioCtrl = TextEditingController(text: userBio);
    final locationCtrl = TextEditingController(text: userLocation);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                          color: const Color(0xFFE5E7EB),
                          borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),
              const Text('Editar perfil',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827))),
              const SizedBox(height: 24),
              // Avatar
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFEDE9FE),
                          border: Border.all(
                              color: const Color(0xFF8B5CF6), width: 2)),
                      child: const Icon(Icons.person,
                          size: 40, color: Color(0xFF8B5CF6)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt,
                            size: 13, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _editField(
                  label: 'Nombre completo',
                  controller: nameCtrl,
                  icon: Icons.person_outline),
              const SizedBox(height: 14),
              _editField(
                  label: 'Usuario',
                  controller: handleCtrl,
                  icon: Icons.alternate_email),
              const SizedBox(height: 14),
              _editField(
                  label: 'Ubicación',
                  controller: locationCtrl,
                  icon: Icons.location_on_outlined),
              const SizedBox(height: 14),
              _editField(
                  label: 'Bio',
                  controller: bioCtrl,
                  icon: Icons.info_outline,
                  maxLines: 3),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  setState(() {
                    userName = nameCtrl.text;
                    userHandle = handleCtrl.text;
                    userLocation = locationCtrl.text;
                    userBio = bioCtrl.text;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]),
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: const Center(
                      child: Text('Guardar cambios',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editField(
      {required String label,
      required TextEditingController controller,
      required IconData icon,
      int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4C1D95))),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: const Color(0xFF8B5CF6)),
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }

  // Editar Intereses
  void _showEditInteresesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
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
            const Text('Editar intereses',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827))),
            const SizedBox(height: 8),
            const Text(
                'Próximamente podrás agregar y quitar intereses desde aquí.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Configuración
  void _showSettingsSheet(BuildContext context) {
    final opciones = [
      _SettingItem(
          icon: Icons.lock_outline,
          label: 'Cambiar contraseña',
          color: const Color(0xFF8B5CF6)),
      _SettingItem(
          icon: Icons.notifications_outlined,
          label: 'Notificaciones',
          color: const Color(0xFF3B82F6)),
      _SettingItem(
          icon: Icons.shield_outlined,
          label: 'Privacidad',
          color: const Color(0xFF10B981)),
      _SettingItem(
          icon: Icons.help_outline,
          label: 'Ayuda y soporte',
          color: const Color(0xFFF59E0B)),
      _SettingItem(
          icon: Icons.info_outline,
          label: 'Acerca de Conexia',
          color: const Color(0xFF6B7280)),
      _SettingItem(
          icon: Icons.logout,
          label: 'Cerrar sesión',
          color: const Color(0xFFEF4444)),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
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
            const Text('Configuración',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827))),
            const SizedBox(height: 16),
            ...opciones.map((o) => ListTile(
                  onTap: () => Navigator.pop(context),
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                        color: o.color.withValues(alpha: 0.1),
                        shape: BoxShape.circle),
                    child: Icon(o.icon, color: o.color, size: 20),
                  ),
                  title: Text(o.label,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: o.label == 'Cerrar sesión'
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF111827))),
                  trailing: o.label == 'Cerrar sesión'
                      ? null
                      : const Icon(Icons.chevron_right,
                          size: 18, color: Color(0xFF9CA3AF)),
                  contentPadding: EdgeInsets.zero,
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}}';
    }
    return n.toString();
  }
}

// ─────────────────────────────────────────
// MODELOS LOCALES
// ─────────────────────────────────────────
class _StatItem {
  final IconData icon;
  final Color iconColor, iconBg;
  final String value, label;
  _StatItem(
      {required this.icon,
      required this.iconColor,
      required this.iconBg,
      required this.value,
      required this.label});
}

class _LogroItem {
  final IconData icon;
  final Color color, bg;
  final String nombre, desc;
  _LogroItem(
      {required this.icon,
      required this.color,
      required this.bg,
      required this.nombre,
      required this.desc});
}

class _SettingItem {
  final IconData icon;
  final String label;
  final Color color;
  _SettingItem({required this.icon, required this.label, required this.color});
}
