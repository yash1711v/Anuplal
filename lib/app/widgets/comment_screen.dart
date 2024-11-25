import 'package:anuplal/app/models/profile_model.dart';
import 'package:flutter/material.dart';

import '../services/api_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommentBottomSheet extends StatefulWidget {
  String userId;
  String postId;

  CommentBottomSheet({required this.userId, required this.postId});

  @override
  State<StatefulWidget> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final List<dynamic> _comments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getComments(widget.postId)!.then((value) {
      debugPrint(value.toString());
      setState(() {
        _comments.addAll(value);
      });
    });
  }

  String formatDateTime(String apiDateTime) {
    // Parse the datetime string to a DateTime object
    DateTime dateTime = DateTime.parse(apiDateTime);

    // Format the date
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    // Format the time in 12-hour format
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return "$formattedDate $formattedTime";
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      Get.snackbar('Comment:', 'Please wait adding comment');
      ApiService()
          .CommentOnApi(
        comment: _commentController.text,
        user_id: widget.userId,
        post_id: widget.postId,
      )
          .then((value) {
        print(value);
        if (value) {
          ApiService().getComments(widget.postId)!.then((value) {
            debugPrint(value.toString());

            setState(() {
              _comments.clear();
              _comments.addAll(value);
              _commentController.clear();
            });
          });
        } else {
          Get.snackbar('Error', 'Something went wrong');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // Dismiss keyboard on outside tap
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), // Rounded corners
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size based on content
            children: [
              // Header (drag handle)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              // Comments List
              _comments.length > 0
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        // Required for Scrollable in SingleChildScrollView
                        itemCount: _comments.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        (_comments[index]["user"] ??
                                            User(
                                                    id: 0,
                                                    name: "",
                                                    phone: "",
                                                    phoneVerified: false,
                                                    emailVerified: false,
                                                    isActive: false,
                                                    profilePhoto: "",
                                                    dateOfBirth: "")
                                                .toJson())["name"],
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatDateTime((_comments[index]["created_at"]) ?? ""),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(_comments[index]["comments"]),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          "No comments yet",
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    )),
              // Input Field
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom, // Avoid keyboard overlap
                  left: 8.0,
                  right: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: "Add a comment...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: _addComment,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Center(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// To show the bottom sheet:
void showCommentSheet(BuildContext context,
    {required String userId, required String postId}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (_) => CommentBottomSheet(
      userId: userId,
      postId: postId,
    ),
  );
}
