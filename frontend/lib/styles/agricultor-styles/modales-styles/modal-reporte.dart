import 'package:flutter/material.dart';

class ModalReporteStyles {
  static const double maxWidth = 760.0;
  
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  static const Color backgroundColor = Colors.white;
  static const Color borderColor = Color(0xFFd7e4dc);
  static const Color titleColor = Color(0xFF073d2b);
  static const Color textLightColor = Color(0xFF597268);
  static const Color textDarkColor = Color(0xFF456657);
  
  static const Color closeBtnBg = Color(0xFFf5faf3);
  static const Color closeBtnColor = Color(0xFF073d2b);

  static BoxDecoration modalDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  static BoxDecoration closeBtnDecoration = BoxDecoration(
    color: closeBtnBg,
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle headerStyle = TextStyle(
    color: titleColor,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  // Planta Info
  static BoxDecoration plantaInfoDecoration = BoxDecoration(
    color: const Color(0xFFf5faf3),
    borderRadius: BorderRadius.circular(8),
  );
  
  static const TextStyle plantaInfoStyle = TextStyle(
    color: textDarkColor,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  // Diagnostico Section
  static BoxDecoration diagnosticoDecoration = BoxDecoration(
    color: const Color(0xFFfbfdf9),
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle sectionTitleStyle = TextStyle(
    color: titleColor,
    fontSize: 15,
    fontWeight: FontWeight.w800,
  );
  
  static const TextStyle diagnosticoTitleStyle = TextStyle(
    color: titleColor,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle diagnosticoMessageStyle = TextStyle(
    color: textLightColor,
    fontSize: 14,
  );

  // Metricas
  static BoxDecoration metricaDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle metricaLabelStyle = TextStyle(
    color: textLightColor,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle metricaValorStyle = TextStyle(
    color: titleColor,
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );

  // Predicciones
  static BoxDecoration prediccionesDecoration = BoxDecoration(
    color: const Color(0xFFfbfdf9),
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  static const BoxDecoration prediccionItemDecoration = BoxDecoration(
    border: Border(bottom: BorderSide(color: Color(0xFFedf5e9))),
  );

  static const TextStyle prediccionNombreStyle = TextStyle(
    color: titleColor,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle prediccionValorStyle = TextStyle(
    color: Color(0xFF55a820),
    fontSize: 14,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle otrasCondicionesStyle = TextStyle(
    color: Color(0xFF6b8177),
    fontSize: 12,
    fontStyle: FontStyle.italic,
  );

  // Sensores y Lesion
  static BoxDecoration sensorLesionDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle sensorLesionLabelStyle = TextStyle(
    color: textLightColor,
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle sensorLesionValorStyle = TextStyle(
    color: titleColor,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  // Recomendaciones
  static BoxDecoration recomendacionOkDecoration = BoxDecoration(
    color: const Color(0xFFeaf7e5),
    border: Border.all(color: const Color(0xFFc8e6c9)),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration recomendacionWarnDecoration = BoxDecoration(
    color: const Color(0xFFfff9e6),
    border: Border.all(color: const Color(0xFFffe0b2)),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration recomendacionCritDecoration = BoxDecoration(
    color: const Color(0xFFffebee),
    border: Border.all(color: const Color(0xFFffcdd2)),
    borderRadius: BorderRadius.circular(8),
  );

  static const Color iconOkColor = Color(0xFF55a820);
  static const Color iconWarnColor = Color(0xFFb56c07);
  static const Color iconCritColor = Color(0xFFc62828);

  static const TextStyle recHeaderStyle = TextStyle(
    color: titleColor,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle recMessageStyle = TextStyle(
    color: textDarkColor,
    fontSize: 14,
    height: 1.5,
  );

  static const BoxDecoration recAccionDecoration = BoxDecoration(
    border: Border(top: BorderSide(color: Color.fromRGBO(7, 61, 43, 0.1))),
  );

  static const TextStyle recAccionTitleStyle = TextStyle(
    color: titleColor,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static BoxDecoration sinRecomendacionesDecoration = BoxDecoration(
    border: Border.all(color: const Color(0xFFaac0b3), style: BorderStyle.solid), // dashed not supported in standard Border.all, using solid as fallback
    borderRadius: BorderRadius.circular(8),
  );

  // Modal Actions
  static const BoxDecoration modalActionsDecoration = BoxDecoration(
    border: Border(top: BorderSide(color: borderColor)),
  );

  static BoxDecoration submitBtnDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF073d2b), Color(0xFF55a820)],
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.24),
        blurRadius: 28,
        offset: Offset(0, 16),
      ),
    ],
  );

  static const TextStyle submitBtnStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
