# result

A class to intermediate returns from services with two types of possible returns, like either from Dartz, but just to acomadate a simple function.

Example:
'''dart
Future<Result<UserModel>> getUserData (String userID)async{
    try{
        final response = await http.get(url+userID);
        return Result<UserModel>(data: UserMode.fromJson(response.data),
        );
    } catch(e){
        return Result(error: ErrorResult(message: 'User data not avaible),
        );
    }

}

## Getting Started

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
