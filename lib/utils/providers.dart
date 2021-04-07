import 'package:mystore/Inbox/components/conversation_view_model.dart';
import 'package:mystore/VM/posts_view_model.dart';
import 'package:mystore/profile/components/edit_profile__model_view.dart';
import 'package:mystore/profile/components/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => EditProfileViewModel()),
  ChangeNotifierProvider(create: (_) => ProductViewModel()),
  ChangeNotifierProvider(create: (_) => UserViewModel()),
  ChangeNotifierProvider(create: (_) => ConversationViewModel()),
];
