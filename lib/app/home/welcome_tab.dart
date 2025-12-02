import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeTab extends ConsumerWidget {
  const WelcomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top section with image
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
              child: Stack(
                children: [
                  // Placeholder for the mountain image - you can replace this with actual image
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 2,
                      ),
                      color: const Color(0xFFF8F8F8),
                    ),
                    child: CustomPaint(painter: MountainPainter()),
                  ),
                ],
              ),
            ),

            // Bottom section with content
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Main title
                    Text(
                      'Welcome to Sacred\nEchoes',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'Explore a vast collection of hymns and\ncanticles to enrich your spiritual journey.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),

                    const Spacer(),

                    // Buttons
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Start Exploring',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 32),
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement log in functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE3F2FD),
                          foregroundColor: const Color(0xFF2196F3),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Log In',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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
}

class MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Sky gradient
    const skyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFE8C4A0), Color(0xFFF5F5F5)],
    );

    paint.shader = skyGradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.6),
    );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.6), paint);

    // Sun
    paint.shader = null;
    paint.color = const Color(0xFFFFFFFF);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.2),
      size.width * 0.04,
      paint,
    );

    // Mountain layers (back to front, light to dark)
    final mountainColors = [
      const Color(0xFFB8D4D4),
      const Color(0xFF9BC4C4),
      const Color(0xFF7EB4B4),
      const Color(0xFF61A4A4),
      const Color(0xFF449494),
      const Color(0xFF278484),
    ];

    for (int i = 0; i < mountainColors.length; i++) {
      paint.color = mountainColors[i];
      final path = Path();
      final baseY = size.height * (0.4 + i * 0.1);

      path.moveTo(0, baseY);

      // Create mountain silhouette
      for (double x = 0; x <= size.width; x += size.width / 20) {
        final peakHeight =
            size.height *
            (0.15 + i * 0.05) *
            (0.5 + 0.5 * (1 + (x / size.width - 0.5) * 2).abs());
        path.lineTo(x, baseY - peakHeight);
      }

      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();

      canvas.drawPath(path, paint);
    }

    // Trees silhouette
    paint.color = const Color(0xFF1A4A4A);
    final treePath = Path();

    // Simple tree shapes in foreground
    final treePositions = [0.1, 0.15, 0.85, 0.9];
    for (final pos in treePositions) {
      final x = size.width * pos;
      final treeHeight = size.height * 0.25;
      final treeWidth = size.width * 0.02;

      // Tree trunk
      treePath.addRect(
        Rect.fromLTWH(
          x - treeWidth / 2,
          size.height - treeHeight,
          treeWidth,
          treeHeight,
        ),
      );

      // Tree top (triangle)
      final topPath = Path();
      topPath.moveTo(x, size.height - treeHeight * 1.5);
      topPath.lineTo(x - treeWidth * 2, size.height - treeHeight * 0.7);
      topPath.lineTo(x + treeWidth * 2, size.height - treeHeight * 0.7);
      topPath.close();
      treePath.addPath(topPath, Offset.zero);
    }

    canvas.drawPath(treePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
