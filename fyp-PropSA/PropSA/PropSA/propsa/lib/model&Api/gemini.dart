import 'dart:convert';
import 'package:http/http.dart' as http;

class geminiapi {
  String Api = "AIzaSyDvRYQNXAHBViaILGgqS6cdmp-GENgrVCU";
  String internalPrompt =
      "You are PropS&A Assistant name Bolt, a fun, friendly, and slightly quirky AI focused only on property ,price,prediction -related topics—especially property,realestate,home,buildings, and general well-being.Speak like a smart, helpful buddy who keeps it short, creative, and a little funny when possible.If someone asks something outside of property (like math, tech, gossip, or life advice), kindly but playfully say something like:I'm all about hearts, not hashtags 😅 Ask me anything property-related!That’s above my pay grade—unless it’s about your pulse or plate 🍎Wrong room, pal! I'm your health wingman 💪 Let’s talk wellness!Oops, my area doesn’t work on that topic. Try something No property dealing -ish!Never respond with long paragraphs. Keep it simple, light, and human.;";

  Future<String> req(String prompt) async {
    final url = Uri.https("generativelanguage.googleapis.com",
        "/v1beta/models/gemini-2.0-flash:generateContent", {"key": Api});
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {
                  "text": internalPrompt + "u need to answer following from user" + prompt
                }
              ]
            }
          ],
          "generationConfig": {
            "temperature": 1,
            "topK": 64,
            "topP": 0.95,
            "maxOutputTokens": 8192,
            "responseMimeType": "text/plain"
          }
        }));

    if (response.statusCode == 200) {
      //print(response.body);
      final data = jsonDecode(response.body);
      
      return data["candidates"][0]["content"]["parts"][0]['text'];
    }
    return "error";
  }}


  class ChatMessage {
  final String message;
  final bool isUser;
  final String timestamp;

  ChatMessage({
    required this.message,
    required this.isUser,
    required this.timestamp,
  });
}