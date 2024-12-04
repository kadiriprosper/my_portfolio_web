import 'package:get/get.dart';
import 'package:my_portfolio_web/model/article_model.dart';
import 'package:my_portfolio_web/model/data_model.dart';
import 'package:my_portfolio_web/model/message_model.dart';
import 'package:my_portfolio_web/model/project_model.dart';

final dataController = Get.put(
  DataController(),
  permanent: true,
);

class DataController extends GetxController {
  RxList<ProjectModel> projects = <ProjectModel>[].obs;
  RxList<ArticleModel> articles = <ArticleModel>[].obs;
  DataModel dataModel = DataModel();

  Future<void> getProject() async {
    projects = <ProjectModel>[].obs;
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
  }

  Future<void> getArticles() async {
    articles = <ArticleModel>[].obs;
    final resp = await dataModel.getData(path: 'projects', docId: 'articles');

    if (resp.entries.first.key == AccessCondition.good) {
      for (int i = 0;
          i < (resp[AccessCondition.good]['articles']).length;
          i++) {
        articles.add(
          ArticleModel.fromStorageMap(
            resp[AccessCondition.good]['articles'][i],
          ),
        );
      }
    }
  }

  Future<String?> uploadMessage(MessageModel message) async {
    final resp = await dataModel.uploadData(
      path: 'visitors',
      docId: 'messages',
      data: message.messageToMap(),
    );
    if (resp.entries.first.key == AccessCondition.good) {
      return null;
    } else {
      return 'error';
    }
  }
}
