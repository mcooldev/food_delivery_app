import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/fonts.dart';
import 'package:food_delivery_app/models/message_model.dart';
import 'package:grouped_list/grouped_list.dart';

class SupportChat extends StatefulWidget {
  const SupportChat({super.key});

  @override
  State<SupportChat> createState() => _SupportChatState();
}

class _SupportChatState extends State<SupportChat> {
  ///
  final messages = MessageModel.messages;

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,

      /*App bar content here*/
      appBar: AppBar(
        backgroundColor: white,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/mc-pic.png"),
              radius: 22,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nom de l'agent",
                  style: bodyText.apply(
                    fontWeightDelta: 700,
                    color: darkPurple,
                  ),
                ),
                const SizedBox(height: 2),
                Text("En ligne", style: smallText),
              ],
            ),
          ],
        ),
      ),

      /*Body content here*/
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: GroupedListView(
                padding: const EdgeInsets.all(16),
                elements: messages,
                groupBy: (MessageModel message) => DateTime(2025),
                groupHeaderBuilder:
                    (MessageModel message) => Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90),
                          ),
                          color: customGreen,
                        ),
                        child: Text(
                          message.date,
                          style: smallTextBold.apply(color: darkPurple),
                        ),
                      ),
                    ),
                order: GroupedListOrder.ASC,
                itemBuilder: (context, MessageModel message) {
                  return Align(
                    alignment:
                        message.isSentByMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        shape: ContinuousRectangleBorder(
                          borderRadius:
                              message.isSentByMe
                                  ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  )
                                  : const BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                        ),
                        color: message.isSentByMe ? purple : lightBg,
                      ),
                      child: Text(
                        message.content,
                        style: bodyText.apply(
                          color: message.isSentByMe ? white : bodyTextColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Bottom message container
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: white,
                border: Border(top: BorderSide(width: 0.7, color: strokeColor)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // todo: Add files
                    },
                    icon: Icon(CupertinoIcons.add, size: 32, color: purple),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: ShapeDecoration(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: lightBg,
                      ),

                      /// Text field && emoji btn
                      child: Row(
                        children: [
                          /// Text field
                          Flexible(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                hint: const Text("Votre message ici..."),
                                hintStyle: bodyText,
                              ),
                            ),
                          ),

                          /// Emoji
                          IconButton(
                            onPressed: () {
                              // todo: Emoji btn
                            },
                            icon: Icon(
                              Icons.sentiment_satisfied_alt_rounded,
                              color: purple,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Send btn
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: purple,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // todo: Send btn
                      },
                      icon: Icon(Icons.send_rounded, color: white),
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
