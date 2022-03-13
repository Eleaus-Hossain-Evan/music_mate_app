import 'package:flutter/material.dart';
import 'package:music_mates_app/core/model/artist.dart';
import 'package:music_mates_app/music_mates/presentation/widgets/export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    const backgroundColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: backgroundColor,
        title: const Text("Music Mates"),
      ),
      body: SafeArea(
        child: SizedBox(
          height: height * 0.6,
          width: size.width,
          child: const MatesConnect(),
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.all(8),
        height: height * 0.3,
        width: size.width,
        child: const _MyFavouriteListView(),
      ),
    );
  }
}

class _MyFavouriteListView extends StatelessWidget {
  const _MyFavouriteListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouriteArtist = [
      ArtistModel.dummy(),
      ArtistModel.dummy(),
      ArtistModel.dummy(),
      ArtistModel.dummy(),
    ];

    return ListView.builder(
      itemBuilder: (c, index) => ItemArtist(
        artist: favouriteArtist[index],
      ),
      scrollDirection: Axis.horizontal,
      itemCount: favouriteArtist.length,
      physics: const BouncingScrollPhysics(),
    );
  }
}
