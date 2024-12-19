import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_enrollment/enrollment/service/enrollment_service.dart';
import 'package:student_enrollment/model/enrollment.dart';

part 'enrollment_event.dart';
part 'enrollment_state.dart';

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  final EnrollmentService _enrollmentService;
  EnrollmentBloc(this._enrollmentService) : super(EnrollmentInitial()) {
    on<GetEnrollment>((event, emit) async {
      try {
        emit(EnrollmentEventLoading());
        Enrollment? enrollment =
            await _enrollmentService.getEnrollment(event.userId);
        emit(EnrollmentFetchedSuccessfully(enrollment!));
      } catch (e) {
        emit(EnrollmentCreatedFailed());
      }
    });

    on<CreateEnrollment>(
      (event, emit) async {
        try {
          emit(EnrollmentEventLoading());
          await _enrollmentService.createEnrollment(event.enrollment);
          emit(EnrollmentCreatedSuccessfully());
        } catch (e) {
          emit(EnrollmentCreatedFailed());
        }
      },
    );
  }
}
