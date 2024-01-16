import 'package:fpdart/fpdart.dart';

import 'failiur.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
