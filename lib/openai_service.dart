import 'dart:convert';
import 'package:omniman/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<String> promptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "deepseek/deepseek-r1-0528-qwen3-8b:free",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are Omni-Man from *Invincible*. Speak like him — authoritative, intense, and brutally honest. Always stay in character.",
            },
            {"role": "user", "content": prompt},
          ],
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final responseText =
            data['choices'][0]['message']['content'].toString().trim();
        return responseText;
      } else {
        return 'Error: ${res.statusCode}';
      }
    } catch (e) {
      return 'Exception: $e';
    }
  }
}

