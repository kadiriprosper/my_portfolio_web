import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_portfolio_web/controller/data_controller.dart';
import 'package:url_launcher/url_launcher.dart';

extension CapitalizeFirst on String {}

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
  NavigationTitle currentPage = NavigationTitle.me;
  late ColorTween colorTween;
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final articlesKey = GlobalKey();
  final contactKey = GlobalKey();
  ScrollController viewController = ScrollController();

  @override
  void initState() {
    colorTween = ColorTween(begin: Colors.white, end: Colors.white30);
    viewController.addListener(highlightButton);
    super.initState();
  }

  void highlightButton() {
    setState(() {
      if ( //viewController.offset >= 0 &&
          viewController.offset < getOffset(projectsKey) - 110) {
        colorTween = getColorTween(
          leavingSection: currentPage,
          arrivingSection: NavigationTitle.me,
        );
        currentPage = NavigationTitle.me;
      } else if (
          //viewController.offset >= getOffset(projectsKey) &&
          viewController.offset < getOffset(articlesKey) - 110) {
        colorTween = getColorTween(
          leavingSection: currentPage,
          arrivingSection: NavigationTitle.projects,
        );
        currentPage = NavigationTitle.projects;
      } else if (
          //viewController.offset >= getOffset(articlesKey) &&
          viewController.offset < getOffset(contactKey) - 200) {
        colorTween = getColorTween(
          leavingSection: currentPage,
          arrivingSection: NavigationTitle.articles,
        );
        currentPage = NavigationTitle.articles;
      } else if (viewController.offset >= getOffset(contactKey) - 200) {
        colorTween = getColorTween(
          leavingSection: currentPage,
          arrivingSection: NavigationTitle.contact,
        );
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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Container(
              height: double.infinity,
              padding: const EdgeInsets.all(14).copyWith(top: 0, bottom: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //This is a design container, the color changes based on the selected section
                  SideDesignBar(
                    colorTween: colorTween,
                  ),
                  const Spacer(),
                  const SizedBox(width: 10),
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
                              //TODO: Put image and navigation buttons
                              //Profile / About
                              //Projects
                              //Articles
                              //Contact Me
                              Container(
                                width: 300,
                                height: 300,
                                decoration: const BoxDecoration(
                                  color: Colors.white10,
                                  // borderRadius: BorderRadius.circular(12),
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
                                title:
                                    NavigationTitle.contact.name.toUpperCase(),
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
                                  SizedBox(height: 70),
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
                                    height: MediaQuery.of(context).size.height *
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
                                        toolTip:
                                            techIconList.keys.elementAt(index),
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
                              child: Column(
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
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),

                                  //TODO: The Project Container
                                  ...List.generate(
                                    4,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: ProjectDetailButton(
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ],
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
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),

                                  //TODO: The Project Container
                                  ...List.generate(
                                    1,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: ArticleDetailButton(
                                        onTap: () {},
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
                                    } catch (e) {
                                      print(e);
                                      print('error launching url');
                                      //TODO: Show snackbar that tell error
                                    }
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
                            const SizedBox(height: 20),
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
          } else {
            return Container(
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}

ColorTween getColorTween(
    {required NavigationTitle leavingSection,
    required NavigationTitle arrivingSection}) {
  Color leavingColor = Colors.white;
  Color arivingColor = Colors.black;
  leavingColor = switch (leavingSection) {
    NavigationTitle.me => Colors.yellow.withOpacity(.8),
    NavigationTitle.projects => Colors.blue.withOpacity(.8),
    NavigationTitle.articles => Colors.white.withOpacity(.8),
    NavigationTitle.contact => Colors.green.withOpacity(.8),
  };
  arivingColor = switch (arrivingSection) {
    NavigationTitle.me => Colors.yellow.withOpacity(.8),
    NavigationTitle.projects => Colors.blue.withOpacity(.8),
    NavigationTitle.articles => Colors.white.withOpacity(.8),
    NavigationTitle.contact => Colors.green.withOpacity(.8),
  };
  return ColorTween(
    begin: leavingColor,
    end: arivingColor,
  );
}

class SideDesignBar extends StatefulWidget {
  const SideDesignBar({
    super.key,
    required this.colorTween,
  });

  final ColorTween colorTween;

  @override
  State<SideDesignBar> createState() => _SideDesignBarState();
}

class _SideDesignBarState extends State<SideDesignBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    colorAnimation = widget.colorTween.animate(animationController);
    return AnimatedBuilder(
        animation: colorAnimation,
        builder: (context, widget) {
          return Container(
            padding: const EdgeInsets.all(10),
            width: 5,
            constraints: const BoxConstraints(maxWidth: 300),
            //TODO: fix the animation  later

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
        });
  }
}

class ContactSegment extends StatelessWidget {
  const ContactSegment({
    super.key,
    required this.widgetKey,
  });

  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widgetKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          CustomTextField(
            controller: TextEditingController(),
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
            controller: TextEditingController(),
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            minLines: 1,
            maxLines: 1,
            validator: (value) {
              return null;
            },
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: TextEditingController(),
            hintText: 'Message',
            keyboardType: TextInputType.emailAddress,
            minLines: 5,
            maxLines: 6,
            validator: (value) {
              return null;
            },
          ),
          const SizedBox(height: 16),
          MaterialButton(
            onPressed: () {},
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
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<ArticleDetailButton> createState() => _ArticleDetailButtonState();
}

class _ArticleDetailButtonState extends State<ArticleDetailButton>
    with SingleTickerProviderStateMixin {
  bool isHovering = false;
  late AnimationController controller;
  ColorTween colorTween = ColorTween(begin: Colors.white, end: Colors.orange);
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    colorAnimation = colorTween.animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8).copyWith(
                  topRight: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Article Title',
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
                            isHovering
                                ? AntDesign.bulb_fill
                                : AntDesign.bulb_outline,
                            color: colorAnimation.value,

                            // size: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'SubTitle',
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
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<ProjectDetailButton> createState() => _ProjectDetailButtonState();
}

class _ProjectDetailButtonState extends State<ProjectDetailButton>
    with SingleTickerProviderStateMixin {
  bool isHovering = false;

  late AnimationController controller;
  ColorTween colorTween = ColorTween(begin: Colors.white, end: Colors.blue);
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    colorAnimation = colorTween.animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8).copyWith(
                  topRight: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Project Name',
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
                      'Some description text here about the project, bla bla bla bla d j fnd fnn adfs  fadn nfa sk af s af s ffads v afb fav asdfb afk kds as b',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Row(
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(2).copyWith(
                            top: 0,
                            bottom: 0,
                          ),
                          child: const ProjectIconWidget(
                            imageUrl:
                                'https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg',
                            toolTip: 'Flutter',
                          ),
                        ),
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
  });

  final String toolTip;
  final String imageUrl;

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
        child: SvgPicture.network(
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
