import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/config/base_state/state_types.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:flutter/cupertino.dart';

extension HandleBuilderState on BaseState {
  Widget? handleBuilderState<T>({
    Widget? onSuccess,
    Widget? onLoading,
    Widget? onEmpty,
    Widget? onError,
  }) {
    switch (state) {
      case BaseStateType.success:
        return onSuccess;
      case BaseStateType.loading:
        return onLoading ??
            Center(
              child: CupertinoActivityIndicator(color: AppColors.primaryBlue),
            );

      case BaseStateType.error:
        return onError;

      default:
        return null;
    }
  }
}
