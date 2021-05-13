
import 'package:ipackage/modules/Offer/Transportations/MinTransportation.dart';

class TransportationMethods {
  List<MinTransportation> defaultTrans;
  List<MinTransportation> additionalTrans;


  TransportationMethods({
    this.defaultTrans,
    this.additionalTrans,
  });

  factory TransportationMethods.fromJson(Map<String, dynamic> json) {

    if(json.containsKey('min_transportation') && json.containsKey('transportation'))
      {
        print('Full object used !');
        var list = json['min_transportation'] as List;
        List<MinTransportation> mtList = list.map((e) => MinTransportation.fromJson(e) ?? new MinTransportation()).toList();

        var list2 = json['transportation'] as List;
        List<MinTransportation> tList = list2.map((e) => MinTransportation.fromJson(e) ?? new MinTransportation()).toList();


        return TransportationMethods(
          defaultTrans: mtList,
          additionalTrans: tList,
        );
      }
    else
      {
        print('Empty object used !');

        List<MinTransportation> mtList = [];
        List<MinTransportation> tList = [];

        return TransportationMethods(
          defaultTrans: mtList,
          additionalTrans: tList,
        );
      }


  }

  List mtToJson(List<MinTransportation> list) {
    List jsonList = [];
    if(list != null)
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['min_transportation'] = mtToJson(this.defaultTrans);
    data['transportation'] = mtToJson(this.additionalTrans);

    return data;
  }
}
