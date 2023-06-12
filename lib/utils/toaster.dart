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

  static showMessageWithUndo(context,{required String msg,Function()? onTap}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.fixed,
      content: Row(
        children: [
          Expanded(child: Text(msg)),
          InkWell(
            onTap: onTap,
              child: Text('Undo',style: CustomTextStyle.font400FontSize15.copyWith(color: const Color(0xff1DA1F2)),))
        ],
      ),

      duration: const Duration(seconds: 3),
    ));
  }
}