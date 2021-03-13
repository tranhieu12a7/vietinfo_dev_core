import 'package:flutter/cupertino.dart';

abstract class CoreSizeDataSource{
    Size screenSize;
    void init(BuildContext context){
      screenSize=MediaQuery.of(context).size;
    }
    double getFontSize(double fontSize);
}
class CoreSizeResponse extends CoreSizeDataSource{

  CoreSizeResponse(BuildContext context){
    screenSize=MediaQuery.of(context).size;
  }

  @override
  double getFontSize(double fontSize) {
    if(screenSize.width<screenSize.height){
      var fonSize=screenSize.width * (fontSize / 350);
      return fonSize;
    }
    var fonSize=screenSize.height * (fontSize / 350);
    return fonSize;

  }

}