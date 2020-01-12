import 'package:flutter/material.dart';
import 'package:quest_world/blocks/quests_block.dart';
import 'package:quest_world/ui/base_widgets/appbar_wrapper.dart';
import 'package:quest_world/ui/main_screen.dart';

import '../quests_tab.dart';

class ScaffoldWrapper extends StatefulWidget {
  final appBar;
  final child;
  final bottomNavigationBar;
  final initialTabName;

  ScaffoldWrapper(
      {this.appBar, this.child, this.bottomNavigationBar, this.initialTabName});

  @override
  State<StatefulWidget> createState() => _ScaffoldWrapperState();
}

class _ScaffoldWrapperState extends State<ScaffoldWrapper>
    with SingleTickerProviderStateMixin {
  var child;
  var bottomNavigationBar;
  var initialDrawerTab;
  var controller;
  final tabsLength = 3;
  bool needInit;

  @override
  void initState() {
    super.initState();
    child = widget.child;
    bottomNavigationBar = widget.bottomNavigationBar;
    needInit = widget.initialTabName != null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!needInit)
      return;

    controller = TabController(vsync: this, length: tabsLength);
    final mainTab = MainScreen(
      controller: controller,
    );
    final bottomBar = Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          controller: mainTab.controller,
          tabs: <Tab>[
            Tab(text: "Active"),
            Tab(text: "Completed"),
            Tab(text: "Interrupted")
          ],
        ));
    initialDrawerTab = widget.initialTabName == "Main"
        ? Scaffold(
            appBar: widget.appBar ?? AppBarWrapper(),
            body: SafeArea(
              child: mainTab,
            ),
            bottomNavigationBar: bottomBar,
            drawer: buildDrawer(context),
          )
        : widget.initialTabName == "Available Quests"
            ? Scaffold(
                appBar: widget.appBar ?? AppBarWrapper(),
                body: SafeArea(
                  child: QuestsTab(
                    loadQuests: questsBlock.fetchAvailableQuests,
                    getQuestsStream: questsBlock.availableQuests,
                    title: "Available Quests",
                  ),
                ),
                bottomNavigationBar: null,
                drawer: buildDrawer(context),
              )
            : null;
  }

  @override
  Widget build(BuildContext context) {
    if (needInit) {
      needInit = false;
      child = initialDrawerTab;
      return initialDrawerTab;
    }
    else {
      return Scaffold(
        appBar: widget.appBar ?? AppBarWrapper(),
        body: SafeArea(
          child: child,
        ),
        bottomNavigationBar: bottomNavigationBar,
        drawer: buildDrawer(context),
      );
    }
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
                child: Text(
              "Quest world",
              style: Theme.of(context).textTheme.headline,
            )),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text(
              "My Profile",
              style: Theme.of(context).textTheme.title,
            ),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text(
              "My Quests",
              style: Theme.of(context).textTheme.title,
            ),
            leading: Icon(Icons.done_outline),
            onTap: () => setState(() {
              child = MainScreen(controller: controller,);
              bottomNavigationBar = Material(
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    controller: child.controller,
                    tabs: <Tab>[
                      Tab(text: "Active"),
                      Tab(text: "Completed"),
                      Tab(text: "Interrupted")
                    ],
                  ));
              Navigator.pop(context);
            }),
          ),
          ListTile(
            title: Text(
              "All Quests",
              style: Theme.of(context).textTheme.title,
            ),
            leading: Icon(Icons.grid_on),
            onTap: () => setState(() {
              child = QuestsTab(
                loadQuests: questsBlock.fetchAvailableQuests,
                getQuestsStream: questsBlock.availableQuests,
                title: "Available Quests",
              );
              bottomNavigationBar = null;
              Navigator.pop(context);
            }),
          )
        ],
      ),
    );
  }
}
