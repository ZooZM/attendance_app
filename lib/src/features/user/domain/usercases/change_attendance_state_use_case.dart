import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/core/usecases/use_case.dart';
import 'package:attendance_app/src/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class ChangeAttendanceStateUseCase
    implements UseCase<void, ChangeAttendanceStateParams> {
  final UserRepository userRepository;

  ChangeAttendanceStateUseCase(this.userRepository);

  @override
  Future<Either<Failure, void>> call(ChangeAttendanceStateParams params) async {
    return await userRepository.changeAttendanceState(
      params.userId,
      params.newState,
    );
  }
}

class ChangeAttendanceStateParams {
  final String userId;
  final String newState;

  ChangeAttendanceStateParams({required this.userId, required this.newState});
}
