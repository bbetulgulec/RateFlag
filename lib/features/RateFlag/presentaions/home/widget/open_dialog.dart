import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OpenDialog extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onRedFlag;
  final VoidCallback onGreenFlag;
  final String openedImageUrl;

  const OpenDialog({
    super.key,
    required this.onClose,
    required this.onRedFlag,
    required this.onGreenFlag,
    required this.openedImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // Arka plan tıklayınca kapanır
          GestureDetector(
            onTap: onClose,
            child: Container(color: Colors.black.withOpacity(0.9)),
          ),

          // Swipe kartı
          Center(
            child: SwipeableCard(
              imageUrl: openedImageUrl,
              onSwipeCompleted: (isGreen) {
                if (isGreen) {
                  onGreenFlag();
                } else {
                  onRedFlag();
                }
                onClose(); // Rate sonrası dialog kapanır → bir sonraki post açılabilir
              },
            ),
          ),

          // Alttaki manuel butonlar
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton(Icons.close, Colors.red, () {
                  onRedFlag();
                  onClose();
                }),
                _actionButton(Icons.star, Colors.blue, () {}),
                _actionButton(Icons.favorite, Colors.green, () {
                  onGreenFlag();
                  onClose();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
        ),
        child: Icon(icon, size: 32, color: color),
      ),
    );
  }
}

class SwipeableCard extends StatefulWidget {
  final String imageUrl;
  final Function(bool isGreen) onSwipeCompleted; // true = green, false = red

  const SwipeableCard({
    super.key,
    required this.imageUrl,
    required this.onSwipeCompleted,
  });

  @override
  State<SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard>
    with TickerProviderStateMixin {
  late AnimationController _moveController;
  Animation<Offset>? _moveAnimation;

  Offset _dragOffset = Offset.zero;
  double _dragAngle = 0.0;
  bool _hasSwiped = false; // Tek sefer rate için

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _moveAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _moveController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_hasSwiped) return;

    setState(() {
      _dragOffset += details.delta;
      _dragAngle = (_dragOffset.dx / 20) * 0.08;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_hasSwiped) return;

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool fastSwipe = details.primaryVelocity!.abs() > 300;
    final bool enoughDistance = _dragOffset.dx.abs() > 50;

    if (fastSwipe || enoughDistance) {
      _hasSwiped = true; // Tek sefer

      final bool isGreen = _dragOffset.dx > 0 || details.primaryVelocity! > 0;

      _moveAnimation =
          Tween<Offset>(
            begin: _dragOffset,
            end: Offset(
              isGreen ? screenWidth + 300 : -(screenWidth + 300),
              _dragOffset.dy + 100,
            ),
          ).animate(
            CurvedAnimation(parent: _moveController, curve: Curves.easeOut),
          );

      _moveController.forward().then((_) {
        // Animasyon bitti, rate et ve kapat
        widget.onSwipeCompleted(isGreen);
      });
    } else {
      // Geri dön
      _moveAnimation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
          .animate(
            CurvedAnimation(parent: _moveController, curve: Curves.elasticOut),
          );

      _moveController.forward().then((_) {
        setState(() {
          _dragOffset = Offset.zero;
          _dragAngle = 0.0;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasSwiped && _moveController.isCompleted) {
      return const SizedBox.shrink(); // Kart tamamen gitti
    }

    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: AnimatedBuilder(
        animation: _moveController,
        builder: (context, child) {
          final Offset currentOffset = _moveAnimation?.value ?? _dragOffset;
          final double progress = (_dragOffset.dx / 100).clamp(-1.0, 1.0);

          // Swipe tamamlandıysa opacity düşür
          final double opacity = _hasSwiped ? (1 - _moveController.value) : 1.0;

          return Opacity(
            opacity: opacity,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(currentOffset.dx, currentOffset.dy)
                ..rotateZ(_dragAngle),
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.cover,
                      ),

                      // RED FLAG overlay
                      Opacity(
                        opacity: progress < 0 ? (-progress) : 0.0,
                        child: Container(
                          color: Colors.red.withOpacity(0.85),
                          alignment: Alignment.center,
                          child: const Text(
                            "RED FLAG",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // GREEN FLAG overlay
                      Opacity(
                        opacity: progress > 0 ? progress : 0.0,
                        child: Container(
                          color: Colors.green.withOpacity(0.85),
                          alignment: Alignment.center,
                          child: const Text(
                            "GREEN FLAG",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Profil info
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Alfredo Calzoni, 20",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(blurRadius: 10, color: Colors.black),
                                ],
                              ),
                            ),
                            Text(
                              "Hamburg, Germany",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                shadows: [
                                  Shadow(blurRadius: 10, color: Colors.black),
                                ],
                              ),
                            ),
                            Text(
                              "16.8 km away",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                                shadows: [
                                  Shadow(blurRadius: 10, color: Colors.black),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
