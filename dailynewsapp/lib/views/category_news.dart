import 'package:flutter/material.dart';
import 'package:dailynewsapp/helper/news.dart';
import 'package:dailynewsapp/models/article_model.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  static const _adUnitID = "ca-app-pub-1780263275462931/1261822349";
  final _controller = NativeAdmobController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black12,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Daily News",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              Text("App", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
                color: Colors.red,
              ),)
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _loading ? Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ) :  SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),

            child: Column(
              children: <Widget>[
                Container(
                  height: 250,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: NativeAdmob(
                    adUnitID: _adUnitID,
                    controller: _controller,
                  ),
                ),

                /// Blogs
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                          url: articles[index].url,
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  class BlogTile extends StatelessWidget {
      final String imageUrl, title, desc , url;
       BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});
       @override
  Widget build(BuildContext context) {
  return GestureDetector(
  onTap: (){
  Navigator.push(context, MaterialPageRoute(
  builder: (context) => ArticleView(
  blogUrl: url,
  )
  ));
  },
  child: Container(
  margin: EdgeInsets.only(bottom: 16),
  child: Column(
  children: <Widget>[
  ClipRRect(
  borderRadius: BorderRadius.circular(6),
  child: Image.network(imageUrl)),
  SizedBox(height: 8,),
  Text(title, style: TextStyle(
  fontSize: 18,
  color: Colors.black87,
  fontWeight: FontWeight.w500
  ),),
  SizedBox(height: 8,),
  Text(desc, style: TextStyle(
  color: Colors.black54,
  ),)
  ],
  ),
  ),
  );
  }
  }