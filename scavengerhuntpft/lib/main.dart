import 'package:flutter/material.dart';

// scavenger hunt state management
class HuntState {
  static bool hasCompletedLocation(String locationId) => _completedLocations.contains(locationId);
  static void markLocationCompleted(String locationId) => _completedLocations.add(locationId);
  static Set<String> _completedLocations = {};
  static int totalLocations = 8;
  static int get completedCount => _completedLocations.length;
}

// clue data structure
class Clue {
  final String text;
  final String answer;
  const Clue({required this.text, required this.answer});
}

// constants for clues
const Map<String, Clue> CLUES = {
  'entrance': Clue(
    text: 'Clue prompt 1.',
    answer: 'ans1',
  ),
  'studyarea': Clue(
    text: 'clue prompt 2',
    answer: 'ans2',
  ),
  'classroom': Clue(
    text: 'clue prompt 3',
    answer: 'ans3',
  ),
  'lounge': Clue(
    text: 'clue prompt 4.',
    answer: 'ans4',
  ),
  'panera': Clue(
    text: 'clue prompt 5',
    answer: 'ans5',
  ),
  'stairs': Clue(
    text: 'clue prompt 6.',
    answer: 'ans6',
  ),
  'lab': Clue(
    text: 'clue prompt 7.',
    answer: 'ans7',
  ),
};

// lsu branding colors
final lsuPurple = const Color(0xFF461D7C);
final lsuGold = const Color(0xFFFDD023);

// app theme with lsu branding
final ThemeData appTheme = ThemeData(
  primaryColor: lsuPurple,
  colorScheme: ColorScheme.light(
    primary: lsuPurple,
    secondary: lsuGold,
    surface: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lsuPurple,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 3,
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Color(0xFF333333),
    ),
  ),
);

void main() {
  runApp(const ScavengerHuntApp());
}

class ScavengerHuntApp extends StatelessWidget {
  const ScavengerHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PFT Scavenger Hunt',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const FirstRoute(),
    );
  }
}

// base layout with bottom navigation bar
class BaseScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;

  const BaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: lsuGold,
        unselectedItemColor: Colors.white70,
        backgroundColor: lsuPurple,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
        onTap: (index) {
          // navigate to appropriate screen based on index
          switch (index) {
            case 0:
              if (currentIndex != 0) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstRoute()),
                  (route) => false,
                );
              }
              break;
            case 1:
              if (currentIndex != 1) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MapRoute()),
                  (route) => false,
                );
              }
              break;
            case 2:
              // need to implement the progress screen here
              break;
            case 3:
              // need to implement the info screen here
              break;
          }
        },
      ),
    );
  }
}

// clue widget template - reusable across screens
class ClueWidget extends StatefulWidget {
  final String locationId;
  final VoidCallback onSolved;

  const ClueWidget({
    super.key,
    required this.locationId,
    required this.onSolved,
  });

  @override
  State<ClueWidget> createState() => _ClueWidgetState();
}

class _ClueWidgetState extends State<ClueWidget> {
  final TextEditingController _answerController = TextEditingController();
  bool _showClue = false;
  bool _incorrect = false;
  bool get _isSolved => HuntState.hasCompletedLocation(widget.locationId);

  @override
  Widget build(BuildContext context) {
    if (_isSolved) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: lsuGold.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: lsuGold),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 10),
            Text('Clue solved! Proceed to the next location.',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    final clue = CLUES[widget.locationId];
    if (clue == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lsuGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: lsuPurple),
      ),
      child: Column(
        children: [
          if (!_showClue)
            ElevatedButton(
              onPressed: () => setState(() => _showClue = true),
              child: const Text('Show Clue'),
            )
          else
            Column(
              children: [
                Text(
                  'CLUE:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: lsuPurple,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  clue.text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _answerController,
                  decoration: InputDecoration(
                    labelText: 'Your Answer',
                    errorText: _incorrect ? 'Incorrect answer, try again' : null,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // simplistic answer checking - would be improved in real app
                    if (_answerController.text.trim().toLowerCase() ==
                        clue.answer.toLowerCase()) {
                      HuntState.markLocationCompleted(widget.locationId);
                      widget.onSolved();
                      setState(() {});
                    } else {
                      setState(() => _incorrect = true);
                    }
                  },
                  child: const Text('Submit Answer'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// start screen
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/pftfront.jpg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: lsuPurple.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'PFT SCAVENGER HUNT',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: lsuPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome to Patrick F. Taylor Hall! Find clues, solve puzzles, and explore the building.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Locations Found: ${HuntState.completedCount}/${HuntState.totalLocations}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: lsuPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Hunt',
                        style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SecondRoute()),
                      );
                    },
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

// entrance location screen
class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  bool get isSolved => HuntState.hasCompletedLocation('entrance');

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/entrance.jpeg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 60, left: 24, right: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "PFT Main Entrance",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: lsuPurple,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "This is the entrance area showing rooms 1100 and 1200. Look around to solve the clue!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(24),
                        child: ClueWidget(
                          locationId: 'entrance',
                          onSolved: () => setState(() {}),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: isSolved
                            ? ElevatedButton.icon(
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Continue to Study Area'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ThirdRoute()),
                                  );
                                },
                              )
                            : const Text(
                                "Solve the clue to continue",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// study area location screen 
class ThirdRoute extends StatefulWidget {
  const ThirdRoute({super.key});

  @override
  State<ThirdRoute> createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
  bool get isSolved => HuntState.hasCompletedLocation('studyarea');

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/pftlounge.jpg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 60, left: 24, right: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "PFT Study Area",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: lsuPurple,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "This is where students do their work, study, and lounge between classes!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(24),
                        child: ClueWidget(
                          locationId: 'studyarea',
                          onSolved: () => setState(() {}),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: isSolved
                            ? ElevatedButton.icon(
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Continue to Classroom'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const fourthroute()),
                                  );
                                },
                              )
                            : const Text(
                                "Solve the clue to continue",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.home),
                        label: const Text('Home'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FirstRoute()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// classroom location
class fourthroute extends StatefulWidget {
  const fourthroute({super.key});

  @override
  State<fourthroute> createState() => _fourthrouteState();
}

class _fourthrouteState extends State<fourthroute> {
  bool get isSolved => HuntState.hasCompletedLocation('classroom');

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/classroom.jpeg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 60, left: 24, right: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "PFT Classroom",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: lsuPurple,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "This is an example of the classrooms PFT offers! Look around to solve the clue.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(24),
                        child: ClueWidget(
                          locationId: 'classroom',
                          onSolved: () => setState(() {}),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: isSolved
                            ? ElevatedButton.icon(
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Continue to Lounge Area'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const fifthRoute()),
                                  );
                                },
                              )
                            : const Text(
                                "Solve the clue to continue",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.home),
                        label: const Text('Home'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FirstRoute()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// lounge area location
class fifthRoute extends StatefulWidget {
  const fifthRoute({super.key});

  @override
  State<fifthRoute> createState() => _fifthRouteState();
}

class _fifthRouteState extends State<fifthRoute> {
  bool get isSolved => HuntState.hasCompletedLocation('lounge');

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/greatroomlsu.jpg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 60, left: 24, right: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "PFT Great Room",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: lsuPurple,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "This is the largest lounge area in the building. Here you can study and eat. There are also labs and classrooms nearby!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(24),
                        child: ClueWidget(
                          locationId: 'lounge',
                          onSolved: () => setState(() {}),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: isSolved
                            ? ElevatedButton.icon(
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Continue to Panera'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const sixthRoute()),
                                  );
                                },
                              )
                            : const Text(
                                "Solve the clue to continue",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.home),
                        label: const Text('Home'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FirstRoute()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// panera location
class sixthRoute extends StatefulWidget {
  const sixthRoute({super.key});

  @override
  State<sixthRoute> createState() => _sixthRouteState();
}

class _sixthRouteState extends State<sixthRoute> {
  bool get isSolved => HuntState.hasCompletedLocation('panera');

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/panera.jpeg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 60, left: 24, right: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "PFT Panera Bread",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: lsuPurple,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "This is the only Panera Bread on campus, tucked inside our engineering building. Perfect spot after a long study session!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(24),
                        child: ClueWidget(
                          locationId: 'panera',
                          onSolved: () => setState(() {}),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: isSolved
                            ? ElevatedButton.icon(
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Continue to Stairs'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SeventhRoute()),
                                  );
                                },
                              )
                            : const Text(
                                "Solve the clue to continue",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.home),
                        label: const Text('Home'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FirstRoute()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// stairs location
class SeventhRoute extends StatefulWidget {
  const SeventhRoute({super.key});

  @override
  State<SeventhRoute> createState() => _SeventhRouteState();
}

class _SeventhRouteState extends State<SeventhRoute> {
  bool get isSolved => HuntState.hasCompletedLocation('stairs');

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/capstone-stairs.jpg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 60, left: 24, right: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "PFT Staircase",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: lsuPurple,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Let's head upstairs to check out some of the specialty labs on the second floor!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(24),
                        child: ClueWidget(
                          locationId: 'stairs',
                          onSolved: () => setState(() {}),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: isSolved
                            ? ElevatedButton.icon(
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Continue to Computer Lab'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EighthRoute()),
                                  );
                                },
                              )
                            : const Text(
                                "Solve the clue to continue",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.home),
                        label: const Text('Home'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FirstRoute()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// computer lab location - final location
class EighthRoute extends StatefulWidget {
  const EighthRoute({super.key});

  @override
  State<EighthRoute> createState() => _EighthRouteState();
}

class _EighthRouteState extends State<EighthRoute> {
  bool get isSolved => HuntState.hasCompletedLocation('lab');
  bool get allComplete => HuntState.completedCount >= 7; // All locations except current one

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/upstairs-lab.jpeg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 60, left: 24, right: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "PFT Computer Lab",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: lsuPurple,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "This is one of the many computer labs on the second floor. These labs are equipped with specialized software for engineering students.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(24),
                        child: ClueWidget(
                          locationId: 'lab',
                          onSolved: () => setState(() {}),
                        ),
                      ),
                      if (isSolved)
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 24),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: lsuGold.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: lsuGold, width: 2),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.emoji_events,
                                color: Colors.amber,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                allComplete
                                    ? "Congratulations! You've completed the entire PFT Scavenger Hunt!"
                                    : "You've completed this location! Continue hunting for the others.",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Locations Found: ${HuntState.completedCount}/${HuntState.totalLocations}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: lsuPurple,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back to Stairs'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.home),
                        label: const Text('Home'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FirstRoute()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Map page
class MapRoute extends StatelessWidget {
  const MapRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 1,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width, // Make the map wider
                height: MediaQuery.of(context).size.height, // Make the map taller
                child: Image.asset(
                  "assets/tour map.jpg",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "PFT Tour Map",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: lsuPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Use this map to navigate through the building and find all the locations!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
              