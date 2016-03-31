import 'package:flutter/material.dart';

import 'drawer.dart';

void main() {
  runApp(
    new FlutterDemoApp()
  );
}

class FlutterDemoApp extends StatefulWidget {
  @override
  FlutterDemoAppState createState() => new FlutterDemoAppState();

  static FlutterDemoAppState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<FlutterDemoAppState>());
}

class FlutterDemoAppState extends State<FlutterDemoApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: lightTheme ? new ThemeData.light() : new ThemeData.dark(),
      title: 'Advanced Layout',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new FlutterDemo(),
      }
    );
  }

  bool _lightTheme = true;
  bool get lightTheme => _lightTheme;
  void set lightTheme(bool value) {
    setState(() {
      _lightTheme = value;
    });
  }
}

class FlutterDemo extends StatefulWidget {
  FlutterDemo({ Key key }) : super(key: key);

  @override
  FlutterDemoState createState() => new FlutterDemoState();

  static FlutterDemoState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<FlutterDemoState>());

}

class FlutterDemoState extends State<FlutterDemo> {


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Advanced Layout'),
        actions: <Widget>[
          new IconButton(
            icon: Icons.create,
            tooltip: 'Search',
            onPressed: () {
              print("Pressed search");
            }
          ),
          new TopBarMenu()
        ]
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ScrollableMixedWidgetList(
              builder: (BuildContext context, int index) {
                print("Building index: $index");
                return new FancyItem(index, key: new ValueKey("Item $index"));
              }
            )
          ),
          new BottomBar()
        ]
      ),
      drawer: new GalleryDrawer()
    );
  }
}

class TopBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton<String>(
      onSelected: (String value) { print("Selected: $value"); },
      items: <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
          value: "Friends",
          child: new MenuItemWithIcon(Icons.people, "Friends", "5 new")
        ),
        new PopupMenuItem<String>(
          value: "Events",
          child: new MenuItemWithIcon(Icons.event, "Events", "12 upcoming")
        ),
        new PopupMenuItem<String>(
          value: "Events",
          child: new MenuItemWithIcon(Icons.group, "Groups", "14")
        ),
        new PopupMenuItem<String>(
          value: "Events",
          child: new MenuItemWithIcon(Icons.image, "Pictures", "12")
        ),
        new PopupMenuItem<String>(
          value: "Events",
          child: new MenuItemWithIcon(Icons.near_me, "Nearby", "33")
        ),
        new PopupMenuItem<String>(
          value: "Friends",
          child: new MenuItemWithIcon(Icons.people, "Friends", "5")
        ),
        new PopupMenuItem<String>(
          value: "Events",
          child: new MenuItemWithIcon(Icons.event, "Events", "12")
        ),
        new PopupMenuItem<String>(
          value: "Events",
          child: new MenuItemWithIcon(Icons.group, "Groups", "14")
        ),
        new PopupMenuItem<String>(
          value: "Events",
          child: new MenuItemWithIcon(Icons.image, "Pictures", "12")
        ),
        new PopupMenuItem<String>(
          value: "Events",
          child: new MenuItemWithIcon(Icons.near_me, "Nearby", "33")
        )
      ]
    );
  }
}

class MenuItemWithIcon extends StatelessWidget {

  MenuItemWithIcon(this.icon, this.title, this.subtitle);

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Icon(icon: icon),
        new Padding(
          padding: new EdgeInsets.only(left: 8.0, right: 8.0),
          child: new Text(title)
        ),
        new Text(subtitle, style: Theme.of(context).textTheme.caption)
      ]
    );
  }
}

class FancyItem extends StatelessWidget {

  FancyItem(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return new BlockBody(
      children: <Widget>[
        new UserHeader("Ali Connors $index"),
        new ItemDescription(),
        new ItemImageBox(),
        new InfoBar(),
        new Padding(
          padding: new EdgeInsets.symmetric(horizontal: 8.0),
          child: new Divider()
        ),
        new IconBar(),
        new FatDivider()
      ]
    );
  }
}

class InfoBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new MiniIconWithText(Icons.thumb_up, "42"),
          new Text("3 Comments", style: Theme.of(context).textTheme.caption)
        ]
      )
    );
  }
}

class IconBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, right: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new IconWithText(Icons.thumb_up, "Like"),
          new IconWithText(Icons.comment, "Comment"),
          new IconWithText(Icons.share, "Share"),
        ]
      )
    );
  }
}

class IconWithText extends StatelessWidget {

  IconWithText(this.icon, this.title);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.collapse,
      children: <Widget>[
        new IconButton(icon: icon, onPressed: () { print("Pressed $title button"); } ),
        new Text(title)
      ]
    );
  }
}

class MiniIconWithText extends StatelessWidget {
  MiniIconWithText(this.icon, this.title);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.collapse,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.only(right: 8.0),
          child: new Container(
            width: 16.0,
            height: 16.0,
            decoration: new BoxDecoration(
              backgroundColor: Theme.of(context).primaryColor,
              shape: BoxShape.circle
            ),
            child: new Icon(icon: icon, color: Colors.white, size: 12.0)
          )
        ),
        new Text(title, style: Theme.of(context).textTheme.caption)
      ]
    );
  }
}

class FatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 8.0,
      decoration: new BoxDecoration(
        backgroundColor: Theme.of(context).dividerColor
      )
    );
  }
}

class UserHeader extends StatelessWidget {
  UserHeader(this.userName);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(right: 8.0),
            child: new NetworkImage(
              src: "https://yt3.ggpht.com/-QoRtW1blwNI/AAAAAAAAAAI/AAAAAAAAAAA/64mFGTnb5H4/s88-c-k-no/photo.jpg",
              width: 32.0,
              height: 32.0
            )
          ),
          new Flexible(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new RichText(text: new TextSpan(
                  style: Theme.of(context).textTheme.body1,
                  children: <TextSpan>[
                    new TextSpan(text: userName, style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(text: " shared a new "),
                    new TextSpan(text: "photo", style: new TextStyle(fontWeight: FontWeight.bold))
                  ]
                )),
                new Row(
                  children: <Widget>[
                    new Text("Yesterday at 11:55 • ", style: Theme.of(context).textTheme.caption),
                    new Icon(icon: Icons.people, size: 16.0, color: Theme.of(context).textTheme.caption.color)
                  ]
                )
              ]
            )
          ),
          new TopBarMenu()
        ]
      )
    );
  }
}

class ItemDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    );
  }
}

class ItemImageBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Card(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new SizedBox(
                  height: 230.0,
                  child: new NetworkImage(
                    src: "http://s1.favim.com/orig/16/beautiful-blue-nature-night-purple-Favim.com-191864.jpg"
                  )
                ),
                new Theme(
                  data: new ThemeData.dark(),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new IconButton(icon: Icons.edit, onPressed: () { print("Pressed edit button"); }),
                      new IconButton(icon: Icons.zoom_in, onPressed: () { print("Pressed zoom button"); })
                    ]
                  )
                ),
                new Positioned(
                  bottom: 4.0,
                  left: 4.0,
                  child: new Container(
                    decoration: new BoxDecoration(
                      backgroundColor: Colors.black54,
                      borderRadius: 2.0
                    ),
                    padding: new EdgeInsets.all(4.0),
                    child: new RichText(
                      text: new TextSpan(
                        style: new TextStyle(color: Colors.white),
                        children: <TextSpan>[
                          new TextSpan(
                            text: "Photo by "
                          ),
                          new TextSpan(
                            style: new TextStyle(fontWeight: FontWeight.bold),
                            text: "Magic Mike"
                          )
                        ]
                      )
                    )
                  )
                )
              ]
            )
            ,
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Text("Where can you find that amazing sunset?", style: Theme.of(context).textTheme.body2),
                  new Text("The sun sets over stinson beach", style: Theme.of(context).textTheme.body1),
                  new Text("flutter.io/amazingsunsets", style: Theme.of(context).textTheme.caption)
                ]
              )
            )
          ]
        )
      )
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        border: new Border(
          top: new BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1.0
          )
        )
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new BottomBarButton(Icons.new_releases, "News"),
          new BottomBarButton(Icons.people, "Requests"),
          new BottomBarButton(Icons.chat, "Messenger"),
          new BottomBarButton(Icons.bookmark, "Bookmark"),
          new BottomBarButton(Icons.alarm, "Alarm")
        ]
      )
    );
  }
}

class BottomBarButton extends StatelessWidget {

  BottomBarButton(this.icon, this.title);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[
          new IconButton(
            icon: icon,
            onPressed: () { print("Pressed: $title"); }
          ),
          new Text(title, style: Theme.of(context).textTheme.caption)
        ]
      )
    );
  }
}
