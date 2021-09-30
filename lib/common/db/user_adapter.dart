import 'package:fmm_app/common/db/user.dart';
import 'package:hive/hive.dart';

class UserAdapter extends TypeAdapter<User>{
  @override
  int get typeId => 0;

  @override
  User read(BinaryReader reader) {
    return User(reader.read(), reader.read(), reader.read(), reader.read());
  }

  @override
  void write(BinaryWriter writer, User obj) {
      writer.write(obj.userId);
      writer.write(obj.phone);
      writer.write(obj.token);
      writer.write(obj.avatarImg);
  }
}