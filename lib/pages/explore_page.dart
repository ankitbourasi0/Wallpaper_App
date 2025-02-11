import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hrythm/widgets/image_tile.dart';

const double kImageSliderHeight = 320;
class ExplorePage extends StatefulWidget {

  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  var _selectedSlideIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
        if(_isVisible && _scrollController.position.pixels >= kImageSliderHeight){
          setState(() {
            _isVisible = false;
          });
        }
      }
      if(_scrollController.position.userScrollDirection == ScrollDirection.forward){
        if(!_isVisible){
          setState(() {
            _isVisible = true;
          });
        }
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isVisible ?Colors.black :Colors.white,
        body: SafeArea(
          top: !_isVisible,//depend upon the notch
          child: NestedScrollView(
            controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
          //return multiple sliver
          return [
            //Image Slider
            SliverAppBar(
              expandedHeight: kImageSliderHeight,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  PageView.builder(
                    //PageView is a widget that allows you to swipe left and right to navigate between pages
                    //below function is called when the page is changed, and it update the variable with the current index
                    onPageChanged: (index) {
                      setState(() {
                        _selectedSlideIndex = index;
                      });
                    },
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Stack(
                          fit: StackFit.expand, //fill the padding of horizontal
                          children: [
                            //Image
                            CachedNetworkImage(
                              imageUrl:
                                  'https://picsum.photos/500/500?random=slide_$index',
                              fit: BoxFit.cover,
                            ),
                            //Gradient eFFECT
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black,
                                      Colors.transparent,
                                    ],
                                    stops: [
                                      0.01,
                                      1
                                    ] //0.01 is the start of the gradient , and 1 is the end of the gradient, each values matches the color position
                                    ),
                              ),
                            ),
                          ]);
                    },
                  ),
                  //indicators
                  Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Wrap(
                        alignment: WrapAlignment.center, //center the children
                        children: List.generate(5, (index) {
                          //these are the indicators dots
                          //we can convert any container to Animated Container only thingis Animated Container has duration property which is required
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 10, height: 10, margin: EdgeInsets.symmetric(horizontal: 8),decoration: BoxDecoration(color: index==_selectedSlideIndex? Colors.white: Colors.grey,shape: BoxShape.circle),);
                        }),
                      )),
                ]),
                // Image.network('https://picsum.photos/500/500?random=1',fit: BoxFit.cover,),
              ),
            ),
            //Search Button
            //MediaQuery.removePadding is used to remove the padding
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: SliverAppBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12))), //rounded corners
                floating: true,
                snap: true,
                backgroundColor: _isVisible ? Colors.white : Colors.white.withOpacity(0.95),
                title: TextButton.icon(onPressed: (){}, label: Text("Search"), icon:Icon(Icons.search_outlined),style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.black),iconSize: WidgetStatePropertyAll(24),textStyle: WidgetStatePropertyAll((TextStyle(fontSize: 20)))),),
              ),
            ),
          ];
                },
                body: Container(
          color: Colors.white,
          child: MasonryGridView.count(
            crossAxisCount: 2, //columns
            mainAxisSpacing: 12, //padding horizontal
            crossAxisSpacing: 12, //padding vertical
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              return ImageTile(
                index: index,
                imageSource: 'https://picsum.photos/500/500?random=trend_$index',
                extent: (index % 2) == 0 ? 300 : 150, //item size
              );
            },
          ),
                ),
              ),
        ));
  }
}
