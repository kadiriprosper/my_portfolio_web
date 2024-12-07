class ProjectModel {
  ProjectModel({
    required this.projectName,
    required this.projectDescription,
    required this.imgUrl,
    required this.url,
    required this.techImgUrlList,
  });

  String projectName;
  String projectDescription;
  String imgUrl;
  String url;
  List<String> techImgUrlList = [];

  factory ProjectModel.fromStorageMap(Map<String, dynamic> data) {
    final imgData = data['techImageList'];
    final tempArray = <String>[];
    for (int i = 0; i < imgData.length; i++) {
      tempArray.add(imgData[i]);
    }
    
    return ProjectModel(
      projectName: data['projectName'],
      projectDescription: data['projectDescription'],
      imgUrl: data['imgUrl'],
      url: data['url'],
      techImgUrlList: tempArray,
    );
  }

  Map<String, dynamic> toStorageMap() {
    return {
      'projectName': projectName,
      'projectDescription': projectDescription,
      'techImageList': techImgUrlList,
      'imgUrl': imgUrl,
      'url': url,
    };
  }
}
