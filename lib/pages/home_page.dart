import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hrythm/widgets/image_tile.dart';

class HomePage extends StatefulWidget {
  final Function(bool) afterScrollResult; //this is the custom function for scroll event callback
  const HomePage({super.key, required this.afterScrollResult});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
        if(_isVisible){
          _isVisible = false;
          widget.afterScrollResult(false);
        }
      }
      if(_scrollController.position.userScrollDirection == ScrollDirection.forward){
        if(!_isVisible){
          _isVisible = true;
          widget.afterScrollResult(true);
        }
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Container(height: 50, width: 50,decoration: BoxDecoration(color: Colors.grey,shape: BoxShape.circle),),
                bottom: TabBar(tabs: [
                  Tab(text: 'Suggested',),
                  Tab(text: 'Liked',),
                  Tab(text: 'Library',),
                ],
                  indicatorColor: Colors.red,
                  indicatorWeight: 4,
                ),
                 floating: true,
                 snap: true,
                // expandedHeight: 200,
                // flexibleSpace: FlexibleSpaceBar(
                //   background: Image.network(
                //     'https://picsum.photos/500/500?random=1',
                //     fit: BoxFit.cover,
                //   ),
                // ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              //Tab-1

             MasonryGridView.count(
              crossAxisCount: 2,//columns
              mainAxisSpacing: 12, //padding horizontal
              crossAxisSpacing: 12, //padding vertical
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return ImageTile(
                  index: index,
                  imageSource: 'https://picsum.photos/500/500?random=$index',
                  extent: (index % 2) ==0 ? 300 : 150, //item size
                );
              },
            ),
              //Tab-2
              SizedBox(),

              //Tab -3
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

