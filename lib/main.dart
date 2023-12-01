import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class Character {
  final String name;
  final String image;
  final String description;

  Character({required this.name, required this.image, required this.description});
}

class CharacterList extends StatelessWidget {
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Character> characters = Provider.of<List<Character>>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Genshin Impact Characters'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("pics/genshinbackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: characters == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            final character = characters[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FadeTransition(
                          opacity: animation,
                          child: CharacterDetails(character: character),
                        ),
                  ),
                );
              },
              child: Card(
                color: Colors.transparent,
                elevation: 8,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    character.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Hero(
                    tag: character.name,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: character.image,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CharacterDetails extends StatelessWidget {
  final Character character;

  const CharacterDetails({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Details'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("pics/details_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: character.name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: character.image,
                    width: 200,
                    height: 200,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black.withOpacity(0.7),
                child: Text(
                  character.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Character> characters = [
      Character(
        name: "Kamisato Ayaka",
        image: "https://www.ixpap.com/images/2021/08/Kamisato-Ayaka-Wallpapers.jpg",
        description: "She is in charge of the internal and external affairs of the Kamisato Clan and is the younger sister of Kamisato Ayato. Beautiful, dignified, and noble, Ayaka has earned the title Shirasagi Himegimi and is considered a model of perfection in Inazuma.",
      ),
      Character(
        name: "Furina",
        image: "https://c4.wallpaperflare.com/wallpaper/613/883/712/furina-focalors%EF%BC%88genshin-impact%EF%BC%89-genshin-impact-hd-wallpaper-preview.jpg",
        description: "Introduced as the flamboyant and overconfident Hydro Archon, Furina's theatrics are eventually revealed to be a public persona, which she later discards in favor of living a much humbler life.",
      ),
      Character(
        name: "Kaedehara Kazuha",
        image: "https://wallpaperaccess.com/full/6172136.jpg",
        description: "A wandering samurai of the once-famed Kaedehara Clan with an ability to read the sounds of nature, Kazuha is a temporary crewmember of The Crux. Despite being burdened by the many happenings of his past, Kazuha still maintains an easygoing disposition.",
      ),
      Character(
        name: "Sangonomiya Kokomi",
        image: "https://th.bing.com/th/id/OIP.DgucDbqZBwQJ-usmT5ZpUQHaNs?w=600&h=1109&rs=1&pid=ImgDetMain",
        description: "The young Divine Priestess of Watatsumi Island and a descendant of the Sangonomiya Clan, Kokomi is in charge of most of Watatsumi's affairs, shouldering heavy responsibilities alone in hopes for giving Watatsumi Island's people the hopes and happiness that they desire.",
      ),
      Character(
        name: "Cyno",
        image: "https://th.bing.com/th/id/OIP.NU932BagKULFOkyYIkieXAHaLi?rs=1&pid=ImgDetMain",
        description: "As the General Mahamatra, Cyno leads the Matra and strikes fear into the hearts of researchers of the Sumeru Akademiya. In spite of this, Cyno has a fun side outside of his role in the Akademiya, as he has an affinity for Genius Invokation TCG and constantly cracks unfunny jokes.",
      ),
      Character(
        name: "Diluc",
        image: "https://i.pinimg.com/736x/38/f0/9b/38f09b0bce77d0f0acc6bc85bb300969.jpg",
        description: "Born into the affluent Ragnvindr Clan, Diluc is the current owner of the Dawn Winery and a nobleman of high esteem in Mondstadt. While a past incident caused him to split ways with the Knights of Favonius, he continues to protect Mondstadt in his own way.",
      ),
      Character(
        name: "Charlotte",
        image: "https://th.bing.com/th/id/OIP.4wpB4RZLDuZYQvoyr1NyOAHaKt?rs=1&pid=ImgDetMain",
        description: "A journalist from The Steambird, Charlotte is always on the prowl for an exclusive scoop. Ever so relentless and indefatigable, she won't stop until she finds out the truth, even if she comes closer to danger.",
      ),
    ];

    return Provider(
      create: (context) => characters,
      child: MaterialApp(
        title: 'Genshin Impact Character Showcase',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const CharacterList(),
      ),
    );
  }
}
