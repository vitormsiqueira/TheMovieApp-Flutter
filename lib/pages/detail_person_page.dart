import 'package:flutter/material.dart';
import 'package:the_movie_app/controllers/person_detail_controller.dart';
import 'package:the_movie_app/core/constants.dart';
import 'package:the_movie_app/models/person_model.dart';
import 'package:the_movie_app/widgets/build_image_poster.dart';

class DetailPersonPage extends StatefulWidget {
  final int personId;
  const DetailPersonPage(this.personId, {Key? key}) : super(key: key);

  @override
  _DetailPersonPageState createState() => _DetailPersonPageState();
}

class _DetailPersonPageState extends State<DetailPersonPage> {
  final _controllerPerson = PersonDetailController();
  double largImage = 150;
  double marginImage = 20;
  double alturaImagem = 220;

  @override
  void initState() {
    super.initState();
    _initializePerson();
  }

  _initializePerson() async {
    setState(() {
      _controllerPerson.loading = true;
    });

    await _controllerPerson.fetchPersonById(widget.personId);

    setState(() {
      _controllerPerson.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String personName = _controllerPerson.personDetail?.name ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(personName.toString()),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: _buildBodyPersonDetail(),
    );
  }

  Widget _buildBodyPersonDetail() {
    final person = _controllerPerson.personDetail;
    if (_controllerPerson.loading) {
      return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              _buildImage(context, person),
              _buildbiography(person),
            ],
          ),
        ],
      ),
    );
  }

  _buildImage(BuildContext context, PersonDetail? _person) {
    final personPath = _person?.profilePath;
    final pathImage = personPath ?? urlAlternative;
    final urlPoster = '$urlPoster400$pathImage';

    return Container(
      child: buildImagePoster(urlPoster,
          larg: largImage, altura: alturaImagem, margin: marginImage),
    );
  }

  _buildbiography(PersonDetail? _person) {
    final personBiography = _person?.biography;

    return Container(
      padding: const EdgeInsets.only(right: 20),
      height: alturaImagem,
      width: MediaQuery.of(context).size.width - largImage - (marginImage * 2),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "Biografia",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: alturaImagem - 50,
            child: Text(
              '$personBiography',
              textAlign: TextAlign.justify,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12.0,
                letterSpacing: 0.2,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
