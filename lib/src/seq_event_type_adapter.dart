import 'package:dart_seq/dart_seq.dart';
import 'package:hive/hive.dart';

class SeqEventTypeAdapter extends TypeAdapter<SeqEvent> {
  static const int uniqueTypeId = 4444;

  @override
  SeqEvent read(BinaryReader reader) {
    final milliseconds = reader.readInt();
    final timestamp = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    final hasMessage = reader.readBool();
    final message = hasMessage ? reader.readString() : null;

    final hasMessageTemplate = reader.readBool();
    final messageTemplate = hasMessageTemplate ? reader.readString() : null;

    final hasLevel = reader.readBool();
    final level = hasLevel ? reader.readString() : null;

    final hasException = reader.readBool();
    final exception = hasException ? reader.readString() : null;

    final hasId = reader.readBool();
    final id = hasId ? reader.readInt() : null;

    final hasRenderings = reader.readBool();
    final renderings =
        hasRenderings ? reader.readMap().cast<String, dynamic>() : null;

    final hasContext = reader.readBool();
    final context =
        hasContext ? reader.readMap().cast<String, dynamic>() : null;

    return SeqEvent(timestamp, message, messageTemplate, level, exception, id,
        renderings, context);
  }

  @override
  int get typeId => uniqueTypeId;

  @override
  void write(BinaryWriter writer, SeqEvent obj) {
    writer.writeInt(obj.timestamp.millisecondsSinceEpoch);

    final message = obj.message;
    final hasMessage = message != null;
    writer.writeBool(hasMessage);
    if (hasMessage) {
      writer.writeString(message);
    }

    final messageTemplate = obj.messageTemplate;
    final hasMessageTemplate = messageTemplate != null;
    writer.writeBool(hasMessageTemplate);
    if (hasMessageTemplate) {
      writer.writeString(messageTemplate);
    }

    final level = obj.level;
    final hasLevel = level != null;
    writer.writeBool(hasLevel);
    if (hasLevel) {
      writer.writeString(level);
    }

    final exception = obj.exception;
    final hasException = exception != null;
    writer.writeBool(hasException);
    if (hasException) {
      writer.writeString(Error.safeToString(exception));
    }

    final id = obj.id;
    final hasId = id != null;
    writer.writeBool(hasId);
    if (hasId) {
      writer.writeInt(id);
    }

    final renderings = obj.renderings;
    final hasRenderings = renderings != null;
    writer.writeBool(hasRenderings);
    if (hasRenderings) {
      writer.writeMap(renderings);
    }

    final context = obj.context;
    final hasContext = context != null;
    writer.writeBool(hasContext);
    if (hasContext) {
      writer.writeMap(context);
    }
  }
}
