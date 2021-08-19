import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:movies_app_assignment_1828194/models/movieModel.dart';
import 'package:movies_app_assignment_1828194/widgets/alertDialog.dart';

import '../boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void dispose() {
    //  Hive.close();
    //  super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        leading: new IconButton(icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => 
          Navigator.of(context).pop(),
        ), 
        title: Text("Movies"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Movies>>(
        valueListenable: Boxes.getMovies().listenable(),
        builder: (context, box, _) {
          final movies = box.values.toList().cast<Movies>();

          return buildContent(movies);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
              context: context,
              builder: (context) => CustomDialog(
                    onClick: addMovies,
                  ))),
    );
  }

  Widget buildContent(List<Movies> movies) {
    if (movies.isEmpty) {
      return Stack(children: <Widget>[
        Image.asset(
          'assets/images/Loading.png',
        ),
        Center(
          child: Text(
            'Add New Movies Here!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ]);
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Favourites',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = movies[index];

                return buildmovies(context, movie);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildmovies(BuildContext context, Movies movie) {
    final date = DateFormat.yMMMd().format(movie.createdDate);

    // return Card(
    //   color: Colors.white,
    //   child: ExpansionTile(
    //     tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    //     title: Text(
    //       movie.name,
    //       maxLines: 2,
    //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    //     ),
    //     subtitle: Text(date),
    //     trailing: Text(
    //       movie.director,
    //       style: TextStyle(
    //           color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
    //     ),
    //     children: [
    //       buildButtons(context, movie),
    //     ],
    //   ),
    // );

    // return Card(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    //   clipBehavior: Clip.antiAlias,
    //   child: Stack(
    //     children: [
    //       Ink.image(
    //           image: NetworkImage(movie.posterUrl),
    //           height: 240,
    //           child: InkWell(onTap: () {}),
    //           fit: BoxFit.contain),
    //       Divider(color: Colors.black,),
    //       Container(
    //           child: Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             SizedBox(
    //               height: 80,
    //             ),
    //             Text(
    //               movie.name,
    //               maxLines: 2,
    //               style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 24,
    //                   color: Colors.white),
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Text(
    //               movie.director,
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 20),
    //             ),
    //           ],
    //         ),
    //       )),
    //       buildButtons(context, movie),
    //     ],
    //   ),
    // );

    return Container(
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Ink.image(
                    image: NetworkImage(movie.posterUrl),
                    height: 240,
                    child: InkWell(onTap: () {}),
                    fit: BoxFit.cover),
                Container(
                  height: 240,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 80,
                          // ),
                          Text(
                            "Movie: ${movie.name}",
                            style: TextStyle(
                                
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.black),
                          ),
                          Text(
                            "Director: ${movie.director}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ]),
                  ),
                  
                  //  Align(
                  //    alignment: Alignment.bottomRight,
                  //    child: Text(
                  //       date,
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16),
                  //     ),
                  //  ),
                  
                ],
              ),
            ),
          ),
          buildButtons(context, movie),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );

    // buildButtons(context, movie),
  }

  Widget buildButtons(BuildContext context, Movies movie) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CustomDialog(
                    moviesList: movie,
                    onClick: (name, director, posterUrl) =>
                        editmovies(movie, name, director, posterUrl),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: () => deletemovies(movie),
            ),
          )
        ],
      );

  Future addMovies(
    String name,
    String director,
    String posterUrl,
  ) async {
    final movie = Movies()
      ..name = name
      ..createdDate = DateTime.now()
      ..director = director
      ..posterUrl = posterUrl;

    final box = Boxes.getMovies();
    box.add(movie);
    //box.put('mykey', transaction);
  }

  void editmovies(
    Movies movies,
    String name,
    String director,
    String posterUrl,
  ) {
    movies.name = name;
    movies.director = director;
    movies.posterUrl = posterUrl;

    movies.save();
  }

  void deletemovies(Movies movies) {
    movies.delete();
  }
}
