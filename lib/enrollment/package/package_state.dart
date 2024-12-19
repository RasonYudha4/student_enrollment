part of 'package_bloc.dart';

sealed class PackageState extends Equatable {
  const PackageState();

  @override
  List<Object> get props => [];
}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {}

class PackageLoaded extends PackageState {
  final List<Package> packages;

  const PackageLoaded(this.packages);
}

class PackageError extends PackageState {
  final String errorMessage;

  const PackageError(this.errorMessage);
}

class PackageUpdatedSuccessfully extends PackageState {
  final String message;

  const PackageUpdatedSuccessfully(this.message);
}
