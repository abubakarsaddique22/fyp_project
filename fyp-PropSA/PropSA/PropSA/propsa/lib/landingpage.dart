import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propsa/authentications/login/signup.dart';

//---------------------------------------
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  final List<Feature> _features = [
    Feature(
      title: "Advanced Property Analysis",
      description:
          "Comprehensive analysis of property markets with AI-powered insights",
      icon: Icons.analytics,
      color: Colors.blue,
      details:
          "Our advanced machine learning algorithms analyze thousands of property listings, market trends, and economic indicators to provide you with actionable insights.",
    ),
    Feature(
      title: "Smart Recommendations",
      description:
          "Personalized property recommendations based on your preferences and market trends",
      icon: Icons.recommend,
      color: Colors.green,
      details:
          "Let our AI do the work for you. Based on your investment goals, budget, and risk tolerance, our recommendation engine will identify the most promising properties.",
    ),
    Feature(
      title: "Interactive Data Visualization",
      description:
          "Intuitive graphs and charts to help you make informed decisions quickly",
      icon: Icons.bar_chart,
      color: Colors.orange,
      details:
          "See the bigger picture with our interactive dashboards and visualization tools. Track property values, market trends, ROI projections, and more with beautiful charts.",
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        // Adapt to screen width
        bool isNarrow = constraints.maxWidth < 800;

        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // App Bar
              _buildAppBar(isNarrow),

              // Hero Section
              _buildHeroSection(isNarrow),

              // Feature Showcase
              _buildFeatureShowcase(isNarrow),

              // Privacy Policy Section
              _buildPrivacySection(isNarrow),

              // Footer
              _buildFooter(isNarrow),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAppBar(bool isNarrow) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: isNarrow
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.business,
                                color: Colors.blue.shade800, size: 28),
                            const SizedBox(width: 8),
                            Text(
                              'Prop S&A',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Advanced property analysis and recommendation tools to optimize your real estate investments.',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.business,
                            color: Colors.blue.shade800, size: 28),
                        Text(
                          'Prop S&A',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Advanced property analysis and recommendation tools to optimize your real estate investments.',
                      style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildHeroSection(bool isNarrow) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(vertical: 80, horizontal: isNarrow ? 16 : 24),
      constraints: const BoxConstraints(minHeight: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade900, Colors.blue.shade700],
        ),
      ),
      child: Center(
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: CustomPaint(
                painter: GridPainter(),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Text
                  const AnimatedTextWidget(),

                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Create Account Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignInScreen(false)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade800,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: const Text('Create Account'),
                      ),
                      const SizedBox(width: 20),
                      // Sign In Button
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignInScreen(false)));
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                        ),
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureShowcase(bool isNarrow) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Text(
                  'What We Offer',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Powerful tools to analyze and optimize your property investments',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),

          // Feature Cards (responsive)
          for (int i = 0; i < _features.length; i++)
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 40, horizontal: isNarrow ? 16 : 40),
              color: i % 2 == 0 ? Colors.white : Colors.grey.shade50,
              child: FeatureCard(
                feature: _features[i],
                isNarrow: isNarrow,
                index: i,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection(bool isNarrow) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: isNarrow ? 16 : 24, vertical: 60),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Privacy & Security',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          isNarrow
              ? Column(
                  children: [
                    _buildPrivacyItem(
                      icon: Icons.security,
                      title: 'Data Protection',
                      description:
                          'Your property data is save and securely stored. We implement industry-leading  measures.',
                    ),
                    const SizedBox(height: 30),
                    _buildPrivacyItem(
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      description:
                          'We respect your privacy and will never sell your data to third parties. Review our comprehensive privacy policy.',
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildPrivacyItem(
                        icon: Icons.security,
                        title: 'Data Protection',
                        description:
                            'Your property data is save and securely stored. We implement industry-leading  measures.',
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _buildPrivacyItem(
                        icon: Icons.privacy_tip,
                        title: 'Privacy Policy',
                        description:
                            'We respect your privacy and will never sell your data to third parties. Review our comprehensive privacy policy.',
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPrivacyItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue.shade800, size: 28),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildFooter(bool isNarrow) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: isNarrow ? 16 : 24, vertical: 40),
      color: Colors.blue.shade900,
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
}

class AnimatedTextWidget extends StatefulWidget {
  const AnimatedTextWidget({super.key});

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  int _currentTextIndex = 0;
  final List<String> _headlines = [
    'Smart Property Analysis',
    'Data-Driven Recommendations',
    'Visualize Market Trends',
  ];
  final List<String> _subheadlines = [
    'Make informed decisions with advanced property insights',
    'Discover optimal investment opportunities tailored for you',
    'See the future of real estate markets with predictive analytics',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: false);

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        setState(() {
          _currentTextIndex = (_currentTextIndex + 1) % _headlines.length;
        });
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeInAnimation.value,
          child: Column(
            children: [
              Text(
                _headlines[_currentTextIndex],
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _subheadlines[_currentTextIndex],
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Feature {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String details;

  Feature({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.details,
  });
}

class FeatureCard extends StatelessWidget {
  final Feature feature;
  final bool isNarrow;
  final int index;

  const FeatureCard({
    super.key,
    required this.feature,
    required this.isNarrow,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return isNarrow
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Feature Icon and Number
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: feature.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      feature.icon,
                      size: 32,
                      color: feature.color,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "0${index + 1}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: feature.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Title and Description
              Text(
                feature.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                feature.description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                feature.details,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 30),

              // Feature Visualization
              _buildVisualization(feature, index),
              const SizedBox(height: 24),

              // Learn More Button
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side - Text content
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: feature.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            feature.icon,
                            size: 32,
                            color: feature.color,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "0${index + 1}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: feature.color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      feature.title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      feature.description,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      feature.details,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // Right side - Visualization
              Expanded(
                flex: 6,
                child: Center(
                  child: _buildVisualization(feature, index),
                ),
              ),
            ],
          );
  }

  Widget _buildVisualization(Feature feature, int index) {
    // Create different visualizations for each feature using icons instead of images
    switch (index) {
      case 0: // Analysis
        return Container(
          width: isNarrow ? double.infinity : 500,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.analytics, size: 60, color: feature.color),
              const SizedBox(height: 20),
              // Mock bar chart
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 40,
                    height: 20 + (i % 3 + 1) * 40.0,
                    decoration: BoxDecoration(
                      color: feature.color.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              // Mock labels
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Jan"),
                  Text("Feb"),
                  Text("Mar"),
                  Text("Apr"),
                  Text("May"),
                  Text("Jun"),
                  Text("Jul"),
                ],
              ),
            ],
          ),
        );

      case 1: // Recommendations
        return Container(
          width: isNarrow ? double.infinity : 500,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.recommend, size: 60, color: feature.color),
              const SizedBox(height: 20),
              // Mock property cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    width: 90,
                    height: 120,
                    decoration: BoxDecoration(
                      color: feature.color.withOpacity(0.1 + i * 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: feature.color.withOpacity(0.3),
                        width: i == 1 ? 3 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: feature.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.home,
                            color: feature.color,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Property ${i + 1}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: feature.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${(i + 1) * 250}k",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        );

      case 2: // Visualization
        return Container(
          width: isNarrow ? double.infinity : 500,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart, size: 60, color: feature.color),
              const SizedBox(height: 20),
              // Mock line chart
              Container(
                padding: const EdgeInsets.all(10),
                width: isNarrow ? double.infinity : 400,
                height: 120,
                child: CustomPaint(
                  painter: ChartPainter(color: feature.color),
                ),
              ),
              const SizedBox(height: 10),
              // Mock legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: feature.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Property Value"),
                  const SizedBox(width: 20),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Market Average"),
                ],
              ),
            ],
          ),
        );

      default:
        return Container(
          width: isNarrow ? double.infinity : 400,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Icon(feature.icon, size: 100, color: feature.color),
          ),
        );
    }
  }
}

// Custom painter for grid pattern in hero section
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const gridSize = 50.0;

    // Draw vertical lines
    for (double i = 0; i <= size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    // Draw horizontal lines
    for (double i = 0; i <= size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for chart in feature visualization
class ChartPainter extends CustomPainter {
  final Color color;

  ChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final mainPaint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final secondaryPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final mainPath = Path();
    final secondaryPath = Path();

    // Generate some random-looking data points
    final mainPoints = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.2, size.height * 0.5),
      Offset(size.width * 0.4, size.height * 0.6),
      Offset(size.width * 0.6, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width, size.height * 0.4),
    ];

    final secondaryPoints = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.7),
      Offset(size.width * 0.4, size.height * 0.6),
      Offset(size.width * 0.6, size.height * 0.5),
      Offset(size.width * 0.8, size.height * 0.6),
      Offset(size.width, size.height * 0.5),
    ];

    // Draw main line
    mainPath.moveTo(mainPoints[0].dx, mainPoints[0].dy);
    for (int i = 1; i < mainPoints.length; i++) {
      mainPath.lineTo(mainPoints[i].dx, mainPoints[i].dy);
    }
    canvas.drawPath(mainPath, mainPaint);

    // Draw secondary line
    secondaryPath.moveTo(secondaryPoints[0].dx, secondaryPoints[0].dy);
    for (int i = 1; i < secondaryPoints.length; i++) {
      secondaryPath.lineTo(secondaryPoints[i].dx, secondaryPoints[i].dy);
    }
    canvas.drawPath(secondaryPath, secondaryPaint);

    // Draw dots at data points for main line
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (var point in mainPoints) {
      canvas.drawCircle(point, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Class to allow custom shape for app bar
class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 2, size.height + 20, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
