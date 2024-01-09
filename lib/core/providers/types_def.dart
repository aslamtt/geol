import 'package:fpdart/fpdart.dart';
import 'failure.dart';

typedef FutureEither<T> = Future<Either<Failur, T>>;
typedef FutureVoid = FutureEither<void>;
