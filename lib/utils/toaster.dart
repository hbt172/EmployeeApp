part of utils;

class Toaster
{
  static showMessage(context,{ required String msg}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }

}