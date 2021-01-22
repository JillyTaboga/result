library result;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

typedef Widget ShowError(ResultError error);
typedef OnSuccess<T>(T data);
typedef OnFail(ResultError error);

///Create a result class for a data or a error
///The T type is for the type of the data
class Result<T> {
  T data;
  ResultError error;
  Result({
    this.data,
    this.error,
  });

  ///Create a result class for a success with a dynamic data
  Result.success(this.data);

  ///Create a result class for a error with a ErrorResult class as parameter
  Result.error(this.error);

  ///Create a result class for a error from Strings for a message
  Result.errorMessage({
    @required String message,
    String description,
    String cod,
  }) {
    this.error = ResultError(
      message: message,
      description: description,
      cod: cod,
    );
  }

  ///Determine if the result was a success (true) or a error (false)
  bool get success => data != null;

  ///Shortcut to show a error message dialog
  ///The dialog can be personalized with the function dialogBuilder (ErrorResult)=>Widget
  showErrorMessage({
    @required BuildContext context,
    bool dismissibleBarrier = true,
    ShowError dialogBuilder,
  }) {
    if (!success) {
      showDialog(
        context: context,
        builder: (context) {
          return dialogBuilder != null
              ? dialogBuilder(this.error)
              : ErrorDialog(
                  message: error.message,
                  description: error.description,
                  cod: error.cod,
                );
        },
        barrierDismissible: dismissibleBarrier,
      );
    }
  }

  ///Shortcut to call a funtion (data){} in case of success or call a dialog for error message
  ///The error dialog can be personalized with the function dialogBuilder (ErrorResult)=>Widget
  successWithWarning({
    @required BuildContext context,
    @required OnSuccess<T> onSuccess,
    ShowError dialogBuilder,
  }) async {
    if (success) {
      await onSuccess(data);
    } else {
      showErrorMessage(
        context: context,
        dialogBuilder: dialogBuilder,
      );
    }
  }

  ///Method that call a function (T data){} in case of success or a (ErrorResult error){} in case of error
  fold({
    @required OnSuccess<T> onSuccess,
    @required OnFail onFail,
  }) async {
    if (success) {
      await onSuccess(data);
    } else {
      onFail(error);
    }
  }
}

///Class to represent a error, it can personalized, extend it for your own classes like a ConnectiorError
class ResultError {
  String message;
  String description;
  String cod;
  ResultError({
    @required this.message,
    this.description,
    this.cod,
  });
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key key,
    @required this.message,
    this.cod,
    this.description,
  }) : super(key: key);

  final String message;
  final String cod;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              size: 50,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                if (description != null) Text(description),
                if (cod != null) Text(' ($cod)'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
