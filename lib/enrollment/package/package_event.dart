part of 'package_bloc.dart';

sealed class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}

class GetAllPackage extends PackageEvent {}

class GetPackageByUserId extends PackageEvent {
  final String userId;

  const GetPackageByUserId(this.userId);
}

class UpdatePackage extends PackageEvent {
  final Package package;

  const UpdatePackage(this.package);
}
