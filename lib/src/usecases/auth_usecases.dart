import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:muda_facil/src/controllers/user_controller.dart';
import 'package:muda_facil/src/controllers/user_order.dart';

abstract class BaseAuthUsecases {
  Future<void> onAuthenticate();
}

class AuthUsecases implements BaseAuthUsecases {
  final UserController _userController;
  final Function() _invalidateOrder;

  AuthUsecases(
    this._userController,
    this._invalidateOrder,
  );

  @override
  Future<void> onAuthenticate() async {
    await _userController.getUser();
    _invalidateOrder();
  }
}

final authUsecaseProvider = Provider(
  (ref) => AuthUsecases(
    ref.read(userControllerProvider.notifier),
    () => ref.invalidate(userOrderOrNullProvider),
  ),
);
