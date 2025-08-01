import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> messages = [
    {
      "message":
          "👋 Hi there! I'm your AI assistant. How can I help you today?",
      "type": "assistant"
    },
  ];

  final TextEditingController queryController = TextEditingController();
  final ScrollController scroller = ScrollController();
  bool isLoading = false;

  Future<void> sendMessage() async {
    final String query = queryController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      messages.add({"message": query, "type": "user"});
      isLoading = true;
    });
    queryController.clear();

    // Scroll to bottom after user message
    await Future.delayed(Duration(milliseconds: 100));
    scroller.animateTo(
      scroller.position.maxScrollExtent + 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    try {
      // OpenAI endpoint (replace with your actual API key)
      final openAiUrl = Uri.https("api.openai.com", "/v1/chat/completions");
      final headers = {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer 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"
      };
      final prompt = {
        "model": "gpt-4.1",
        "messages": [
          {"role": "user", "content": query}
        ],
        "temperature": 0.6,
      };

      final response = await http.post(
        openAiUrl,
        headers: headers,
        body: json.encode(prompt),
      );

      if (response.statusCode == 200) {
        final llmResponse = json.decode(response.body);
        final String responseContent =
            llmResponse['choices'][0]['message']['content'] ?? "No response.";
        setState(() {
          messages.add({"message": responseContent, "type": "assistant"});
        });
      } else {
        setState(() {
          messages.add({
            "message":
                "😔 Sorry, I couldn't get a response from the AI. Please try again.",
            "type": "assistant"
          });
        });
      }
    } catch (err) {
      setState(() {
        messages.add({
          "message":
              "⚠️ Oops! Something went wrong. Please check your connection.",
          "type": "assistant"
        });
      });
    } finally {
      setState(() {
        isLoading = false;
      });
      await Future.delayed(Duration(milliseconds: 100));
      if (scroller.hasClients) {
        scroller.animateTo(
          scroller.position.maxScrollExtent + 100,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  Widget _buildMessageBubble(Map<String, String> message, bool isUser) {
    final theme = Theme.of(context);
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message['message'] ?? "",
          style: theme.textTheme.bodyLarge?.copyWith(
            color: isUser
                ? Colors.white
                : theme.colorScheme.onSurface.withOpacity(0.9),
            fontSize: 17,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      controller: scroller,
      itemCount: messages.length + (isLoading ? 1 : 0),
      padding: EdgeInsets.only(top: 16, bottom: 16),
      itemBuilder: (context, index) {
        if (index == messages.length && isLoading) {
          // Loading bubble
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Thinking...",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        }
        final message = messages[index];
        final isUser = message['type'] == 'user';
        return _buildMessageBubble(message, isUser);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.chat_bubble_outline, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "AI Chatbot",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        backgroundColor: theme.primaryColor,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildChatList()),
            Divider(height: 1, thickness: 1),
            Container(
              color: theme.colorScheme.surface,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: queryController,
                      enabled: !isLoading,
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (_) => sendMessage(),
                      style: theme.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon:
                            queryController.text.isNotEmpty && !isLoading
                                ? IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () => queryController.clear(),
                                  )
                                : null,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    child: isLoading
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : IconButton(
                            key: ValueKey('send'),
                            icon: Icon(Icons.send_rounded,
                                color: theme.colorScheme.primary),
                            onPressed: sendMessage,
                            tooltip: "Send",
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
