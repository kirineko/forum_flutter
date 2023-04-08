import 'package:simple_forum_app/models/answer.dart';
import 'package:simple_forum_app/models/author.dart';
import 'package:simple_forum_app/models/item.dart';
import 'package:simple_forum_app/question_list_page.dart';

class Question implements Item{
  late String qId;
  late String title;
  late String description;
  late int? answerCount;
  late Author? author;

  Question(this.title, this.description);
  Question.blank()
    : qId = "",
      title = "",
      description = "";
      
  Question.fromJson(Map<String, dynamic> json) {
    qId = json["qId"];
    title = json["title"];
    description = json["description"];
    answerCount = json["answerCount"];
    
      if (json["author"] != null) {
        author = Author.fromJson(json["author"]);
      }
  }
}

// class QuestionWithAnswerList extends Question{
//   List<Answer> answerList; 

//   QuestionWithAnswerList({String id, String title, this.answerList}): super(id, title);

//     factory QuestionWithAnswerList.fromJson(Map<String, dynamic> json) {
//     return QuestionWithAnswerList(
//       id: json['id'],
//       title: json['title'],
//       answerList: json['answerList'].map<Answer>((model) => Answer.fromJson(model)).toList()
//     );
//   }
// }