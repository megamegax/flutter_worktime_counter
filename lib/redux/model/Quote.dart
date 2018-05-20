class Quote {
  String quote;
  String author;
  List<dynamic> tags;
  String category;
  String title;
  String date;

  Quote(
      {this.quote,
      this.author,
      this.category,
      this.date,
      this.tags,
      this.title});

  factory Quote.fromJson(Map<String, dynamic> json) {
    final contents = json['contents'];
    final content = contents['quotes'][0];

    return new Quote(
        author: content['author'],
        quote: content['quote'],
        category: content['category'],
        date: content['date'],
        tags: content['tags'],
        title: content['title']);
  }
}
