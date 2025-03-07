import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: FirstRoute()));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/pftfront.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hello! Welcome to PFT, Come take a tour!',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 22, 18, 18),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Take a look inside!'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondRoute()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/fillerimage.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "This is the entrance showing rooms 1100 and 1200!",
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 13, 12, 12),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back out the door'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Study Area and research rooms'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ThirdRoute()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/pftlounge.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'This is Where students do their work, study, and lounge between classes!',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 11, 10, 10),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Lets see Classroom!'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const fourthroute()),
                      // change to 4th route when ready to add more
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Exit PFT'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FirstRoute()),
                    );
                  }
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class fourthroute extends StatelessWidget {
  const fourthroute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/fillerimage.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'This is an example of the great classrooms pft offers! Classes like these are offered throughout the first floor of pft and labs are located on the second.',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 11, 10, 10),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Go to second great lounge area'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const fifthRoute()),
                      // change to 4th route when ready to add more
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Exit PFT'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FirstRoute()),
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class fifthRoute extends StatelessWidget {
  const fifthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/greatroomlsu.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'This is the largest lounge area we have. Here you can study and eat. There are also computer labs/ classrooms located in the halls leading here and a panera right by the exit!',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 11, 10, 10),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Lets see Panera, Im hungry!'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const sixthRoute()),
                      // change to 4th route when ready to add more
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Exit PFT'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FirstRoute()),
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class sixthRoute extends StatelessWidget {
  const sixthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "fillerimage.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'This is the only campus panera bread, tucked right inside of our engineering building. After you fail a test, you can come get bread!',
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: Color.fromARGB(255, 11, 10, 10),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('insert here'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const fifthRoute()),
                      // change to 4th route when ready to add more
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Exit PFT'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FirstRoute()),
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


