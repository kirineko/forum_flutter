import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:simple_forum_app/models/answer.dart';
import 'package:simple_forum_app/models/question.dart';
import 'package:simple_forum_app/models/token.dart';

final host = "https://forum.kirineko.tech";

Future<List<Question>> fetchAllQuestions() async {
  var uri = "$host/api/questions";
  final response = await http.get(Uri.parse(uri.toString()));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return json
        .decode(utf8.decode(response.bodyBytes))
        .map<Question>((model) => Question.fromJson(model))
        .toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load questions');
  }
}

Future<Question> fetchQuestionById(String qId) async {
  var uri = "$host/api/questions/$qId";
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Question.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load question');
  }
}

Future<List<Answer>> fetchAllAnswers(String qId) async {
  // var uri = Endpoint.uri("/questions/$qId/answers");
  var uri = "$host/api/questions/$qId/answers";
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return json
        .decode(utf8.decode(response.bodyBytes))
        .map<Answer>((model) => Answer.fromJson(model))
        .toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load answers');
  }
}

Future<Answer> fetchAnswerById(String qId, String aId) async {
  var uri = "$host/api/questions/$qId/answers/$aId";
  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Answer.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load answer');
  }
}

Future<Map<String, dynamic>> fetchData(String url) async {
  final response = await http.get(Uri.parse("$host/api/$url"));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return json.decode(utf8.decode(response.bodyBytes));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data');
  }
}

Future<Map<String, dynamic>> fetchDataWithAuth(String url, String token) async {
  final response = await http.get(Uri.parse("$host/api/$url"),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"});

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return json.decode(utf8.decode(response.bodyBytes));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Not authenticated');
  }
}

Future<Token> getToken(Object data) async {
  final response =
      await http.post(Uri.parse("$host/api/login/access-token"), body: data);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Token.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to get token');
  }
}

Future<bool> addQuestion(Object question) async {
  final response = await http.post(Uri.parse("$host/api/questions/add"),
      body: json.encode(question));

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Failed to add new question");
  }
}

Future<bool> addAnswer(String qId, Object answer) async {
  final response = await http.post(
      Uri.parse("$host/api/questions/$qId/answers/add"),
      body: json.encode(answer));

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception("Failed to add new answer");
  }
}
