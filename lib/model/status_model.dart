import 'package:flutter/material.dart';

class StatusModel {
  // 단계
  final int level;
  // 단계 이름
  final String label;
  // 색
  final Color primaryColor;
  final Color darkColor;
  final Color lightColor;
  final Color fontColor;
  // 이미지 경로
  final String imagePath;
  // 코멘트
  final String comment;
  // 최소치
  final double minPM10;
  final double minPM25;
  final double minO3;
  final double minNO2;
  final double minCO;
  final double minSO2;

  const StatusModel({
    required this.level,
    required this.label,
    required this.primaryColor,
    required this.darkColor,
    required this.lightColor,
    required this.fontColor,
    required this.imagePath,
    required this.comment,
    required this.minPM10,
    required this.minPM25,
    required this.minO3,
    required this.minNO2,
    required this.minCO,
    required this.minSO2,
  });
}