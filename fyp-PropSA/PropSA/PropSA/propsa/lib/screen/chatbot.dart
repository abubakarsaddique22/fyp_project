import 'package:flutter/material.dart';
import 'package:propsa/model&Api/gemini.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  State<Chatbot> createState() => _HeartHealthScreenState();
}

class _HeartHealthScreenState extends State<Chatbot> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour == 0 ? 12 : now.hour;
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${now.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  void initState() {
    super.initState();
    _messages.add(
      ChatMessage(
        message: "Hey there! I'm your property bot. Ask me anything about property!",
        isUser: false,
        timestamp: _getCurrentTime(),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        message: text,
        isUser: true,
        timestamp: _getCurrentTime(),
      ));
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      final data = await geminiapi().req(text);
      final cleaned = data.replaceAll("*", "").replaceAll("#", "");

      await Future.delayed(const Duration(milliseconds: 800)); // simulate delay

      final newMessage = ChatMessage(
        message: cleaned,
        isUser: false,
        timestamp: _getCurrentTime(),
      );

      setState(() {
        _isTyping = false;
        _messages.add(newMessage);
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          message: "Oops! I'm a little under the weather. Try again later 😓",
          isUser: false,
          timestamp: _getCurrentTime(),
        ));
        _isTyping = false;
      });
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine if we're on a larger screen (tablet or web)
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
    
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                // Constrain width for larger screens to maintain readability
                width: isLargeScreen ? 800 : constraints.maxWidth,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    _buildHeader(isLargeScreen),
                    const SizedBox(height: 16),
                    Divider(color: Colors.grey[300], thickness: 1),
                    Expanded(
                      child: _buildMessagesArea(isLargeScreen),
                    ),
                    _buildMessageInput(isLargeScreen),
                    _buildDisclaimer(isLargeScreen),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLargeScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isLargeScreen ? 40 : 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Icon( Icons.bolt,color: Colors.blue.shade800,size: 28,),
              SizedBox(width: isLargeScreen ? 16 : 10),
              Text(
                'Bolt - AI property Assistant',
                style: TextStyle(fontSize: isLargeScreen ? 24 : 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: isLargeScreen ? 600 : double.infinity,
            child: Text(
              'Hi iam Bolt-Ask me about anything relate property!',
              style: TextStyle(color: Colors.grey[600], fontSize: isLargeScreen ? 15 : 13.5),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesArea(bool isLargeScreen) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isLargeScreen ? 30 : 12),
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 20 : 10),
        itemCount: _messages.length + (_isTyping ? 1 : 0),
        itemBuilder: (context, index) {
          if (_isTyping && index == _messages.length) {
            return _buildTypingIndicator(isLargeScreen);
          }
          return _buildAnimatedMessage(_messages[index], isLargeScreen);
        },
      ),
    );
  }

  Widget _buildAnimatedMessage(ChatMessage message, bool isLargeScreen) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(1, 0), end: Offset.zero),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      builder: (context, offset, child) {
        return Transform.translate(offset: offset, child: child);
      },
      child: _buildMessageItem(message, isLargeScreen),
    );
  }

  Widget _buildMessageItem(ChatMessage message, bool isLargeScreen) {
    // Adjust width constraints for web view
    final maxWidth = isLargeScreen 
        ? (message.isUser ? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.6)
        : double.infinity;
        
    return Container(
      margin: EdgeInsets.symmetric(vertical: isLargeScreen ? 12 : 6),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser)
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              radius: isLargeScreen ? 20 : 16,
              child:   Icon( Icons.bolt,color: Colors.blue.shade800,size: 28,),
            ),
          if (!message.isUser) SizedBox(width: isLargeScreen ? 10 : 6),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isLargeScreen ? 20 : 14, 
                  vertical: isLargeScreen ? 14 : 10
                ),
                decoration: BoxDecoration(
                  color: message.isUser 
                      ?  Colors.blue.shade800
                      : Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 36, 36, 36)
                          : const Color.fromARGB(255, 220, 220, 220),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isLargeScreen ? 20 : 16),
                    topRight: Radius.circular(isLargeScreen ? 20 : 16),
                    bottomLeft: Radius.circular(message.isUser ? (isLargeScreen ? 20 : 16) : (isLargeScreen ? 6 : 4)),
                    bottomRight: Radius.circular(message.isUser ? (isLargeScreen ? 6 : 4) : (isLargeScreen ? 20 : 16)),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: isLargeScreen ? 6 : 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!message.isUser)
                      Padding(
                        padding: EdgeInsets.only(bottom: isLargeScreen ? 8.0 : 4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Bolt-Property Assistant',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: isLargeScreen ? 14 : 12,
                                color: Theme.of(context).textTheme.bodyMedium!.color,
                              ),
                            ),
                            SizedBox(width: isLargeScreen ? 10 : 6),
                            Text(
                              message.timestamp,
                              style: TextStyle(
                                fontSize: isLargeScreen ? 13 : 11,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Text(
                      message.message,
                      style: TextStyle(
                        fontSize: isLargeScreen ? 16 : 14, 
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color.fromARGB(255, 222, 222, 222)
                            : message.isUser ? Colors.white : Colors.black87,
                        height: 1.4, // Better line height for readability on web
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(bool isLargeScreen) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     Icon( Icons.bolt,color: Colors.blue.shade800,size: 28,),
        SizedBox(width: isLargeScreen ? 12 : 8),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isLargeScreen ? 20 : 14, 
            vertical: isLargeScreen ? 14 : 10
          ),
          margin: EdgeInsets.symmetric(vertical: isLargeScreen ? 12 : 6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 192, 191, 191),
            borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: isLargeScreen ? 6 : 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const AnimatedDots(),
        ),
      ],
    );
  }

  Widget _buildMessageInput(bool isLargeScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 40 : 16, 
        vertical: isLargeScreen ? 24 : 16
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!, width: isLargeScreen ? 1.5 : 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your question...',
                hintStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: isLargeScreen ? 15 : 13
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 41, 41, 41)
                    : Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isLargeScreen ? 20 : 16, 
                  vertical: isLargeScreen ? 16 : 12
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(fontSize: isLargeScreen ? 16 : 14),
            ),
          ),
          SizedBox(width: isLargeScreen ? 16 : 8),
          ElevatedButton(
            onPressed: _sendMessage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isLargeScreen ? 30 : 24)),
              padding: EdgeInsets.symmetric(
                horizontal: isLargeScreen ? 28 : 20, 
                vertical: isLargeScreen ? 16 : 12
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.send_rounded, color: Colors.white, size: isLargeScreen ? 22 : 18),
                SizedBox(width: isLargeScreen ? 10 : 5),
                Text('Send', style: TextStyle(fontSize: isLargeScreen ? 16 : 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimer(bool isLargeScreen) {
    return Container(
      padding: EdgeInsets.only(
        bottom: isLargeScreen ? 40 : 25, 
        left: isLargeScreen ? 40 : 16, 
        right: isLargeScreen ? 40 : 16
      ),
      width: isLargeScreen ? 700 : double.infinity,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: isLargeScreen ? 14 : 12, 
            color: Colors.grey[600]
          ),
          children: const [
            TextSpan(text: 'Disclaimer: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
              text:
                  'This AI assistant provides general info and is not a substitute for real advice. Please consult a realEstate agent for serious investments!',
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated dots for typing effect
class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation1;
  late final Animation<double> _animation2;
  late final Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
    _animation1 = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
    _animation2 = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.6, curve: Curves.easeOut)),
    );
    _animation3 = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeOut)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
    
    return SizedBox(
      height: isLargeScreen ? 18 : 14,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDot(_animation1, isLargeScreen),
          SizedBox(width: isLargeScreen ? 6 : 4),
          _buildDot(_animation2, isLargeScreen),
          SizedBox(width: isLargeScreen ? 6 : 4),
          _buildDot(_animation3, isLargeScreen),
        ],
      ),
    );
  }

  Widget _buildDot(Animation<double> animation, bool isLargeScreen) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, -animation.value),
        child: Dot(isLargeScreen: isLargeScreen),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool isLargeScreen;
  
  const Dot({super.key, this.isLargeScreen = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isLargeScreen ? 8 : 6,
      height: isLargeScreen ? 8 : 6,
      decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
    );
  }
}