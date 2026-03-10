class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});
}

class CacheException implements Exception {}

class NoInternetException implements Exception {}

class FetchDataException extends ServerException {
  const FetchDataException({super.message = 'Error during communication'});
}

class BadRequestException extends ServerException {
  const BadRequestException({super.message = 'Bad request'});
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException({super.message = 'Unauthorized'});
}
