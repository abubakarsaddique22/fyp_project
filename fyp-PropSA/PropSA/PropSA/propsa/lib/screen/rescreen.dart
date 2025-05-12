import 'package:flutter/material.dart';
import 'package:propsa/model&Api/response.dart';
class PropertyRecommendationScreen extends StatefulWidget {
  final List<Property> properties;

  const PropertyRecommendationScreen({
    Key? key, 
    required this.properties
  }) : super(key: key);

  @override
  _PropertyRecommendationScreenState createState() => _PropertyRecommendationScreenState();
}

class _PropertyRecommendationScreenState extends State<PropertyRecommendationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  Icon(Icons.business, color: Colors.blue.shade800, size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              'Property Recommendation for U',
              style: TextStyle(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
 
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.properties.length,
          itemBuilder: (context, index) {
            return PropertyRecommendationCard(
              property: widget.properties[index], 
              index: index
            );
          },
        ),
      ),
    );
  }
}

class PropertyRecommendationCard extends StatefulWidget {
  final Property property;
  final int index;

  const PropertyRecommendationCard({
    Key? key, 
    required this.property, 
    required this.index
  }) : super(key: key);

  @override
  _PropertyRecommendationCardState createState() => _PropertyRecommendationCardState();
}

class _PropertyRecommendationCardState extends State<PropertyRecommendationCard> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Create animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Create scale animation with slight delay based on index
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0, 1.0, 
          curve: Curves.elasticOut
        ),
      ),
    );

    // Create fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Stagger the animation based on index
    Future.delayed(Duration(milliseconds: widget.index * 150), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property Details Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.property.propertyType,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    Text(
                      'PKR ${widget.property.price} Million',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // Location Details
                Text(
                  '${widget.property.colony}, ${widget.property.city}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  '${widget.property.province}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 12),

                // Property Specs
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    _buildPropertySpec('Bedrooms', widget.property.bedrooms.toString()),
                    _buildPropertySpec('Bathrooms', widget.property.bathrooms.toString()),
                    _buildPropertySpec('Area', '${widget.property.area} sq.ft'),
                    _buildPropertySpec('Parking', widget.property.parkingSpaces.toString()),
                  ],
                ),
                SizedBox(height: 12),

          
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create property specification widgets
  Widget _buildPropertySpec(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}