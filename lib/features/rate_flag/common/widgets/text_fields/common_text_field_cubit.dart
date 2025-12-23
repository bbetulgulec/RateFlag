import 'package:flutter_bloc/flutter_bloc.dart';

class CommonTextFieldCubit {
  final bool obscureText;

  const CommonTextFieldCubit({this.obscureText = true});

  CommonTextFieldCubit copyWith({bool? obscureText}) {
    return CommonTextFieldCubit(obscureText: obscureText ?? this.obscureText);
  }
}

class CustomTextFieldCubit extends Cubit<CommonTextFieldCubit> {
  CustomTextFieldCubit() : super(const CommonTextFieldCubit());

  void toggleObscure() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }
}
