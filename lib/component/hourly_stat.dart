import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import '../model/stat_model.dart';

class HourlyStat extends StatelessWidget {
  final Region region;
  final Color darkColor;
  final Color lightColor;
  const HourlyStat({required this.region, required this.lightColor, required this.darkColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ItemCode.values
          .map(
            (e) => FutureBuilder(
                future: GetIt.I<Isar>()
                    .statModels
                    .filter()
                    .regionEqualTo(region)
                    .itemCodeEqualTo(e)
                    .sortByDateTimeDesc()
                    .limit(24)
                    .findAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final stats = snapshot.data!;
                  return SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        color: lightColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: darkColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16.0),
                                  topLeft: Radius.circular(16.0),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  '시간별 ${e.krName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            ...stats
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${e.dateTime.hour.toString().padLeft(2, '0')}시',
                                          ),
                                        ),
                                        Expanded(
                                          child: Image.asset(
                                            StatusUtils.getStatusModelFromStat(
                                              statModel: e,
                                            ).imagePath,
                                            height: 20.0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            StatusUtils.getStatusModelFromStat(
                                              statModel: e,
                                            ).label,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
          .toList(),
    );
  }
}
