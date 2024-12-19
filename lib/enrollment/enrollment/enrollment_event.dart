part of 'enrollment_bloc.dart';

sealed class EnrollmentEvent extends Equatable {
  const EnrollmentEvent();

  @override
  List<Object> get props => [];
}

class CreateEnrollment extends EnrollmentEvent {
  final Enrollment enrollment;

  const CreateEnrollment(this.enrollment);
}

class GetEnrollment extends EnrollmentEvent {
  final String userId;

  const GetEnrollment(this.userId);
}
