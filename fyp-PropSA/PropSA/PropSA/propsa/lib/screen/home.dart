import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:propsa/model&Api/blog.dart';
import 'package:propsa/screen/chatbot.dart';
import 'package:propsa/screen/prediction.dart';
import 'package:propsa/screen/recommand.dart';
import 'slider.dart';
import 'package:url_launcher/url_launcher.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<home> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  final Uri _targetUrl = Uri.parse('http://localhost:8501');// streamlit app

  Future<void> _launchTarget() async {
    if (await canLaunchUrl(_targetUrl)) {
      await launchUrl(_targetUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $_targetUrl';
    }
  }

  @override
  void initState() {
    super.initState();
    // Pulse animation for cards
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Slide animation for content
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully signed out')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out: $e')),
        );
      }
    }
  }

  Widget _buildFooter(bool isNarrow) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue.shade900),
        padding:
            EdgeInsets.symmetric(horizontal: isNarrow ? 16 : 24, vertical: 40),
        child: Column(
          children: [
            isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFooterCompanyInfo(),
                      const SizedBox(height: 30),
                      _buildFooterContactInfo(context),
                      const SizedBox(height: 30),
                      _buildFooterSocialMedia(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildFooterCompanyInfo()),
                      Expanded(child: _buildFooterContactInfo(context)),
                      Expanded(child: _buildFooterSocialMedia()),
                    ],
                  ),
            const SizedBox(height: 40),
            const Divider(color: Colors.white24),
            const SizedBox(height: 20),
            const Text(
              '© 2025 Prop S&A. All rights reserved.',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.business, color: Colors.white, size: 28),
            const SizedBox(width: 8),
            const Text(
              'Prop S&A',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFooterContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.email, color: Colors.white70, size: 20),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Clipboard.setData(
                    const ClipboardData(text: 'contact@propsa.com'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email copied to clipboard')),
                );
              },
              child: Row(
                children: [
                  const Text(
                    'contact@propsa.com',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.copy, color: Colors.blue.shade300, size: 16),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.phone, color: Colors.white70, size: 20),
            SizedBox(width: 8),
            Text(
              '+1 (555) 123-4567',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterSocialMedia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Follow Us',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.facebook, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.telegram, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.public, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.chat, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          // Navbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo animation
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(20 * (1 - value), 0),
                        child: Row(
                          children: [
                            Icon(Icons.business,
                                color: Colors.blue.shade800, size: 28),
                            const SizedBox(width: 12),
                            Text(
                              'PropS&A',
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Profile and sign out
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade900,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: _signOut,
                      icon: Icon(Icons.logout, color: Colors.blue.shade800),
                      label: Text('Sign Out',
                          style: TextStyle(color: Colors.blue.shade800)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        backgroundColor: colorScheme.surface,
                        elevation: 0,
                        side: BorderSide(color: Colors.blue.shade800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _slideController,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero text
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFF8F8F8),
                              Color(0xFFE6E6E6),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CarouselPage(),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Ready to Unlock Insights With Our Property Prediction',
                                  style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    height: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    'Explore smart, data-driven real estate forecasts , market trend, graphs for visual',
                                    style: TextStyle(
                                      color: const Color(0xFF555555),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade800,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Start ur analyze now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),

                      // Feature cards grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount:
                            size.width > 1200 ? 3 : (size.width > 800 ? 2 : 1),
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        children: [
                          // AI Property Price Prediction
                          FeatureCard(
                            icon: Icons.trending_up,
                            title: 'AI Property Price Prediction',
                            description:
                                'Get accurate property price forecasts using advanced AI algorithms',
                            color: Colors.blue.shade800,
                            pulseAnimation: _pulseAnimation,
                            onTap: () {
                              // Function to execute when tapped
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PropertyFormPage()));
                            },
                          ),

                          // Property Recommendation System
                          FeatureCard(
                            icon: Icons.recommend,
                            title: 'Smart Recommendations',
                            description:
                                'Discover properties that match your preferences and investment goals',
                            color: Colors.green,
                            pulseAnimation: _pulseAnimation,
                            onTap: () {
                              // Function to execute when tapped
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PropertyForm()));
                            },
                          ),

                          // Analytics & Graphs
                          FeatureCard(
                              icon: Icons.bar_chart,
                              title: 'Analytics & Insights',
                              description:
                                  'Visualize market trends and property performance with interactive graphs',
                              color: Colors.orange,
                              pulseAnimation: _pulseAnimation,
                              onTap: _launchTarget
                              // Function to execute when tapped

                              // Your Streamlit app

                              ),

                          // AI Chat Support
                          FeatureCard(
                            icon: Icons.chat,
                            title: 'AI Property Assistant',
                            description:
                                'Get instant answers to your property questions from our AI assistant',
                            color: Colors.pink,
                            pulseAnimation: _pulseAnimation,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Chatbot()));
                            },
                          ),

                          // Market Reports
                          FeatureCard(
                            icon: Icons.description,
                            title: 'Market Blogs',
                            description:
                                'Comprehensive Blogs on real estate market conditions and forecasts',
                            color: const Color(0xFF7B1FA2),
                            pulseAnimation: _pulseAnimation,
                            onTap: () {
                              // Function to execute when tapped
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const BlogScreen()));
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      _buildFooter(false)
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
}

class FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final Animation<double> pulseAnimation;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.pulseAnimation,
    required this.onTap,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconScaleAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
    _iconScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
          _hoverController.forward();
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _hoverController.reverse();
        });
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: widget.pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _isHovered ? 1.0 : widget.pulseAnimation.value,
              child: child,
            );
          },
          child: Card(
            elevation: _isHovered ? 8 : 4,
            shadowColor: widget.color.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: _isHovered ? widget.color : Colors.transparent,
                width: 2,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _isHovered
                        ? widget.color.withOpacity(0.1)
                        : const Color.fromARGB(255, 230, 230, 230),
                    _isHovered
                        ? widget.color.withOpacity(0.15)
                        : const Color.fromARGB(205, 180, 180, 180),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated icon
                  ScaleTransition(
                    scale: _iconScaleAnimation,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          widget.icon,
                          size: 40,
                          color: widget.color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title with color
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              _isHovered ? widget.color : colorScheme.onSurface,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Animated button
                  GestureDetector(
                    onTap: widget.onTap,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: _isHovered ? widget.color : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: widget.color,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'Explore',
                          style: TextStyle(
                            color: _isHovered ? Colors.white : widget.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
