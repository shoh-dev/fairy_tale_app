import 'package:equatable/equatable.dart';

class TaleInteraction extends Equatable {
  final String id;
  final String pageId;
  final String eventType;
  final String action;
  final String trigger;
  final String? hintKey;

  const TaleInteraction({
    required this.id,
    required this.pageId,
    required this.eventType,
    required this.action,
    required this.trigger,
    this.hintKey,
  });

  factory TaleInteraction.fromJson(Map<String, dynamic> json) => TaleInteraction(
        id: json['id'] as String,
        pageId: json['tale_page_id'] as String,
        eventType: json['event_type'] as String,
        action: json['action'] as String,
        trigger: json['trigger'] as String,
        hintKey: json['hint_key'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'page_id': pageId,
        'event_type': eventType,
        'action': action,
        'trigger': trigger,
        'hint_key': hintKey,
      };

  @override
  List<Object?> get props => [id, pageId, eventType, action, trigger, hintKey];
}
