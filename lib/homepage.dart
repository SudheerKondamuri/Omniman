import 'package:flutter/material.dart';
import 'package:omniman/openai_service.dart';
import 'package:omniman/pallete.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String message =
      "You don't seem to understand. Earth isn't yours to conquer...";
  final speechToText = SpeechToText();
  final OpenAIService openAIService = OpenAIService();
  final TextEditingController _text = TextEditingController();
  Future<String>? _responseFuture;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Pallete.whiteColor,
        title: Text(
          'Omni-Man',
          style: TextStyle(
            color: Pallete.blackColor,
            fontFamily: 'Cera Pro',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      height: 123,
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/omniman.jpeg'),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 40,
                      ).copyWith(top: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallete.borderColor),
                        borderRadius: BorderRadius.circular(
                          20,
                        ).copyWith(topLeft: Radius.zero),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child:
                            _responseFuture == null
                                ? Text(
                                  message,
                                  style: TextStyle(
                                    fontFamily: 'Cera Pro',
                                    color: Pallete.mainFontColor,
                                    fontSize: 22,
                                  ),
                                )
                                : FutureBuilder<String>(
                                  future: _responseFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        style: TextStyle(
                                          fontFamily: 'Cera Pro',
                                          color: Pallete.mainFontColor,
                                          fontSize: 22,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        message,
                                        style: TextStyle(
                                          fontFamily: 'Cera Pro',
                                          color: Pallete.mainFontColor,
                                          fontSize: 22,
                                        ),
                                      );
                                    }
                                  },
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _text,
                  decoration: InputDecoration(
                    hintText: 'Ask anything',
                    hintStyle: TextStyle(color: Colors.grey[900]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _responseFuture = openAIService.promptAPI(_text.text);
                        });
                      },
                      icon: Icon(Icons.send),
                      color: Colors.grey[900],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
