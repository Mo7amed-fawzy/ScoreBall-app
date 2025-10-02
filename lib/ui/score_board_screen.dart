import 'package:flutter/material.dart';

class ScoreBoardScreen extends StatefulWidget {
  // kept for compatibility with existing app logic, but UI reads theme
  final bool isDark;
  const ScoreBoardScreen({super.key, required this.isDark});

  @override
  State<ScoreBoardScreen> createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen> {
  int team1Score = 0;
  int team2Score = 0;
  bool team1Finished = false;
  bool team2Finished = false;
  bool timerOn = true;
  String selectedTeam = 'Team 1';
  final TextEditingController goalController = TextEditingController();

  bool isLockedForTeam(String team) {
    if (!timerOn) return true;
    if (team == 'Team 1' && team1Finished) return true;
    if (team == 'Team 2' && team2Finished) return true;
    return false;
  }

  void clearAll() {
    setState(() {
      team1Score = 0;
      team2Score = 0;
      team1Finished = false;
      team2Finished = false;
      timerOn = true;
      selectedTeam = 'Team 1';
      goalController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          title: Text('Score Board',
              style: theme.textTheme.titleLarge
                  ?.copyWith(color: colors.onPrimary)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh, color: colors.secondary),
              tooltip: 'Clear All',
              onPressed: clearAll,
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      kToolbarHeight - // ارتفاع الـ AppBar
                      MediaQuery.of(context).padding.top - // الستاتس بار
                      24 * 2, // البادينج بتاعك
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Team 1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Team 1',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontSize: 22),
                          ),
                          Text(
                            '$team1Score',
                            style: theme.textTheme.displayMedium
                                ?.copyWith(fontSize: 48),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: team1Finished
                                  ? theme.cardColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: team1Finished,
                                  onChanged: (val) {
                                    setState(() {
                                      team1Finished = val ?? false;
                                    });
                                  },
                                  activeColor: colors.primary,
                                ),
                                Text('Finished',
                                    style: theme.textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Team 2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Team 2',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontSize: 22),
                          ),
                          Text(
                            '$team2Score',
                            style: theme.textTheme.displayMedium
                                ?.copyWith(fontSize: 48),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: team2Finished
                                  ? theme.cardColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: team2Finished,
                                  onChanged: (val) {
                                    setState(() {
                                      team2Finished = val ?? false;
                                    });
                                  },
                                  activeColor: colors.primary,
                                ),
                                Text('Finished',
                                    style: theme.textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Goal input
                      TextField(
                        controller: goalController,
                        enabled: !isLockedForTeam(selectedTeam),
                        keyboardType: TextInputType.number,
                        // decoration: theme.inputDecorationTheme.copyWith(
                        //   hintText: 'Enter Goals',
                        //   filled: true,
                        //   fillColor: theme.inputDecorationTheme.fillColor,
                        // ),
                        style: theme.textTheme.bodyLarge,
                      ),

                      const SizedBox(height: 24),

                      // Timer switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Timer',
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontSize: 18)),
                          Switch(
                            value: timerOn,
                            onChanged: (val) => setState(() {
                              timerOn = val;
                            }),
                            activeColor: colors.primary,
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Radio buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Team 1',
                                groupValue: selectedTeam,
                                onChanged: (value) {
                                  if (timerOn)
                                    setState(() =>
                                        selectedTeam = value ?? selectedTeam);
                                },
                                activeColor: colors.primary,
                              ),
                              Text('Team 1',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'Team 2',
                                groupValue: selectedTeam,
                                onChanged: (value) {
                                  if (timerOn)
                                    setState(() =>
                                        selectedTeam = value ?? selectedTeam);
                                },
                                activeColor: colors.primary,
                              ),
                              Text('Team 2',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Update button
                      ElevatedButton(
                        onPressed: isLockedForTeam(selectedTeam)
                            ? null
                            : () {
                                final input = int.tryParse(goalController.text);
                                if (input == null) return;
                                setState(() {
                                  if (selectedTeam == 'Team 1' &&
                                      !team1Finished) {
                                    team1Score += input;
                                  } else if (selectedTeam == 'Team 2' &&
                                      !team2Finished) {
                                    team2Score += input;
                                  }
                                  goalController.clear();
                                });
                              },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                            if (states.contains(MaterialState.disabled)) {
                              return theme.disabledColor;
                            }
                            return colors.primary;
                          }),
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50)),
                        ),
                        child: Text('UPDATE',
                            style: theme.textTheme.titleSmall?.copyWith(
                                color: colors.onPrimary, fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
