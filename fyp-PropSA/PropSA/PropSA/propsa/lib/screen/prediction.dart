import 'package:flutter/material.dart';
import 'package:propsa/model&Api/modelreq.dart';

class PropertyFormPage extends StatefulWidget {
  const PropertyFormPage({super.key});

  @override
  State<PropertyFormPage> createState() => _PropertyFormPageState();
}

class _PropertyFormPageState extends State<PropertyFormPage> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // City data
  final List<String> cities = ['Karachi', 'Lahore', 'Rawalpindi'];
  final List<String> province = ['Punjab', 'Sindh'];
  String? selectedprovince;
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

  // Property metrics
  final TextEditingController areaController = TextEditingController();
  int parkingSpaces = 0;
  int bedrooms = 0;
  int bathrooms = 0;
  int servantQuarters = 0;
  int kitchens = 1;
  int storeRooms = 0;

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

  // Price prediction
  String? predictedPrice;
  bool isLoading = false;

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
              'Property listing form',
              style: TextStyle(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: Colors.blue.shade800,
                                size: 35,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Add Property Details ',
                                style: TextStyle(
                                    letterSpacing: 1.2,
                                    color: Colors.blue.shade800,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          _buildSectionTitle('Location & property info'),
                          Row(
                            children: [
                              Expanded(child: _buildCityDropdown()),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: _buildprovinceDropdown()),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(child: _buildAreaField()),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _buildAreaDropdown(),
                          SizedBox(
                            height: 10,
                          ),
                          _buildPropertyTypeDropdown(),

                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  child: _buildCounterRow(
                                      'Bedrooms', bedrooms, 8)),
                              Expanded(
                                  child: _buildCounterRow(
                                      'Bathrooms', bathrooms, 8)),
                              Expanded(
                                  child: _buildCounterRow(
                                      'Parking Spaces', parkingSpaces, 6))
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: _buildCounterRow(
                                      'Servant Quarters', servantQuarters, 6)),
                              Expanded(
                                  child: _buildCounterRow(
                                      'Kitchens', kitchens, 3)),
                              Expanded(
                                  child: _buildCounterRow(
                                      'Store Rooms', storeRooms, 4)),
                            ],
                          ),

                          // Age/possession status
                          _buildAgeDropdown(),
                          const SizedBox(height: 25),

                          // Submit button
                          ElevatedButton.icon(
                            onPressed: _predictPrice,
                            icon: const Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                            ),
                            label: const Text('Get AI Price Prediction'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.blue.shade800,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (isLoading)
                      Expanded(
                          child:
                              const Center(child: CircularProgressIndicator()))
                    else if (predictedPrice != null)
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPricePrediction(),
                          Card(
                            color: Colors.indigo.shade50,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.trending_down,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      Text(
                                        'is prediction seems wrong??',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'prediction is based upon data we used , if any thing u donot agree , contact us for improvement and share valuable insight in order to deliver u better prediction in future',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 46, 46, 46)),
      ),
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'City',
        prefixIcon: Icon(
          Icons.location_city,
          color: Colors.blue.shade800,
        ),
      ),
      value: selectedCity,
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
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a city';
        }
        return null;
      },
    );
  }

  Widget _buildprovinceDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Province',
        prefixIcon: Icon(
          Icons.location_city,
          color: Colors.blue.shade800,
        ),
      ),
      value: selectedprovince,
      items: province.map((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedprovince = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a province';
        }
        return null;
      },
    );
  }

  Widget _buildAreaDropdown() {
    final List<String> areas =
        selectedCity != null ? areasByCity[selectedCity]! : [];

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Area',
        prefixIcon: Icon(Icons.place, color: Colors.blue.shade800),
      ),
      value: selectedArea,
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
              });
            },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an area';
        }
        return null;
      },
    );
  }

  Widget _buildPropertyTypeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Property Type',
        prefixIcon: Icon(Icons.home, color: Colors.blue.shade800),
      ),
      value: selectedPropertyType,
      items: propertyTypes.map((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedPropertyType = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a property type';
        }
        return null;
      },
    );
  }

  Widget _buildAreaField() {
    return TextFormField(
      controller: areaController,
      decoration: InputDecoration(
        labelText: 'Area (in square feet)',
        prefixIcon: Icon(Icons.square_foot, color: Colors.blue.shade800),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the area';
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return 'Please enter a valid area';
        }
        return null;
      },
    );
  }

  Widget _buildCounterRow(String label, int value, int maxValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.blue.shade800),
                  onPressed: () {
                    setState(() {
                      switch (label) {
                        case 'Bedrooms':
                          bedrooms = bedrooms > 0 ? bedrooms - 1 : 0;
                          break;
                        case 'Bathrooms':
                          bathrooms = bathrooms > 0 ? bathrooms - 1 : 0;
                          break;
                        case 'Parking Spaces':
                          parkingSpaces =
                              parkingSpaces > 0 ? parkingSpaces - 1 : 0;
                          break;
                        case 'Servant Quarters':
                          servantQuarters =
                              servantQuarters > 0 ? servantQuarters - 1 : 0;
                          break;
                        case 'Kitchens':
                          kitchens = kitchens > 1 ? kitchens - 1 : 1;
                          break;
                        case 'Store Rooms':
                          storeRooms = storeRooms > 0 ? storeRooms - 1 : 0;
                          break;
                      }
                    });
                  },
                ),
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: Text(
                    value.toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      switch (label) {
                        case 'Bedrooms':
                          bedrooms =
                              bedrooms < maxValue ? bedrooms + 1 : maxValue;
                          break;
                        case 'Bathrooms':
                          bathrooms =
                              bathrooms < maxValue ? bathrooms + 1 : maxValue;
                          break;
                        case 'Parking Spaces':
                          parkingSpaces = parkingSpaces < maxValue
                              ? parkingSpaces + 1
                              : maxValue;
                          break;
                        case 'Servant Quarters':
                          servantQuarters = servantQuarters < maxValue
                              ? servantQuarters + 1
                              : maxValue;
                          break;
                        case 'Kitchens':
                          kitchens =
                              kitchens < maxValue ? kitchens + 1 : maxValue;
                          break;
                        case 'Store Rooms':
                          storeRooms =
                              storeRooms < maxValue ? storeRooms + 1 : maxValue;
                          break;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Age/Possession Status',
        prefixIcon: Icon(Icons.access_time, color: Colors.blue.shade800),
      ),
      value: selectedAgeOption,
      items: ageOptions.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedAgeOption = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an age/possession status';
        }
        return null;
      },
    );
  }

  Widget _buildPricePrediction() {
    return Card(
      color: Colors.indigo.shade50,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: Colors.green,
                  size: 20,
                ),
                Text(
                  'AI Price Prediction',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              predictedPrice!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'This prediction is based on current market trends and similar properties in the selected area.',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  void _predictPrice() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final modedata = {
        "City": selectedCity,
        "property_type": selectedPropertyType,
        "parking_spaces": parkingSpaces,
        "Bedrooms": bedrooms,
        "Bathrooms": bathrooms,
        "servant_Quarters": servantQuarters,
        "Kitchens": kitchens,
        "store_rooms": storeRooms,
        "age_possession": selectedAgeOption,
        "area": double.tryParse(areaController.text),
        "colony": selectedArea,
        "province": selectedprovince
      };

      final pred=await modelapi().predictiondata(modedata);
      setState(() {
        // predictedPrice = pred;
        predictedPrice = pred;
        isLoading = false;
      });
    }
    ;
  }
}
