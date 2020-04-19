import 'package:dailynewsapp/views/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dailynewsapp/helper/data.dart';
import 'package:dailynewsapp/helper/news.dart';
import 'package:dailynewsapp/models/article_model.dart';
import 'package:dailynewsapp/models/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dailynewsapp/views/article_view.dart';
import 'package:dailynewsapp/views/category_news.dart';
import 'package:dailynewsapp/navigationDrawrer.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';


const String testDevice='501F3CA537EC83DB';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  static final MobileAdTargetingInfo targetInfo =new MobileAdTargetingInfo(
      testDevices: testDevice!=null?<String>[testDevice]:null,
    childDirected: true,);
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;


  static const _adUnitID = "ca-app-pub-1780263275462931/1261822349";
  final _controller = NativeAdmobController();


  BannerAd createBannerAd(){
    return new BannerAd(
        adUnitId: "ca-app-pub-1780263275462931/4956157796",
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event){
          print("Banner event : $event");
        }
    );
  }

  InterstitialAd createInterstitialAd(){
    return new InterstitialAd(
        adUnitId: "ca-app-pub-1780263275462931/6077667778",
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event){
          print("Interstitial event : $event");
        }
    );
  }

  List<CategoryModel> categories=new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategory();
    getNews();
    FirebaseAdMob.instance.initialize(appId:"ca-app-pub-1780263275462931~5835492178");
    _bannerAd= createBannerAd()
      ..load()
      ..show();
  }
  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.perm_identity,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) => UserData()));})
              // do something
            ],
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: NavigationDrawer(),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
          child: Column(
            children: <Widget>[
              /// Categories
              Container(
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                    }),
              ),
              Container(
                height: 180,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 20.0),
                child: NativeAdmob(
                  adUnitID: _adUnitID,
                  controller: _controller,
                ),
              ),
              /// Blogs
              Container(
                padding: EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url,
                    );
                    }),
              ),
              Container(
                height: 330,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 20.0),
                child: NativeAdmob(
                  adUnitID: _adUnitID,
                  controller: _controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CategoryTile extends StatelessWidget {
  final String imageUrl,categoryName;
  CategoryTile({this.imageUrl,this.categoryName});

  static final MobileAdTargetingInfo targetInfo =new MobileAdTargetingInfo(
    testDevices: testDevice!=null?<String>[testDevice]:null,);

  InterstitialAd createInterstitialAd(){
    return new InterstitialAd(
        adUnitId: "ca-app-pub-1780263275462931/6077667778",
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event){
          print("Interstitial event : $event");
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        createInterstitialAd()..load()..show();
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName.toLowerCase(),
            )
          ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: imageUrl, width: 120,height: 60, fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),),
            )
          ],
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


