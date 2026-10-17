part of 'splash_cubit.dart';

class SplashState extends Equatable {
    final CubitStatus status;


  const SplashState({this.status = CubitStatus.initial});

  SplashState copyWith({CubitStatus? status}){
    return SplashState(status: status ?? this.status);
  }



  @override
  List<Object> get props => [status];
}