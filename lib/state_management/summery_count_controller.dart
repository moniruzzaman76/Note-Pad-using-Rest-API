import 'package:get/get.dart';
import '../data/Utils/urls.dart';
import '../data/model/summery_count_model.dart';
import '../data/service/network_coller.dart';
import '../data/service/network_response.dart';

class SummeryCountController extends GetxController{

  bool _getCountSummaryInProgress = false;
  SummeryCountModel _summeryCountModel = SummeryCountModel();

  bool get getCountSummaryInProgress => _getCountSummaryInProgress;
    SummeryCountModel get summaryCountModel => _summeryCountModel;

  Future<bool> getSummeryCount() async {
    _getCountSummaryInProgress = true;
    update();

    final NetworkResponse response = await NetWorkCaller().getRequest(Urls.taskStatusCount);
    _getCountSummaryInProgress = false;
     update();

    if (response.isSuccess) {
      _summeryCountModel = SummeryCountModel.fromJson(response.body!);
      update();
      return true;
    } else {
      return false;
      }
    }
  }


