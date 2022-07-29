import 'package:flutter/material.dart';
import 'package:newsapp/models/new_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatelessWidget {
  final List<Article> headlines;
  const NewsList({Key? key, required this.headlines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: headlines.length,
      itemBuilder: (BuildContext context, int index) {
        return _NewsTitle(
          headlines: headlines,
          index: index,
        );
      },
    );
  }
}

class _NewsTitle extends StatelessWidget {
  final List<Article> headlines;
  final int index;

  const _NewsTitle({
    required this.headlines,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(headlines[index].url);
        // await launchUrl(uri);
        if (!await launchUrl(uri)) {
          throw 'Could not launch $uri';
        }
      },
      child: Column(
        children: [
          _ImagesNews(headlines: headlines, index: index),
          _RowNew(headlines: headlines, index: index),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _TitleHeader(headlines: headlines, index: index),
          ),
          const SizedBox(height: 10),
          if (headlines[index].description != null &&
              headlines[index].description != '')
            _NewsContent(headlines: headlines, index: index),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class _NewsContent extends StatelessWidget {
  final List<Article> headlines;
  final int index;
  const _NewsContent({
    Key? key,
    required this.headlines,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      ),
      child: Container(
        //margin: EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0xff46A094),
        ),
        child: Text(
          headlines[index].description!,
          style: const TextStyle(fontSize: 17),
          textAlign: TextAlign.justify,
          overflow: TextOverflow.fade,
          maxLines: 15,
        ),
      ),
    );
  }
}

class _TitleHeader extends StatelessWidget {
  final List<Article> headlines;
  final int index;
  const _TitleHeader({
    Key? key,
    required this.headlines,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      headlines[index].title,
      overflow: TextOverflow.fade,
      maxLines: 5,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 20,
        color: Color(0xff6BBD99),
      ),
    );
  }
}

class _ImagesNews extends StatelessWidget {
  final List<Article> headlines;
  final int index;

  const _ImagesNews({
    Key? key,
    required this.headlines,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
        bottomRight: Radius.circular(50),
      ),
      child: Container(
        child: (headlines[index].urlToImage != null)
            ? FadeInImage(
                image: NetworkImage(headlines[index].urlToImage!),
                placeholder: const AssetImage('assets/giphy.gif'),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/no-image.png',
                    //fit: BoxFit.fitWidth,
                  );
                },
              )
            : const Image(
                image: AssetImage('assets/no-image.png'),
              ),
      ),
    );
  }
}

class _RowNew extends StatelessWidget {
  const _RowNew({
    Key? key,
    required this.headlines,
    required this.index,
  }) : super(key: key);

  final List<Article> headlines;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, right: 20, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            '${index + 1}',
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xffAECFA4),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              headlines[index].source.name,
              overflow: TextOverflow.fade,
              maxLines: 5,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xffAECFA4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
