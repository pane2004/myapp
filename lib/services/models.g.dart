// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      value: json['value'] as String? ?? '',
      detail: json['detail'] as String? ?? '',
      correct: json['correct'] as bool? ?? false,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'value': instance.value,
      'detail': instance.detail,
      'correct': instance.correct,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      text: json['text'] as String? ?? '',
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'text': instance.text,
      'options': instance.options,
    };

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      title: json['title'] as String? ?? '',
      video: json['video'] as String? ?? '',
      description: json['description'] as String? ?? '',
      id: json['id'] as String? ?? '',
      topic: json['topic'] as String? ?? '',
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'video': instance.video,
      'topic': instance.topic,
      'questions': instance.questions,
    };

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      img: json['img'] as String? ?? 'default.png',
      quizzes: (json['quizzes'] as List<dynamic>?)
              ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'img': instance.img,
      'quizzes': instance.quizzes,
    };

Scan _$ScanFromJson(Map<String, dynamic> json) => Scan(
      classification: json['classification'] as String? ?? '',
      time: json['time'] as String? ?? '',
      img: json['img'] as String? ??
          'https://stickerly.pstatic.net/sticker_pack/13279e882d3a25af/KXTZ1R/2/39a69c85-b054-4d3c-9cdb-cf450cea8597-023.png',
    );

Map<String, dynamic> _$ScanToJson(Scan instance) => <String, dynamic>{
      'classification': instance.classification,
      'time': instance.time,
      'img': instance.img,
    };

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      uid: json['uid'] as String? ?? '',
      topics: json['topics'] as Map<String, dynamic>? ?? const {},
      total: json['total'] as int? ?? 0,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'uid': instance.uid,
      'total': instance.total,
      'topics': instance.topics,
    };
