import 'package:basketball_counter_app/core/cache_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // عشان اتاكد ان كلو جاهز للرن
  await CacheHelper().init(); // دي بتاخد نسخه من الشيرد
  runApp(const PointsCounter());
}

// CacheHelper() علشان استعملتها كذا مره فهستعمل سنجلتون ديزاين باترن
// باخد اوبجكت فمكان معين وبخزنو وببدا استخده علي مستوي الااب كلو

class PointsCounter extends StatefulWidget {
  const PointsCounter({super.key});

  @override
  State<PointsCounter> createState() => _PointsCounterState();
}

class _PointsCounterState extends State<PointsCounter> {
  // بشيك لو موجود الكيي دا واضيفو لو مش موجود ب0
  int teamAPoints = CacheHelper().getData(key: 'teamAPoints') ?? 0;
  int teamBPoints = CacheHelper().getData(key: 'teamBPoints') ?? 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Points Counter'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Team A',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        '$teamAPoints',
                        style: const TextStyle(
                          fontSize: 150,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () async {
                          await CacheHelper().saveData(
                              key: 'teamAPoints', value: teamAPoints += 1);
                          setState(
                            () {},
                          );
                        },
                        child: const Text(
                          'Add 1 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () async {
                          await CacheHelper().saveData(
                              key: 'teamAPoints', value: teamAPoints += 2);
                          setState(
                            () {},
                          );
                        },
                        child: const Text(
                          'Add 2 Point',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () async {
                          await CacheHelper().saveData(
                              key: 'teamAPoints', value: teamAPoints += 3);
                          setState(
                            () {},
                          );
                        },
                        child: const Text(
                          'Add 3 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                  child: VerticalDivider(
                    indent: 50,
                    endIndent: 50,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Team B',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        '$teamBPoints',
                        style: const TextStyle(
                          fontSize: 150,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () async {
                          await CacheHelper().saveData(
                              key: 'teamBPoints', value: teamBPoints += 1);
                          setState(
                            () {},
                          );
                        },
                        child: const Text(
                          'Add 1 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () async {
                          await CacheHelper().saveData(
                              key: 'teamBPoints', value: teamBPoints += 2);
                          setState(
                            () {},
                          );
                        },
                        child: const Text(
                          'Add 2 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () async {
                          await CacheHelper().saveData(
                              key: 'teamBPoints', value: teamBPoints += 3);
                          setState(
                            () {},
                          );
                        },
                        child: const Text(
                          'Add 3 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                backgroundColor: Colors.orange,
                minimumSize: const Size(150, 50),
              ),
              // onPressed: () {
              //   setState(() {
              //     teamAPoints = 0;
              //     teamBPoints = 0;
              //   });
              // },
              // onPressed: () {
              //   SharedPreferences.getInstance().then((sp) {
              //     sp.setInt('teamAPoints', teamAPoints + 0);
              //   });
              //   SharedPreferences.getInstance().then((sp) {
              //     sp.setInt('teamBPoints', teamBPoints = 0);
              //   });
              //   setState(() {
              //     teamAPoints = 0;
              //     teamBPoints = 0;
              //   });
              // },
              onPressed: () async {
                await CacheHelper()
                    .saveData(key: 'teamAPoints', value: teamAPoints = 0);
                await CacheHelper()
                    .saveData(key: 'teamBPoints', value: teamBPoints = 0);
                setState(
                  () {},
                );
              },
              child: const Text(
                'Reset',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
