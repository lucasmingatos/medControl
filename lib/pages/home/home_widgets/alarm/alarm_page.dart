import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/values/custom_colors.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  TimeOfDay? selectedTime;
  List<DateTime> alarms = [];
  String alarmName = '';

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    loadAlarms();
  }

  Future<void> onSelectNotification(String payload) async {
    //lidar com o evento de notificação quando o usuário a seleciona
  }

  Future<void> scheduleAlarm(TimeOfDay time) async {
    var now = DateTime.now();
    var scheduledTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_channel',
      'Channel for Alarm notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'Alarme',
      'Hora da medicação!',
      scheduledTime,
      platformChannelSpecifics,
    );
    saveAlarm(scheduledTime);
  }

  Future<void> saveAlarm(DateTime alarmTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedAlarms = [
      ...alarms.map((alarm) => alarm.toIso8601String()),
      alarmTime.toIso8601String(),
    ];
    await prefs.setStringList('alarms', updatedAlarms);
    setState(() {
      alarms = updatedAlarms.map((alarm) => DateTime.parse(alarm)).toList();
    });
  }

  Future<void> loadAlarms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedAlarms = prefs.getStringList('alarms');
    setState(() {
      alarms =
          storedAlarms?.map((alarm) => DateTime.parse(alarm)).toList() ?? [];
    });
  }

  Future<void> deleteExpiredAlarms() async {
    DateTime now = DateTime.now();
    List<DateTime> updatedAlarms =
        alarms.where((alarm) => alarm.isAfter(now)).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedAlarmsStrings =
        updatedAlarms.map((alarm) => alarm.toIso8601String()).toList();
    await prefs.setStringList('alarms', updatedAlarmsStrings);
    setState(() {
      alarms = updatedAlarms;
    });
  }

  Future<void> deleteAllAlarms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('alarms');
    setState(() {
      alarms = [];
    });
  }

  Future<void> removeAlarm(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedAlarms =
        alarms.map((alarm) => alarm.toIso8601String()).toList();
    updatedAlarms.removeAt(index);
    await prefs.setStringList('alarms', updatedAlarms);
    setState(() {
      alarms = updatedAlarms.map((alarm) => DateTime.parse(alarm)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Alarmes'),
        backgroundColor: const Color(0xff0A6D92),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors().getGradientMainColor(),
              CustomColors().getGradientSecColor(),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'Configurar novo alarme',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                child: const Text(
                  'Selecionar hora',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  selectedTime = (await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ))!;
                  setState(
                      () {}); // Atualiza a interface para exibir a hora selecionada
                },
              ),
              //const SizedBox(height: 16),
              if (selectedTime != null)
                Center(
                  child: Text(
                    'Hora selecionada: ${selectedTime!.format(context)}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                child: const Text(
                  'Cadastrar alarme',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (selectedTime != null) {
                    scheduleAlarm(selectedTime!);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Sucesso'),
                        content: Text(
                          'Alarme agendado para: \n${selectedTime!.format(context)}.',
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            child: const Text(
                              'Concluir',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Alarmes cadastrados:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: alarms.length,
                  itemBuilder: (context, index) {
                    final alarm = alarms[index];
                    final formattedTime = DateFormat('HH:mm')
                        .format(alarm); // Format time as HH:mm
                    final formattedDate = DateFormat('dd/MM/yyyy')
                        .format(alarm); // Format date as dd/MM/yyyy
                    return ListTile(
                      title: Text(
                        '$formattedTime - $formattedDate',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          removeAlarm(index);
                        },
                      ),
                    );
                  },
                ),
              ),
              /*ElevatedButton(
                child: const Text('Remover Alarmes Expirados'),
                onPressed: () {
                  deleteExpiredAlarms();
                },
              ),
              ElevatedButton(
                child: const Text('Remover Todos os Alarmes'),
                onPressed: () {
                  deleteAllAlarms();
                },
              ),
              const SizedBox(height: 16.0),*/
            ],
          ),
        ),
      ),
    );
  }
}
