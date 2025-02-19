import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MusicView extends StatefulWidget {
  const MusicView({Key? key}) : super(key: key);

  @override
  _MusicViewState createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {
  String selectedTag = "All";

  /// 🔹 Fetch music from Firestore (with optional tag filter)
  Stream<QuerySnapshot> fetchMusic() {
    if (selectedTag == "All") {
      return FirebaseFirestore.instance.collection('musics').snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('musics')
          .where('tags', arrayContains: selectedTag)
          .snapshots();
    }
  }

  /// ✅ List of available tags for filtering
  final List<String> tags = ["All", "Pop", "Rock", "Jazz", "2023", "2022", "2021"];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Music'),
      ),
      child: SafeArea( // ✅ Ensures content stays below navigation bar
        child: Column(
          children: [
            /// 🔹 Tag Filter Buttons
            Container(
              height: 90,
              color: CupertinoColors.systemGrey6,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: CupertinoButton(
                      color: selectedTag == tag
                          ? CupertinoColors.systemRed
                          : CupertinoColors.systemGrey,
                      onPressed: () {
                        setState(() {
                          selectedTag = tag;
                        });
                        print("Selected Tag (on tap): $selectedTag");
                      },
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// ✅ Divider
            Container(
              height: 1,
              color: CupertinoColors.systemGrey4,
            ),

            /// 🔹 Music List from Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: fetchMusic(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No music found.'));
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoListTile(
                          title: Text(data['title']),
                          subtitle: Text('${data['artist']} • ${data['duration']}'),
                          trailing: Text(data['tags'].join(", ")),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
