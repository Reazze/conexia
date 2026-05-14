import 'package:flutter/material.dart';
import 'profile/profile_screen.dart';
import 'actions/actions_screen.dart';
import 'conexion/conexion_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Data simulada — reemplazar con datos reales de Firestore
  final String userName = 'Jose';
  final int totalCoins = 250;
  final int rachaActual = 7;
  final int nivelActual = 4;
  final double perfilCompletado = 0.85;
  final int retosCompletados = 1;
  final int retosTotal = 3;

  @override
  Widget build(BuildContext context) {
    // Pantallas de cada tab
    final List<Widget> screens = [
      _buildHomeContent(), // index 0 — Inicio
      _buildPlaceholder('Acciones', Icons.flash_on), // index 1
      _buildPlaceholder('Conexiones', Icons.people), // index 3
      const ProfileScreen(), // index 4 — Perfil
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        _buildAppBar(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildHeroHeader(),
                const SizedBox(height: 16),
                _buildCoinsBanner(),
                const SizedBox(height: 24),
                _buildAccionesRapidas(),
                const SizedBox(height: 20),
                _buildRetoDiaBanner(),
                const SizedBox(height: 24),
                _buildTuProgreso(),
                const SizedBox(height: 24),
                _buildActividadReciente(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(String nombre, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: const Color(0xFFDDD6FE)),
          const SizedBox(height: 16),
          Text(
            nombre,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7C3AED),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Próximamente...',
            style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // APP BAR
  // ─────────────────────────────────────────
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: const Color(0xFFF4F3FF),
      child: Row(
        children: [
          Image.asset(
            'assets/images/LogotipoSinfondo.png',
            height: 45,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          // Campana con notificación
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 8)
                  ],
                ),
                child: const Icon(Icons.notifications_outlined,
                    size: 22, color: Color(0xFF4B5563)),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: Color(0xFFEC4899), shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          // Coins pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
                  ),
                  child: const Icon(Icons.star, size: 13, color: Colors.white),
                ),
                const SizedBox(width: 6),
                Text(
                  _formatNumber(totalCoins),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937)),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.add, size: 16, color: Color(0xFF8B5CF6)),
              ],
            ),
          ),
          const SizedBox(width: 6),
          // Menu hamburgueza
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.menu, size: 26, color: Color(0xFF1F2937)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // HERO HEADER
  // ─────────────────────────────────────────
  Widget _buildHeroHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola, $userName!',
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                    children: [
                      TextSpan(text: 'Conecta. Participa. '),
                      TextSpan(
                          text: 'Gana.',
                          style: TextStyle(
                              color: Color(0xFF7C3AED),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sigue explorando y gana\nrecompensas increíbles. 💜',
                  style: TextStyle(
                      fontSize: 13, color: Color(0xFF9CA3AF), height: 1.5),
                ),
              ],
            ),
          ),
          // Avatar con botón editar
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE0D9FF),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                        blurRadius: 16)
                  ],
                  // TODO: Reemplazar con imagen del usuario
                  // image: DecorationImage(image: NetworkImage(userPhotoUrl), fit: BoxFit.cover),
                ),
                child: const Icon(Icons.person,
                    size: 46, color: Color(0xFF8B5CF6)),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFFEDE9FE), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 6)
                    ],
                  ),
                  child: const Icon(Icons.edit_outlined,
                      size: 14, color: Color(0xFF8B5CF6)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // COINS + RACHA BANNER
  // ─────────────────────────────────────────
  Widget _buildCoinsBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Coins
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
                      ),
                      child:
                          const Icon(Icons.star, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total coins',
                            style:
                                TextStyle(fontSize: 11, color: Colors.white70)),
                        Text(
                          _formatNumber(totalCoins),
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.chevron_right,
                        color: Colors.white54, size: 18),
                  ],
                ),
              ),
            ),
            // Divisor
            Container(width: 1, height: 44, color: Colors.white24),
            const SizedBox(width: 16),
            // Racha
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.emoji_events_outlined,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Racha actual',
                            style:
                                TextStyle(fontSize: 11, color: Colors.white70)),
                        Text(
                          '$rachaActual días',
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.chevron_right,
                        color: Colors.white54, size: 18),
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
  // ACCIONES RÁPIDAS
  // ─────────────────────────────────────────
  Widget _buildAccionesRapidas() {
    final acciones = [
      _AccionItem(
          icon: Icons.assignment_outlined,
          label: 'Encuestas',
          sub: 'Gana coins',
          color: const Color(0xFF8B5CF6),
          bg: const Color(0xFFF3EEFF)),
      _AccionItem(
          icon: Icons.sports_esports_outlined,
          label: 'Juegos',
          sub: 'Diviértete y gana',
          color: const Color(0xFF10B981),
          bg: const Color(0xFFECFDF5)),
      _AccionItem(
          icon: Icons.people_outline,
          label: 'Conexiones',
          sub: 'Conoce personas',
          color: const Color(0xFFEC4899),
          bg: const Color(0xFFFDF2F8)),
      _AccionItem(
          icon: Icons.gps_fixed,
          label: 'Desafíos',
          sub: 'Acepta retos',
          color: const Color(0xFF3B82F6),
          bg: const Color(0xFFEFF6FF)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Acciones rápidas',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827))),
              GestureDetector(
                onTap: () {},
                child: const Text('Ver todas',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7C3AED),
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: acciones
                .map((a) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: acciones.indexOf(a) < 3 ? 10 : 0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xFF8B5CF6)
                                        .withValues(alpha: 0.8),
                                    blurRadius: 10)
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      color: a.bg, shape: BoxShape.circle),
                                  child: Icon(a.icon, color: a.color, size: 22),
                                ),
                                const SizedBox(height: 8),
                                Text(a.label,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF111827))),
                                const SizedBox(height: 2),
                                Text(a.sub,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF9CA3AF))),
                              ],
                            ),
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
  // RETO DEL DÍA
  // ─────────────────────────────────────────
  Widget _buildRetoDiaBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E1B4B), Color(0xFF3B0764)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RETO DEL DÍA',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEC4899),
                        letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.3),
                      children: [
                        TextSpan(text: 'Responde 3 encuestas\ny gana '),
                        TextSpan(
                            text: '150 coins',
                            style: TextStyle(color: Color(0xFFFBBF24))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Progreso
                  Row(
                    children: [
                      Text(
                        '$retosCompletados/$retosTotal completadas',
                        style: const TextStyle(
                            fontSize: 11, color: Colors.white60),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: retosCompletados / retosTotal,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF8B5CF6)),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7C3AED),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '¡Vamos!',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Ilustración cofre
            Container(
              width: 90,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🏴‍☠️', style: TextStyle(fontSize: 44)),
                  // TODO: Reemplazar con Image.asset('assets/images/chest.png')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // TU PROGRESO
  // ─────────────────────────────────────────
  Widget _buildTuProgreso() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tu progreso',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827))),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04), blurRadius: 12)
              ],
            ),
            child: Row(
              children: [
                // Racha
                Expanded(
                  child: _buildProgresoItem(
                    icon: '🔥',
                    iconBg: const Color(0xFFFEF3C7),
                    value: '$rachaActual',
                    label: 'Días de racha',
                    sub: '¡Sigue así!',
                  ),
                ),
                _buildVerticalDivider(),
                // Nivel
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)]),
                        ),
                        child: const Icon(Icons.star,
                            color: Colors.white, size: 22),
                      ),
                      const SizedBox(height: 8),
                      Text('Nivel $nivelActual',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827))),
                      const SizedBox(height: 2),
                      const Text('Avanza al nivel 5',
                          style: TextStyle(
                              fontSize: 11, color: Color(0xFF9CA3AF))),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const LinearProgressIndicator(
                          value: 0.6,
                          backgroundColor: Color(0xFFE5E7EB),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildVerticalDivider(),
                // Perfil
                Expanded(
                  child: _buildProgresoItem(
                    icon: '🛡️',
                    iconBg: const Color(0xFFD1FAE5),
                    value: '${(perfilCompletado * 100).toInt()}%',
                    label: 'Perfil completado',
                    sub: '¡Casi listo!',
                    valueColor: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgresoItem({
    required String icon,
    required Color iconBg,
    required String value,
    required String label,
    required String sub,
    Color valueColor = const Color(0xFF111827),
  }) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child:
              Center(child: Text(icon, style: const TextStyle(fontSize: 22))),
        ),
        const SizedBox(height: 8),
        Text(value,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: valueColor)),
        const SizedBox(height: 2),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
        Text(sub,
            style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
        width: 1,
        height: 70,
        color: const Color(0xFFF3F4F6),
        margin: const EdgeInsets.symmetric(horizontal: 4));
  }

  // ─────────────────────────────────────────
  // ACTIVIDAD RECIENTE
  // ─────────────────────────────────────────
  Widget _buildActividadReciente() {
    final actividades = [
      _ActividadItem(
          icon: Icons.assignment_turned_in_outlined,
          iconColor: const Color(0xFF10B981),
          iconBg: const Color(0xFFD1FAE5),
          title: 'Encuesta completada',
          coins: 50,
          tiempo: 'Hace 1 hora'),
      _ActividadItem(
          icon: Icons.sports_esports_outlined,
          iconColor: const Color(0xFF3B82F6),
          iconBg: const Color(0xFFDBEAFE),
          title: 'Juego completado',
          coins: 30,
          tiempo: 'Hace 3 horas'),
      _ActividadItem(
          icon: Icons.people_outline,
          iconColor: const Color(0xFFEC4899),
          iconBg: const Color(0xFFFCE7F3),
          title: 'Nueva conexión',
          coins: 20,
          tiempo: 'Hace 5 horas'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Actividad reciente',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827))),
              GestureDetector(
                onTap: () {},
                child: const Text('Ver todas',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7C3AED),
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04), blurRadius: 12)
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: actividades.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, indent: 20, endIndent: 20),
              itemBuilder: (_, i) {
                final a = actividades[i];
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration:
                        BoxDecoration(color: a.iconBg, shape: BoxShape.circle),
                    child: Icon(a.icon, color: a.iconColor, size: 22),
                  ),
                  title: Row(
                    children: [
                      Text(a.title,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827))),
                      const SizedBox(width: 6),
                      Text('+${a.coins} coins',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF10B981),
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  subtitle: Text(a.tiempo,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9CA3AF))),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('+${a.coins}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF111827))),
                      const SizedBox(width: 4),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
                        ),
                        child: const Icon(Icons.star,
                            size: 12, color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // BOTTOM NAVIGATION
  // ─────────────────────────────────────────
  Widget _buildBottomNav() {
    const tabs = [
      _TabItem(
          index: 0,
          activeIcon: Icons.home_rounded,
          inactiveIcon: Icons.home_outlined,
          label: 'Inicio'),
      _TabItem(
          index: 1,
          activeIcon: Icons.flash_on,
          inactiveIcon: Icons.flash_on_outlined,
          label: 'Acciones'),
      _TabItem(
          index: 2,
          activeIcon: Icons.people,
          inactiveIcon: Icons.people_outline,
          label: 'Conexiones'),
      _TabItem(
          index: 3,
          activeIcon: Icons.person,
          inactiveIcon: Icons.person_outline,
          label: 'Perfil'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(tabs[0]),
              _buildNavItem(tabs[1]),
              const SizedBox(width: 48), // espacio para el FAB
              _buildNavItem(tabs[2]),
              _buildNavItem(tabs[3]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(_TabItem tab) {
    final isActive = _currentIndex == tab.index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = tab.index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? tab.activeIcon : tab.inactiveIcon,
            size: 24,
            color: isActive ? const Color(0xFF7C3AED) : const Color(0xFF9CA3AF),
          ),
          const SizedBox(height: 2),
          Text(
            tab.label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color:
                  isActive ? const Color(0xFF7C3AED) : const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0x558B5CF6), blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  // ─────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────
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
class _AccionItem {
  final IconData icon;
  final String label;
  final String sub;
  final Color color;
  final Color bg;
  _AccionItem(
      {required this.icon,
      required this.label,
      required this.sub,
      required this.color,
      required this.bg});
}

class _ActividadItem {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final int coins;
  final String tiempo;
  _ActividadItem(
      {required this.icon,
      required this.iconColor,
      required this.iconBg,
      required this.title,
      required this.coins,
      required this.tiempo});
}

class _TabItem {
  final int index;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;

  const _TabItem({
    required this.index,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}
