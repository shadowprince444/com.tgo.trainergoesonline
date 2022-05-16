enum SignInStatus { none, google, phone, signedIn, firstSignIn }
enum ConnectionStatusEnum {
  internetConnectionAvailable,
  internetConnectionNotAvailable,
  loading,
}
enum DeviceScreenType {
  mobile,
  tablet,
  desktop,
}
enum APiResponseStatus { completed, error, unauthenticated }

enum APIMethod {
  post,
  get,
  put,
  delete,
  patch,
}
enum InitialScreenStatus { firstLogIn, authenticated, unauthenticated }

enum PhoneAuthState {
  started,
  codeSent,
  codeResent,
  verified,
  failed,
  error,
  autoRetrievalTimeOut,
}
