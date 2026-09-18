abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerError extends Failure{
  ServerError(super.message);
}
class ConnectionFailure extends Failure {

  ConnectionFailure(super.message);

}