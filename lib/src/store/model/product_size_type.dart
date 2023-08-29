import 'package:murok_prj/src/store/model/categorical.dart';
import 'package:murok_prj/src/store/model/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({this.numerical, this.categorical});
}
