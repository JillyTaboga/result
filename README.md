# result

A class to intermediate returns from services with two types of possible returns, like either from Dartz, but with a more specific and simple aproach.

Example in Service:

```dart
Future<Result<UserModel>> getUserData (String userID)async{
    try{
        final response = await http.get(url+userID);
        return Result<UserModel>(data: UserMode.fromJson(response.data),);
    } catch(e){
        return Result(error: ErrorResult(message: "User data not avaible"),);
    }
}
```

Example in use (normaly in Controller)

```dart
getUserData (String userID)async{
    Result<UserModel> result = await UsersService().getUserData(userID);
    result.fold(
        onSuccess: (data){
            loggedUser = data;
            notifyListeners();
            //navigate to home or other actions
        },
        onError: (error){
            //function to show the error, take the user to register ou logOut
        }
    );
}
```

**The class bring others methods to shortcut frequently actions:
successWithWarning(onSuccess) to call only a function on success and show a error on error;
showErrorDialog(context) to show a dialog of error;

## Getting Started

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
