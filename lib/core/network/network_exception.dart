// Rastreio Já — Exceções de rede
library;

sealed class NetworkException implements Exception {
  const NetworkException(this.message);
  final String message;
}

final class NoInternetException extends NetworkException {
  const NoInternetException() : super('Sem conexao com a internet.');
}

final class NotFoundException extends NetworkException {
  const NotFoundException() : super('Recurso nao encontrado.');
}

final class ServerException extends NetworkException {
  const ServerException(super.message);
}

final class RequestTimeoutException extends NetworkException {
  const RequestTimeoutException() : super('Tempo de requisicao esgotado.');
}
