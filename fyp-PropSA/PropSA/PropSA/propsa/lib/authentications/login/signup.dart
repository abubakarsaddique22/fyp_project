import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:propsa/authentications/login/reset.dart';
import 'package:propsa/screen/home.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen(this.check, {super.key});
  final bool check;
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleAuth() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        UserCredential userCredential;
        if (_isSignUp) {
          userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) =>home() ));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Account created for ${userCredential.user?.email}')),
          );
        } else {
          userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: const Color.fromARGB(255, 148, 42, 34),
                content:
                    Text('Signed in as ${userCredential.user?.email}')),
          );
          Navigator.pop(context);
        }

        //Optional navigation:
        // Navigator.pop(context);

      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'Email already in use.';
            break;
          case 'invalid-email':
            errorMessage = 'Invalid email address.';
            break;
          case 'weak-password':
            errorMessage = 'Password should be at least 6 characters.';
            break;
          case 'user-not-found':
            errorMessage = 'No user found.';
            break;
          case 'wrong-password':
            errorMessage = 'Incorrect password.';
            break;
          default:
            errorMessage = 'Something went wrong. Try again.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error occurred during authentication')),
        );
      }
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                   // Logo section
                     Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Icon(Icons.business, color: Colors.blue.shade800, size: 60),
                         Text("PropS&A",style: TextStyle(color: Colors.black,fontSize: 50,fontWeight: FontWeight.w600),),
                         Text("Unlock insights with our Property Prediction Site",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),)
                        , Text("log in to explore smart, data-driven real estate forecasts",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),)
                       ],
                     ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                 
              //      SizedBox(height: isWebPlatform ? 32 : size.height * 0.03),
                    
                    // Login/Signup card
                    Container(
                      width: cardWidth,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color.fromARGB(228, 37, 37, 37)
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
                      padding: EdgeInsets.all(isWebPlatform ? 32 : (isSmallScreen ? 20 : 24)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                _isSignUp ? 'Sign up' : 'Sign in',
                                style: TextStyle(
                                  fontSize: isWebPlatform ? 28 : (isSmallScreen ? 22 : 24),
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ),
                            SizedBox(height: isWebPlatform ? 12 : size.height * 0.008),
                            Center(
                              child: Text(
                                _isSignUp
                                    ? 'Create your account using email and password'
                                    : 'Enter your email and password to access your account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isWebPlatform ? 16 : (isSmallScreen ? 12 : 14),
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(height: isWebPlatform ? 28 : size.height * 0.025),
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: isWebPlatform ? 16 : (isSmallScreen ? 13 : 14),
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            SizedBox(height: isWebPlatform ? 12 : 8),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'name@example.com',
                                prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
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
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: isWebPlatform ? 22 : size.height * 0.018),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: isWebPlatform ? 16 : (isSmallScreen ? 13 : 14),
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ResetPasswordScreen()));
                                  },
                                  child: Text(
                                    'Forget Password?',
                                    style: TextStyle(
                                      fontSize: isWebPlatform ? 16 : (isSmallScreen ? 13 : 14),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: isWebPlatform ? 10 : 8),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
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
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: isWebPlatform ? 32 : size.height * 0.03),
                            SizedBox(
                              width: double.infinity,
                              height: isWebPlatform ? 56 : 48,
                              child: ElevatedButton(
                                onPressed: _handleAuth,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  elevation: isWebPlatform ? 2 : 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(isWebPlatform ? 10 : 8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _isSignUp ? 'Sign up' : 'Sign in',
                                      style: TextStyle(
                                        fontSize: isWebPlatform ? 18 : (isSmallScreen ? 15 : 16),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: isWebPlatform ? 10 : size.height * 0.018),
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _isSignUp
                                        ? 'Already have an account?'
                                        : 'Don\'t have an account?',
                                    style: TextStyle(
                                      fontSize: isWebPlatform ? 16 : (isSmallScreen ? 12 : 14),
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _isSignUp = !_isSignUp;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      _isSignUp ? 'Sign in' : 'Sign up',
                                      style: TextStyle(
                                        fontSize: isWebPlatform ? 16 : (isSmallScreen ? 12 : 14),
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: isWebPlatform ? 16 : size.height * 0.01),
                            SizedBox(
                              width: double.infinity,
                              height: isWebPlatform ? 40 : 48,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
                                  'Back to welcome page',
                                  style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: isWebPlatform ? 16 : (isSmallScreen ? 13 : 14),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}