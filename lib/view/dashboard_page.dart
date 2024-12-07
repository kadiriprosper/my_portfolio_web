import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_portfolio_web/controller/data_controller.dart';
import 'package:my_portfolio_web/model/article_model.dart';
import 'package:my_portfolio_web/model/message_model.dart';
import 'package:my_portfolio_web/model/project_model.dart';
import 'package:url_launcher/url_launcher.dart';

enum NavigationTitle {
  me,
  projects,
  articles,
  contact,
}

const techIconList = {
  'Dart': 'dart.svg',
  'Python': 'python.svg',
  'C#': 'chash.svg',
  'HTML': 'html.svg',
  'Flutter': 'flutter.svg',
  'Firebase': 'firebase.svg',
};

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> _getData() async {
    await dataController.getProject();
    await dataController.getArticles();
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return const LargeScreenDashboard();
          } else {
            return const SmallScreenDashboard();
          }
        },
      ),
    );
  }
}

class SmallScreenDashboard extends StatefulWidget {
  const SmallScreenDashboard({super.key});

  @override
  State<SmallScreenDashboard> createState() => _SmallScreenDashboardState();
}

class _SmallScreenDashboardState extends State<SmallScreenDashboard> {
  NavigationTitle currentPage = NavigationTitle.me;

  final aboutKey = GlobalKey();

  final projectsKey = GlobalKey();

  final articlesKey = GlobalKey();

  final contactKey = GlobalKey();

  ScrollController viewController = ScrollController();

  @override
  void initState() {
    viewController.addListener(highlightButton);
    super.initState();
  }

  void highlightButton() {
    setState(() {
      if ( //viewController.offset >= 0 &&
          viewController.offset < getOffset(projectsKey) - 110) {
        currentPage = NavigationTitle.me;
      } else if (
          //viewController.offset >= getOffset(projectsKey) &&
          viewController.offset < getOffset(articlesKey) - 110) {
        currentPage = NavigationTitle.projects;
      } else if (
          //viewController.offset >= getOffset(articlesKey) &&
          viewController.offset < getOffset(contactKey) - 200) {
        currentPage = NavigationTitle.articles;
      } else if (viewController.offset >= getOffset(contactKey) - 200) {
        currentPage = NavigationTitle.contact;
      }
    });
  }

  double getOffset(GlobalKey key) {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    final position = box.localToGlobal(
      Offset(0, viewController.offset),
    );
    return position.dy;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

      //TODO: Animated color box decor
      child: CustomScrollView(
        controller: viewController,
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            floating: true,
            snap: true,
            titleSpacing: 0,
            backgroundColor: Colors.black45,
            title: MaterialButton(
              onPressed: () {
                viewController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              height: Theme.of(context).appBarTheme.toolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Kadiri Ehijie'),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(14).copyWith(top: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.yellow.withOpacity(.8),
                              Colors.blue.withOpacity(.8),
                              Colors.white.withOpacity(.8),
                              Colors.green.withOpacity(.8),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // padding: const EdgeInsets.all(10),
                              constraints: const BoxConstraints(maxWidth: 300),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 300,
                                    decoration: const BoxDecoration(
                                      color: Colors.white10,
                                    ),
                                    child: Image.asset(
                                      'assets/pictures/img.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Kadiri Ehijie',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Container(
                        padding: const EdgeInsets.all(10).copyWith(bottom: 0),
                        constraints: const BoxConstraints(maxWidth: 620),
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            scrollbars: false,
                          ),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //About Container
                              SizedBox(
                                key: aboutKey,
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'ME',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white24,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'I\'m simply an adventurer with some programming languages in my toolbox',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white12,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    AutoSizeText.rich(
                                      TextSpan(
                                        text: 'Mobile App '.toUpperCase(),
                                        style: GoogleFonts.poppins().copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          height: 1,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Developer'.toUpperCase(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white54,
                                            ),
                                          )
                                        ],
                                      ),
                                      // maxLines: 2,
                                      minFontSize: 60,
                                      maxFontSize: 100,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            'Passionate about crafting innovative solutions that transforms ideas into a mobile experience.',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Colors.white60,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '\n\nWith an eye for detail and the command of the flutter framework, I enjoy taking diverse challenges either alone or alongside fellow team mates.',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '\n\nLet\'s connect to dicuss how I can be a part of your current or next adventure',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.white60,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Tool Box',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      runSpacing: 20,
                                      spacing: 20,
                                      children: List.generate(
                                        techIconList.length,
                                        (index) => CustomToolIcon(
                                          toolTip: techIconList.keys
                                              .elementAt(index),
                                          url:
                                              'assets/icons/${techIconList.values.elementAt(index)}',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              //Project Container
                              SizedBox(
                                key: projectsKey,
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 70),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText.rich(
                                            TextSpan(
                                              text: 'Recent'.toUpperCase(),
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                height: 1,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '\nProjects'
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white54,
                                                  ),
                                                )
                                              ],
                                            ),
                                            // maxLines: 2,
                                            minFontSize: 60,
                                            maxFontSize: 100,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),

                                      //TODO: The Project Container
                                      ...List.generate(
                                        dataController.projects.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: ProjectDetailButton(
                                            projectModel:
                                                dataController.projects[index],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //Articles
                              SizedBox(
                                key: articlesKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 70),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText.rich(
                                          TextSpan(
                                            text: 'Tech'.toUpperCase(),
                                            style:
                                                GoogleFonts.poppins().copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              height: 1,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '\nThoughts'.toUpperCase(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white54,
                                                ),
                                              )
                                            ],
                                          ),
                                          // maxLines: 2,
                                          minFontSize: 60,
                                          maxFontSize: 100,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                    ...List.generate(
                                      dataController.articles.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: ArticleDetailButton(
                                          articleModel:
                                              dataController.articles[index],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Contact
                              ContactSegment(
                                widgetKey: contactKey,
                                mobileView: true,
                              ),
                              const SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      try {
                                        await launchUrl(
                                          Uri.parse(
                                            'https://www.linkedin.com/in/ehijie-kadiri/',
                                          ),
                                          webOnlyWindowName: '_blank',
                                        );
                                      } catch (e) {
                                        //TODO: Show snackbar that tell error
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/linkedin.svg',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  IconButton(
                                    onPressed: () async {
                                      try {
                                        await launchUrl(
                                          Uri.parse(
                                            'https://github.com/kadiriprosper',
                                          ),
                                          webOnlyWindowName: '_blank',
                                        );
                                      } catch (_) {}
                                    },
                                    icon: const Icon(
                                      AntDesign.github_outline,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'An Ehijie adventure with ',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/flutter.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    AntDesign.copyright_outline,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateTime.now().year.toString(),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      try {
                                        await launchUrl(
                                          Uri.parse('https://www.craiyon.com/'),
                                        );
                                      } catch (_) {}
                                    },
                                    child: const Text(
                                      'Profile image generated from Craiyon',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white54),
                                    ),
                                  ),
                                ],
                              ),
                              // Container(
                              //   height: 50,
                              //   decoration: BoxDecoration(

                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LargeScreenDashboard extends StatefulWidget {
  const LargeScreenDashboard({super.key});

  @override
  State<LargeScreenDashboard> createState() => _LargeScreenDashboardState();
}

class _LargeScreenDashboardState extends State<LargeScreenDashboard> {
  NavigationTitle currentPage = NavigationTitle.me;

  final aboutKey = GlobalKey();

  final projectsKey = GlobalKey();

  final articlesKey = GlobalKey();

  final contactKey = GlobalKey();

  ScrollController viewController = ScrollController();

  @override
  void initState() {
    viewController.addListener(highlightButton);
    super.initState();
  }

  void highlightButton() {
    setState(() {
      if ( //viewController.offset >= 0 &&
          viewController.offset < getOffset(projectsKey) - 110) {
        currentPage = NavigationTitle.me;
      } else if (
          //viewController.offset >= getOffset(projectsKey) &&
          viewController.offset < getOffset(articlesKey) - 110) {
        currentPage = NavigationTitle.projects;
      } else if (
          //viewController.offset >= getOffset(articlesKey) &&
          viewController.offset < getOffset(contactKey) - 200) {
        currentPage = NavigationTitle.articles;
      } else if (viewController.offset >= getOffset(contactKey) - 200) {
        currentPage = NavigationTitle.contact;
      }
    });
  }

  double getOffset(GlobalKey key) {
    RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
    final position = box.localToGlobal(
      Offset(0, viewController.offset),
    );
    return position.dy;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(14).copyWith(top: 0, bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //This is a design container, the color changes based on the selected section
          const SideDesignBar(),
          const Spacer(),
          const SizedBox(width: 10),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 535,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.yellow.withOpacity(.8),
                        Colors.blue.withOpacity(.8),
                        Colors.white.withOpacity(.8),
                        Colors.green.withOpacity(.8),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        // padding: const EdgeInsets.all(10),
                        constraints: const BoxConstraints(maxWidth: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 300,
                              decoration: const BoxDecoration(
                                color: Colors.white10,
                              ),
                              child: Image.asset(
                                'assets/pictures/img.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Kadiri Ehijie',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomNavigationButton(
                              title: NavigationTitle.me.name.toUpperCase(),
                              isSelected: currentPage == NavigationTitle.me,
                              onPressed: () async {
                                await dataController.getProject();
                                await viewController.animateTo(
                                  getOffset(aboutKey),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                                setState(() {
                                  currentPage = NavigationTitle.me;
                                });
                              },
                            ),
                            CustomNavigationButton(
                              title:
                                  NavigationTitle.projects.name.toUpperCase(),
                              isSelected:
                                  currentPage == NavigationTitle.projects,
                              onPressed: () async {
                                await viewController.animateTo(
                                  getOffset(projectsKey),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                                setState(() {
                                  currentPage = NavigationTitle.projects;
                                });
                              },
                            ),
                            CustomNavigationButton(
                              title:
                                  NavigationTitle.articles.name.toUpperCase(),
                              isSelected:
                                  currentPage == NavigationTitle.articles,
                              onPressed: () async {
                                await viewController.animateTo(
                                  getOffset(articlesKey),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                                setState(() {
                                  currentPage = NavigationTitle.articles;
                                });
                              },
                            ),
                            CustomNavigationButton(
                              title: NavigationTitle.contact.name.toUpperCase(),
                              isSelected:
                                  currentPage == NavigationTitle.contact,
                              onPressed: () async {
                                await viewController.animateTo(
                                  getOffset(contactKey),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                                setState(() {
                                  currentPage = NavigationTitle.contact;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.all(10).copyWith(bottom: 0),
            constraints: const BoxConstraints(maxWidth: 620),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: SingleChildScrollView(
                controller: viewController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //About Container
                    SizedBox(
                      key: aboutKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70),
                          const Text(
                            'ME',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white24,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'I\'m simply an adventurer with some programming languages in my toolbox',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          AutoSizeText.rich(
                            TextSpan(
                              text: 'Mobile App '.toUpperCase(),
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Developer'.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white54,
                                  ),
                                )
                              ],
                            ),
                            // maxLines: 2,
                            minFontSize: 60,
                            maxFontSize: 100,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text.rich(
                            TextSpan(
                              text:
                                  'Passionate about crafting innovative solutions that transforms ideas into a mobile experience.',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white60,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '\n\nWith an eye for detail and the command of the flutter framework, I enjoy taking diverse challenges either alone or alongside fellow team mates.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '\n\nLet\'s connect to dicuss how I can be a part of your current or next adventure',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Tool Box',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white60,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            children: List.generate(
                              techIconList.length,
                              (index) => CustomToolIcon(
                                toolTip: techIconList.keys.elementAt(index),
                                url:
                                    'assets/icons/${techIconList.values.elementAt(index)}',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    //Project Container
                    SizedBox(
                      key: projectsKey,
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 70),
                            AutoSizeText.rich(
                              TextSpan(
                                text: 'Recent'.toUpperCase(),
                                style: GoogleFonts.poppins().copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\nProjects'.toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white54,
                                    ),
                                  )
                                ],
                              ),
                              // maxLines: 2,
                              minFontSize: 60,
                              maxFontSize: 100,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),

                            //TODO: The Project Container
                            ...List.generate(
                              dataController.projects.length,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: ProjectDetailButton(
                                  projectModel: dataController.projects[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Articles
                    SizedBox(
                      key: articlesKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70),
                          AutoSizeText.rich(
                            TextSpan(
                              text: 'Tech'.toUpperCase(),
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1,
                              ),
                              children: [
                                TextSpan(
                                  text: '\nThoughts'.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white54,
                                  ),
                                )
                              ],
                            ),
                            // maxLines: 2,
                            minFontSize: 60,
                            maxFontSize: 100,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          ...List.generate(
                            dataController.articles.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: ArticleDetailButton(
                                articleModel: dataController.articles[index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Contact
                    ContactSegment(
                      widgetKey: contactKey,
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () async {
                            try {
                              await launchUrl(
                                Uri.parse(
                                  'https://www.linkedin.com/in/ehijie-kadiri/',
                                ),
                                webOnlyWindowName: '_blank',
                              );
                            } catch (e) {
                              //TODO: Show snackbar that tell error
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/icons/linkedin.svg',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: () async {
                            try {
                              await launchUrl(
                                Uri.parse(
                                  'https://github.com/kadiriprosper',
                                ),
                                webOnlyWindowName: '_blank',
                              );
                            } catch (_) {}
                          },
                          icon: const Icon(
                            AntDesign.github_outline,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'An Ehijie adventure with ',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/flutter.svg',
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          AntDesign.copyright_outline,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateTime.now().year.toString(),
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            try {
                              await launchUrl(
                                Uri.parse('https://www.craiyon.com/'),
                              );
                            } catch (_) {}
                          },
                          child: const Text(
                            'Profile image generated from Craiyon',
                            style:
                                TextStyle(fontSize: 10, color: Colors.white54),
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //   height: 50,
                    //   decoration: BoxDecoration(

                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class SideDesignBar extends StatelessWidget {
  const SideDesignBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // colorAnimation = widget.colorTween.animate(animationController);
    return Container(
      padding: const EdgeInsets.all(10),
      width: 5,
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        // color: Colors.white10,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.yellow.withOpacity(.5),
            Colors.blue.withOpacity(.5),
            Colors.white.withOpacity(.5),
            Colors.green.withOpacity(.5),
          ],
        ),
      ),
    );
  }
}

class ContactSegment extends StatefulWidget {
  const ContactSegment({
    super.key,
    required this.widgetKey,
    this.mobileView = false,
  });

  final Key widgetKey;
  final bool mobileView;

  @override
  State<ContactSegment> createState() => _ContactSegmentState();
}

class _ContactSegmentState extends State<ContactSegment> {
  final formKey = GlobalKey<FormState>();
  final nameController = Get.put(
    TextEditingController(),
    tag: 'nameController',
  );
  final mailController = Get.put(
    TextEditingController(),
    tag: 'mailController',
  );
  final messageController = Get.put(
    TextEditingController(),
    tag: 'messageController',
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widget.widgetKey,
      child: Column(
        crossAxisAlignment: widget.mobileView
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          AutoSizeText.rich(
            TextSpan(
              text: 'Let\'s Talk'.toUpperCase(),
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1,
              ),
              children: [
                TextSpan(
                  text: '\nMore'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
            // maxLines: 2,
            minFontSize: 60,
            maxFontSize: 100,
            textAlign: widget.mobileView ? TextAlign.center : null,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: nameController,
                  hintText: 'Name',
                  keyboardType: TextInputType.name,
                  minLines: 1,
                  maxLines: 1,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: mailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  minLines: 1,
                  maxLines: 1,
                  validator: (value) {
                    if (value != null && value.isEmail) {
                      return null;
                    }
                    return 'Input Valid Email Address';
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: messageController,
                  hintText: 'Message',
                  keyboardType: TextInputType.emailAddress,
                  minLines: 5,
                  maxLines: 6,
                  validator: (value) {
                    if (value != null && value.length > 6) {
                      return null;
                    }
                    return 'Please input proper message (length cannot be less than 7)';
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          MaterialButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final resp = await Get.showOverlay(
                  asyncFunction: () => dataController.uploadMessage(
                    MessageModel(
                      email: mailController.text,
                      message: messageController.text,
                      name: nameController.text,
                    ),
                  ),
                  loadingWidget: Center(
                    child: SpinKitRipple(
                      size: MediaQuery.of(context).size.width / 10,
                      color: Colors.purple,
                    ),
                  ),
                );
                if (resp == null) {
                  Get.showSnackbar(
                    const GetSnackBar(
                      title: 'Success',
                      message: 'Message Successfully send',
                      animationDuration: Duration(seconds: 3),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  Get.showSnackbar(
                    const GetSnackBar(
                      title: 'Failed',
                      message: 'Message Not Sent',
                      animationDuration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            height: 60,
            color: Colors.green.withOpacity(.8),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Send'),
                SizedBox(width: 10),
                Icon(
                  AntDesign.send_outline,
                  size: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.minLines,
    this.maxLines,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final int minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(.05),
        filled: true,
        hintText: hintText,
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

class ArticleDetailButton extends StatefulWidget {
  const ArticleDetailButton({
    super.key,
    required this.articleModel,
  });

  final ArticleModel articleModel;

  @override
  State<ArticleDetailButton> createState() => _ArticleDetailButtonState();
}

class _ArticleDetailButtonState extends State<ArticleDetailButton>
    with SingleTickerProviderStateMixin {
  bool isHovering = false;
  late AnimationController controller;
  ColorTween colorTween = ColorTween(begin: Colors.white, end: Colors.orange);
  late Animation<Color?> colorAnimation;

  late ArticleModel articleModel;

  @override
  void initState() {
    super.initState();
    articleModel = widget.articleModel;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    colorAnimation = colorTween.animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await launchUrl(
            Uri.parse(
              articleModel.url,
            ),
            webOnlyWindowName: '_blank',
          );
        } catch (_) {}
      },
      onHover: (value) {
        setState(() {
          isHovering = value;
          if (isHovering) {
            controller.forward();
          } else {
            controller.reverse();
          }
        });
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green),
        ),
        child: Row(
          children: [
            ImageViewWidget(
              imgUrl: articleModel.imgUrl,
              frameSize: 120,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              articleModel.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Spacer(),
                          AnimatedBuilder(
                            animation: colorAnimation,
                            builder: (context, child) => Icon(
                              isHovering
                                  ? AntDesign.bulb_fill
                                  : AntDesign.bulb_outline,
                              color: colorAnimation.value,

                              // size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      articleModel.subtitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectDetailButton extends StatefulWidget {
  const ProjectDetailButton({
    super.key,
    required this.projectModel,
  });

  final ProjectModel projectModel;

  @override
  State<ProjectDetailButton> createState() => _ProjectDetailButtonState();
}

class _ProjectDetailButtonState extends State<ProjectDetailButton>
    with SingleTickerProviderStateMixin {
  bool isHovering = false;

  late AnimationController controller;
  ColorTween colorTween = ColorTween(begin: Colors.white, end: Colors.blue);
  late Animation<Color?> colorAnimation;
  late ProjectModel currentProject;

  @override
  void initState() {
    super.initState();
    currentProject = widget.projectModel;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    colorAnimation = colorTween.animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await launchUrl(
            Uri.parse(
              currentProject.url,
            ),
            webOnlyWindowName: '_blank',
          );
        } catch (_) {}
      },
      onHover: (value) {
        setState(() {
          isHovering = value;
          if (isHovering) {
            controller.forward();
          } else {
            controller.reverse();
          }
        });
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green),
        ),
        child: Row(
          children: [
            ImageViewWidget(
              imgUrl: currentProject.imgUrl,
              frameSize: 120,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0).copyWith(
                  bottom: 0,
                  top: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          currentProject.projectName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        AnimatedBuilder(
                          animation: colorAnimation,
                          builder: (context, child) => Icon(
                            ZondIcons.code,
                            color: colorAnimation.value,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      currentProject.projectDescription,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(
                        currentProject.techImgUrlList.length,
                        (index) => Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(right: 8),
                          child: ProjectIconWidget(
                            toolTip: '',
                            imageUrl: currentProject.techImgUrlList[index],
                            fromNetwork: true,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(2).copyWith(
                        //     top: 0,
                        //     bottom: 0,
                        //   ),
                        //   child: SvgPicture.network(
                        //     currentProject.techImgUrlList[index],
                        //     width: 20,
                        //     height: 20,
                        //   ),
                        //   // ProjectIconWidget(
                        //   //   imageUrl: currentProject.techImgUrlList[index],
                        //   //   toolTip: '',
                        //   // ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectIconWidget extends StatelessWidget {
  const ProjectIconWidget({
    super.key,
    required this.toolTip,
    required this.imageUrl,
    this.fromNetwork = false,
  });

  final String toolTip;
  final String imageUrl;
  final bool fromNetwork;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      richMessage: TextSpan(
        text: toolTip,
      ),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child:fromNetwork ? Image.network(imageUrl) :  SvgPicture.network(
          imageUrl,
        ),
      ),
    );
  }
}

class CustomToolIcon extends StatelessWidget {
  const CustomToolIcon({
    super.key,
    required this.url,
    required this.toolTip,
  });

  final String url;
  final String toolTip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      richMessage: TextSpan(
        text: toolTip,
      ),
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white10,
          ),
        ),
        child: SvgPicture.asset(
          url,
        ),
      ),
    );
  }
}

class CustomNavigationButton extends StatelessWidget {
  const CustomNavigationButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
  });

  final String title;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      minWidth: 0,
      height: 50,
      color: isSelected ? Colors.white10 : null,
      child: Row(
        children: [
          Text(title),
        ],
      ),
    );
  }
}

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({
    super.key,
    required this.imgUrl,
    required this.frameSize,
    this.borderRadius,
  });

  final String imgUrl;
  final double frameSize;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imgUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: frameSize,
        height: frameSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: borderRadius ??
              BorderRadius.circular(4)
                  .copyWith(topRight: Radius.zero, bottomRight: Radius.zero),
        ),
        child: const Icon(Icons.error),
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress?.cumulativeBytesLoaded !=
            loadingProgress?.expectedTotalBytes) {
          return Container(
            width: frameSize,
            height: frameSize,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: borderRadius ??
                  BorderRadius.circular(4).copyWith(
                      topRight: Radius.zero, bottomRight: Radius.zero),
            ),
            child: const Center(
              child: SpinKitSpinningLines(
                color: Colors.white,
              ),
            ),
          );
        }
        return Container(
          width: frameSize,
          height: frameSize,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: borderRadius ??
                BorderRadius.circular(4)
                    .copyWith(topRight: Radius.zero, bottomRight: Radius.zero),
          ),
          child: ClipRRect(
            borderRadius: borderRadius ??
                BorderRadius.circular(4)
                    .copyWith(topRight: Radius.zero, bottomRight: Radius.zero),
            child: child,
          ),
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
    );
  }
}
