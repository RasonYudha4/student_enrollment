import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_enrollment/enrollment/service/package_service.dart';
import 'package:student_enrollment/model/package.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  final PackageService _packageService;
  PackageBloc(this._packageService) : super(PackageInitial()) {
    on<GetAllPackage>(
      (event, emit) async {
        try {
          emit(PackageLoading());
          final packages = await _packageService.getAllPackage();
          emit(PackageLoaded(packages));
        } catch (e) {
          emit(const PackageError('Failed to load packages'));
        }
      },
    );

    on<GetPackageByUserId>(
      (event, emit) async {
        try {
          emit(PackageLoading());
          final packages =
              await _packageService.getAllPackageByUserId(event.userId);
          emit(PackageLoaded(packages));
        } catch (e) {
          emit(const PackageError('Failed to load packages'));
        }
      },
    );

    // on<UpdatePackage>(
    //   (event, emit) async {
    //     try {
    //       emit(PackageLoading());
    //       await _packageService.updatePackage(event.package);
    //       emit(PackageLoaded(await _packageService.getAllPackage()));
    //     } catch (e) {
    //       emit(const PackageError('Failed toupdate packages'));
    //     }
    //   },
    // );
  }
}
