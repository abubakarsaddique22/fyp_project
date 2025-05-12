import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;
  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetCode() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Send password reset email
      print(_emailController.text);
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Link send check your mail",
            style: TextStyle(color: Colors.white, fontSize: 15),
          )
        )
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.message!,
            style: TextStyle(color: Colors.white, fontSize: 15),
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600; // Increased threshold for web
    final isWebPlatform = size.width > 800; // Additional check for web platform
    
    // Adjust card width for different screen sizes
    double cardWidth;
    if (isWebPlatform) {
      cardWidth = 550.0; // Wider card for web
    } else if (size.width > 600) {
      cardWidth = 500.0; // Medium card for tablet
    } else {
      cardWidth = size.width * 0.9; // Standard mobile size
    }

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(255, 22, 22, 22)
          : const Color(0xFFF0F7FF), // Light blue background
      body: Center( // Center everything on the page
        child: SingleChildScrollView(
          child: Container(
            width: isWebPlatform ? double.infinity : null,
            constraints: BoxConstraints(
              maxWidth: isWebPlatform ? 1200 : double.infinity,
            ),
            padding: isWebPlatform 
                ? EdgeInsets.symmetric(horizontal: 24, vertical: 32)
                : EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
              Icon(Icons.business, color: Colors.blue.shade800, size: 28),
                SizedBox(height: isWebPlatform ? 40 : size.height * 0.04),

                // Reset Password Card
                Container(
                  width: cardWidth,
                  padding: EdgeInsets.all(isWebPlatform ? 32 : (isSmallScreen ? 20 : 24)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(137, 37, 37, 37)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(isWebPlatform ? 16 : 12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isWebPlatform ? 0.1 : 0.05),
                        blurRadius: isWebPlatform ? 15 : 10,
                        spreadRadius: isWebPlatform ? 3 : 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: isWebPlatform ? 28 : (isSmallScreen ? 22 : 24),
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                      SizedBox(height: isWebPlatform ? 16 : size.height * 0.01),

                      // Description
                      Text(
                        'Enter your email address and we\'ll send you a verification code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isWebPlatform ? 16 : (isSmallScreen ? 13 : 14),
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                      SizedBox(height: isWebPlatform ? 32 : size.height * 0.03),

                      // Email Field Label
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: isWebPlatform ? 16 : (isSmallScreen ? 13 : 14),
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                      SizedBox(height: isWebPlatform ? 12 : 8),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: isWebPlatform ? 16 : 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'name@example.com',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.grey,
                            size: isWebPlatform ? 24 : 20,
                          ),
                          contentPadding: isWebPlatform
                              ? const EdgeInsets.symmetric(vertical: 20, horizontal: 16)
                              : const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(isWebPlatform ? 10 : 8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(isWebPlatform ? 10 : 8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(isWebPlatform ? 10 : 8),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                      ),
                      SizedBox(height: isWebPlatform ? 32 : size.height * 0.03),

                      // Send Reset Code Button
                      SizedBox(
                        width: double.infinity,
                        height: isWebPlatform ? 56 : 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _sendResetCode,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.blue.withOpacity(0.6),
                            elevation: isWebPlatform ? 2 : 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(isWebPlatform ? 10 : 8),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  width: isWebPlatform ? 24 : 20,
                                  height: isWebPlatform ? 24 : 20,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Send Reset Link',
                                      style: TextStyle(
                                        fontSize: isWebPlatform ? 18 : (isSmallScreen ? 15 : 16),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: isWebPlatform ? 20 : 18,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(height: isWebPlatform ? 24 : size.height * 0.02),

                      // Back to login
                      SizedBox(
                        width: double.infinity,
                        height: isWebPlatform ? 56 : 48,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black87,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(isWebPlatform ? 10 : 8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: isWebPlatform ? 16 : 12),
                          ),
                          child: Text(
                            'Back to login',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyMedium!.color,
                              fontSize: isWebPlatform ? 16 : (isSmallScreen ? 13 : 14),
                            ),
                          ),
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
  }
}