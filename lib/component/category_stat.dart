import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import '../model/stat_model.dart';

class CategoryStat extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final Region region;
  const CategoryStat({required this.region, required this.darkColor, required this.lightColor, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          child: LayoutBuilder(builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: darkColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16.0,
                      ),
                      topRight: Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: Text(
                      '종류별 통계',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            16.0,
                          ),
                          bottomRight: Radius.circular(
                            16.0,
                          ),
                        )),
                    child: ListView(
                      physics: PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: ItemCode.values
                          .map(
                            (e) => FutureBuilder(
                                future: GetIt.I<Isar>()
                                    .statModels
                                    .filter()
                                    .regionEqualTo(region)
                                    .itemCodeEqualTo(e)
                                    .sortByDateTimeDesc()
                                    .findFirst(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {}
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }
                                  final statModel = snapshot.data!;
                                  final statusModel =
                                      StatusUtils.getStatusModelFromStat(
                                    statModel: statModel,
                                  );

                                  return SizedBox(
                                    width: constraint.maxWidth / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(e.krName),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Image.asset(
                                          statusModel.imagePath,
                                          width: 50.0,
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(statModel.stat.toString()),
                                      ],
                                    ),
                                  );
                                }),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
