import 'package:flutter/material.dart';
import 'package:propsa/model&Api/modelreq.dart';
import 'package:propsa/screen/rescreen.dart';
import 'package:propsa/model&Api/response.dart';

class PropertyForm extends StatefulWidget {
  const PropertyForm({super.key});

  @override
  State<PropertyForm> createState() => _PropertyFormState();
}

class _PropertyFormState extends State<PropertyForm> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // City data
  final List<String> cities = ['Karachi', 'Lahore', 'Rawalpindi'];
  String? selectedCity;

  // Areas data
  final Map<String, List<String>> areasByCity = {
    'Lahore': [
      'Air Avenue',
      'Airline Housing Society',
      'Al Ahmad',
      'Al Ahmad Haram Garden',
      'Al Ahmad Rehman Garden Phase 2',
      'Al Ahmad Rehman Garden Phase 4',
      'Al Ahmadlama Iqbal Town',
      'Architects Engineers Housing Society',
      'Askari 10',
      'Askari 10 ',
      'Askari 11 ',
      'Awan Market',
      'Bahria Orchard',
      'Bahria Orchard Phase 1 ',
      'Bahria Orchard Phase 2',
      'Bahria Town',
      'Bahria Town ',
      'Bankers Avenue Cooperative Housing Society',
      'Bismillah Housing Scheme',
      'CBD Punjab (PCBDDA)',
      'Canal Garden',
      'Canal View',
      'Central Park ',
      'Central Park Housing Scheme',
      'DHA 11 Rahbar',
      'DHA 11 Rahbar Phase 2',
      'DHA 11 Rahbar Phase 2 ',
      'DHA 11 Rahbar Phase 2 Extension ',
      'DHA 9 Town',
      'DHA 9 Town ',
      'DHA Phase 1',
      'DHA Phase 1 ',
      'DHA Phase 2 ',
      'DHA Phase 3',
      'DHA Phase 3 ',
      'DHA Phase 4',
      'DHA Phase 4 ',
      'DHA Phase 5',
      'DHA Phase 5 ',
      'DHA Phase 6',
      'DHA Phase 6 ',
      'DHA Phase 7',
      'DHA Phase 7 ',
      'DHA Phase 8',
      'DHA Phase 8 ',
      'Divine Gardens',
      'Dream Gardens',
      'Dream Gardens ',
      'Dream Gardens Phase 1 ',
      'Fateh Garh',
      'Formanites Housing Scheme',
      'Gulberg',
      'Gulberg 3 ',
      'Gulshan',
      'Imperial Garden Homes',
      'Inmol Employees Society ',
      'Izmir Town',
      'Johar Town Phase 2',
      'Jubilee Town',
      'Jubilee Town ',
      'LDA Avenue',
      'LDA Avenue ',
      'Lahore Canal Bank Cooperative Housing Society',
      'Lake City ',
      'Military Accounts Housing Society',
      'Nasheman',
      'OPF Housing Scheme',
      'Oyster Court Luxury Residences',
      'PGECHS Phase 2',
      'Paragon City',
      'Paragon City ',
      'Park View City',
      'Park View City ',
      'Public Health Society ',
      'Punjab Coop Housing ',
      'Punjab Coop Housing Society',
      'Punjab Small Industries Colony ',
      'Sabzazar Scheme',
      'Sarfaraz Rafiqui Road',
      'Shah Jamal',
      'Shah Khawar Town',
      'State Life Housing Society',
      'The Opus Luxury Residence',
      'Township ',
      'UET Housing Society ',
      'Valencia Housing Society',
      'Wapda Town',
      'Wapda Town Phase 1',
      'Zafar Al Ahmadi Road'
    ],
    'Rawalpindi': [
      'Adiala Road',
      'Airport Housing Society',
      'Airport Housing Society ',
      'Aria Mohalla',
      'Askari 13',
      'Askari 14',
      'Bahria Greens ',
      'Bahria Heights',
      'Bahria Intellectual Village',
      'Bahria Paradise',
      'Bahria Safari Valley ',
      'Bahria Square Commercial',
      'Bahria Town ',
      'Bahria Town Phase 2',
      'Bahria Town Phase 3',
      'Bahria Town Phase 4',
      'Bahria Town Phase 5',
      'Bahria Town Phase 6',
      'Bahria Town Phase 7',
      'Bahria Town Phase 8',
      'Bahria Town Phase 8 ',
      'C Junction Commercial',
      'Chakri Road',
      'Defence Road',
      'Dhamyal Road',
      'Gulraiz Housing Scheme',
      'Gulraiz Housing Society Phase 2',
      'Gulraiz Housing Society Phase 3',
      'Gulraiz Housing Society Phase 6',
      'Gulshan',
      'Gulshan Abad',
      'Gulshan Abad Sector 1',
      'Gulshan Abad Sector 2',
      'High Court Road',
      'Janjua Town',
      'Misryal Road',
      'Morgah',
      'Munawar Colony',
      'New Afzal Town',
      'New Westridge',
      'Punjab Government Servant Housing Foundation (PGSHF)',
      'Raheemabad',
      'Range Road',
      'River Hills',
      'River Loft',
      'Samarzar Housing Society',
      'Satellite Town ',
      'Snober City',
      'Wakeel Colony'
    ],
    'Karachi': [
      'Al Ahmad',
      'Askari 4',
      'Askari 5 ',
      'Askari 6',
      'Bahadurabad',
      'Bahria Paradise',
      'Bahria Town ',
      'Bath Island',
      'Bukhari Commercial Area',
      'Capital Cooperative Housing Society',
      'Clifton ',
      'Cotton Export Cooperative Housing Society',
      'DHA Phase 5',
      'DHA Phase 6',
      'DHA Phase 7',
      'DHA Phase 8',
      'Daniyal Residency',
      'Defence View Society',
      'Emaar Panorama',
      'Falaknaz Presidency',
      'Falcon Complex New Malir',
      'Garden East',
      'Gulistan',
      'Gulshan',
      'HMR Waterfront',
      'Ittehad Commercial Area',
      'Kings Classic',
      'Kings Presidency',
      'Malir',
      'Malir Cantonment',
      'Navy Housing Scheme Karsaz',
      'Naya Nazimabad',
      'Naya Nazimabad ',
      'Nazimabad 2 ',
      'North Karachi',
      'North Karachi ',
      'North Nazimabad ',
      'Old Ravians Co',
      'PECHS Block 2',
      'PIB Colony',
      'Saadi Town',
      'Saima Villas',
      'Scheme 33',
      'Sector 25',
      'Shamsi Society'
    ],
  };
  String? selectedArea;

  // Property type data
  final List<String> propertyTypes = ['Flats', 'Houses'];
  String? selectedPropertyType;

  // Area in square feet
  final TextEditingController areaController = TextEditingController();

  // Age/possession status
  final List<String> ageOptions = [
    'Moderately Old',
    'New Property',
    'Old Property',
    'Relatively New',
    'Undefined',
    'Under Construction'
  ];
  String? selectedAgeOption;

  // Price field
  final TextEditingController priceController = TextEditingController();

  // Form progress
  double _formProgress = 0.0;

  @override
  void initState() {
    super.initState();
    // Update form progress when any field changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateFormProgress();
    });
  }

  void _updateFormProgress() {
    int completedFields = 0;
    if (selectedCity != null) completedFields++;
    if (selectedArea != null) completedFields++;
    if (selectedPropertyType != null) completedFields++;
    if (areaController.text.isNotEmpty) completedFields++;
    if (selectedAgeOption != null) completedFields++;
    if (priceController.text.isNotEmpty) completedFields++;

    setState(() {
      _formProgress = completedFields / 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
              'Smart Property Recommendation',
              style: TextStyle(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            onChanged: _updateFormProgress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress indicator
                LinearProgressIndicator(
                  value: _formProgress,
                  backgroundColor: Colors.grey.shade200,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.blue.shade800),
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Complete your property details',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),

                // Scrollable form content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Form cards
                        _buildLocationCard(),
                        const SizedBox(height: 16),
                        _buildPropertyDetailsCard(),
                        const SizedBox(height: 16),
                        _buildFinancialDetailsCard(),
                      ],
                    ),
                  ),
                ),

                // Submit button
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shadowColor: Colors.blue.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.insights,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Get Market Insights',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.grey.withOpacity(0.3),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.blue.shade50],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue.shade800, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // City dropdown
            _buildCityDropdown(),
            const SizedBox(height: 16),

            // Area dropdown
            _buildAreaDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyDetailsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.grey.withOpacity(0.3),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.blue.shade50],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.home_work, color: Colors.blue.shade800, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Property Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Property type dropdown
            _buildPropertyTypeDropdown(),
            const SizedBox(height: 16),

            // Area in square feet
            _buildAreaField(),
            const SizedBox(height: 16),

            // Age/possession status
            _buildAgeDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialDetailsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.grey.withOpacity(0.3),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.blue.shade50],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.attach_money, color: Colors.blue.shade800, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Financial Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Price field
            _buildPriceField(),
          ],
        ),
      ),
    );
  }

  Widget _buildCityDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Select City',
          labelStyle: TextStyle(color: Colors.grey.shade700),
          prefixIcon: Icon(Icons.location_city, color: Colors.blue.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        value: selectedCity,
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade600),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        items: cities.map((String city) {
          return DropdownMenuItem<String>(
            value: city,
            child: Text(city),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedCity = newValue;
            selectedArea = null; // Reset area when city changes
            _updateFormProgress();
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a city';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildAreaDropdown() {
    final List<String> areas =
        selectedCity != null ? areasByCity[selectedCity]! : [];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Select Area',
          labelStyle: TextStyle(color: Colors.grey.shade700),
          prefixIcon: Icon(Icons.place, color: Colors.blue.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          filled: true,
          fillColor: selectedCity == null ? Colors.grey.shade100 : Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        value: selectedArea,
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade600),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        items: areas.map((String area) {
          return DropdownMenuItem<String>(
            value: area,
            child: Text(area),
          );
        }).toList(),
        onChanged: selectedCity == null
            ? null
            : (String? newValue) {
                setState(() {
                  selectedArea = newValue;
                  _updateFormProgress();
                });
              },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an area';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPropertyTypeDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Property Type',
          labelStyle: TextStyle(color: Colors.grey.shade700),
          prefixIcon: Icon(Icons.home, color: Colors.blue.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        value: selectedPropertyType,
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade600),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        items: propertyTypes.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(type),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedPropertyType = newValue;
            _updateFormProgress();
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a property type';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildAreaField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: areaController,
        decoration: InputDecoration(
          labelText: 'Area (in square feet)',
          labelStyle: TextStyle(color: Colors.grey.shade700),
          hintText: 'Enter property area',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.square_foot, color: Colors.blue.shade600),
          suffixIcon: Tooltip(
            message: 'Total covered area of the property',
            child: Icon(Icons.info_outline, color: Colors.grey.shade400),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 16),
        onChanged: (value) {
          _updateFormProgress();
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the area';
          }
          if (int.tryParse(value) == null || int.parse(value) <= 0) {
            return 'Please enter a valid area';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildAgeDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Age/Possession Status',
          labelStyle: TextStyle(color: Colors.grey.shade700),
          prefixIcon: Icon(Icons.access_time, color: Colors.blue.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        value: selectedAgeOption,
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade600),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        items: ageOptions.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedAgeOption = newValue;
            _updateFormProgress();
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an age/possession status';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPriceField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: priceController,
        decoration: InputDecoration(
          labelText: 'Price (in millions)',
          labelStyle: TextStyle(color: Colors.grey.shade700),
          hintText: 'Enter property price',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.payments, color: Colors.blue.shade600),
          suffixText: 'million',
          suffixStyle: TextStyle(color: Colors.grey.shade700),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade300),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(fontSize: 16),
        onChanged: (value) {
          _updateFormProgress();
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the price';
          }
          if (double.tryParse(value) == null || double.parse(value) <= 0) {
            return 'Please enter a valid price';
          }
          return null;
        },
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data
      final formData = {
        'City': selectedCity,
        'colony': selectedArea,
        'property_type': selectedPropertyType,
        'area': int.parse(areaController.text),
        'age_possession': selectedAgeOption,
        'price': double.parse(priceController.text),
      };

      // Show success message with an animated snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              const Text(
                'Analysis in progress...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 3),
        ),
      );

      final data=await modelapi().recommanddata(formData);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PropertyRecommendationScreen(properties:data)));
    }
  }

  @override
  void dispose() {
    areaController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
