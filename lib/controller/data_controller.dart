import 'package:get/get.dart';
import 'package:my_portfolio_web/model/data_model.dart';
import 'package:my_portfolio_web/model/project_model.dart';

class DataController extends GetxController {
  List<ProjectModel> projects = [];
  DataModel dataModel = DataModel();

  Future<void> getProject() async {
    final resp = await dataModel.getData(path: 'projects', docId: 'projects');

    if (resp.entries.first.key == AccessCondition.good) {
      for (int i = 0; i < (resp[AccessCondition.good]['apps']).length; i++) {
        projects.add(
          ProjectModel.fromStorageMap(
            resp[AccessCondition.good]['apps'][i],
          ),
        );
      }
    }
    print(projects);
  }
}
