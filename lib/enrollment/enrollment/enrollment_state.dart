part of 'enrollment_bloc.dart';

sealed class EnrollmentState extends Equatable {
  const EnrollmentState();

  @override
  List<Object> get props => [];
}

class EnrollmentInitial extends EnrollmentState {}

class EnrollmentEventLoading extends EnrollmentState {}

class EnrollmentFetchedSuccessfully extends EnrollmentState {
  final Enrollment enrollment;

  const EnrollmentFetchedSuccessfully(this.enrollment);
}

class EnrollmentFetchFailed extends EnrollmentState {}

class EnrollmentCreatedSuccessfully extends EnrollmentState {}

class EnrollmentCreatedFailed extends EnrollmentState {}
