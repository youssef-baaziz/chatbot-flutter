import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, String>> messages = [
    {"message": "Hello !!", "type": "user"},
    {"message": "How can I help you?", "type": "assistant"},
  ];

  TextEditingController queryController = TextEditingController();
  ScrollController scroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat AI",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scroller,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]['type'] == 'user';
                return Column(
                  children: [
                    ListTile(
                      trailing: isUser ? Icon(Icons.person_2_rounded) : null,
                      leading:
                          isUser ? null : Icon(Icons.support_agent_outlined),
                      title: Row(
                        children: [
                          SizedBox(
                            width: isUser ? 100 : 0,
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                messages[index]['message']!,
                                style: TextStyle(
                                    fontSize: 22,
                                    color:
                                        isUser ? Colors.white : Colors.black),
                                // style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              color: isUser ? Colors.teal : Colors.black12,
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                          SizedBox(
                            width: isUser ? 0 : 100,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: queryController,
                    decoration: InputDecoration(
                      hintText: "Type something...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    String queryy = queryController.text;
                    queryController.text = "";
                    // chatgpt
                    // var openAiUrl =
                    //     Uri.https("api.openai.com", "/v1/chat/completions");
                    // Map<String, String> headers = {
                    //   "Content-Type": "application/json",
                    //   "Authorization": ""
                    // };
                    // var prompt = {
                    //   "model": "gpt-3.5-turbo",
                    //   "messages": [
                    //     {"role": "user", "content": queryy}
                    //   ],
                    //   "temperature": 0.7
                    // };

                    //mistral Ai
                    var openAiUrl =
                        Uri.https("api.mistral.ai", "/v1/chat/completions");
                    Map<String, String> headers = {
                      "Content-Type": "application/json",
                      "Authorization": "Bearer your-secret-api-key"
                    };
                    var prompt = {
                      "model": "mistral-large-latest",
                      "messages": [
                        {"role": "user", "content": queryy}
                      ],
                      "temperature": 0.6,
                    };
                    http
                        .post(openAiUrl,
                            headers: headers, body: json.encode(prompt))
                        .then((response) {
                      var responseBody = response.body;
                      var llmResponse = json.decode(responseBody);
                      String responseContent =
                          llmResponse['choices'][0]['message']['content'];
                      setState(() {
                        messages.add({"message": queryy, "type": "user"});
                        messages.add(
                            {"message": responseContent, "type": "assistant"});
                        scroller
                            .jumpTo(scroller.position.maxScrollExtent + 300);
                      });
                    }, onError: (err) {
                      print("******* ERROR CHAT AI *******");
                      print(err);
                    });
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
