import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabbedScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TabbedScreen extends StatefulWidget {
  @override
  _TabbedScreenState createState() => _TabbedScreenState();
}

class _TabbedScreenState extends State<TabbedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    PageWidget(1, Colors.green),
    PageWidget(2, Colors.red),
    PageWidget(3, Colors.yellow),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'App Drawer',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Page 1'),
              onTap: () {
                _tabController.animateTo(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Page 2'),
              onTap: () {
                _tabController.animateTo(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Page 3'),
              onTap: () {
                _tabController.animateTo(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _tabController.animateTo(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Page 3',
          ),
        ],
      ),
    );
  }
}

class PageWidget extends StatelessWidget {
  final int pageNumber;
  final Color color;

  PageWidget(this.pageNumber, this.color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: color,
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text(
          'Page $pageNumber',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
