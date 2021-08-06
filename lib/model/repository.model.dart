class Repository {
  final String htmlUrl;
  final int watchersCount;
  final String language;
  final String description;
  final String name;
  final String owner;


  Repository({
      this.htmlUrl,
      this.watchersCount,
      this.language,
      this.description,
      this.name,
      this.owner});

  factory Repository.fromJson(Map<String, dynamic> json) => new Repository(
      htmlUrl : json['htmlUrl'],
      watchersCount : json['watchersCount'],
      language : json['language'],
      description : json['description'],
      name : json['name'],
      owner : json['owner']
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['htmlUrl'] = this.htmlUrl;
    data['watchersCount'] = this.watchersCount;
    data['language'] = this.language;
    data['description'] = this.description;
    data['name'] = this.name;
    data['owner'] = this.owner;
    return data;
  }
}