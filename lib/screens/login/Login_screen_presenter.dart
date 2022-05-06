
abstract class LoginScreenContract {
  //void onLoginSuccess(Login user);

  void onLoginError(String errorText);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  //final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));

  LoginScreenPresenter(this._view);

  doLogin(String username, String password) async {
    /*client.loginUser(username, password).then((Login user) {
      processLoginSuccess(user);
    }).catchError((Exception error) => _view.onLoginError(error.toString()));
    *//*client.loginUser(username, password).then((Login user) {
      processLoginSuccess(user);
    }).catchError((Exception error) => _view.onLoginError(error.toString()));*/
  }

  void processLoginSuccess(user) async {
   // _view.onLoginSuccess(user);
  }
}
