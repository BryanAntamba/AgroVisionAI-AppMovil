import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/admin/plataforma-editable.dart';
import 'package:frontend/shared/services/tema.service.dart';

void main() {
  testWidgets('PlataformaEditable renders without crashing', (WidgetTester tester) async {
    // Inicializar TemaService si es necesario
    // await TemaService.instance.cargar();

    await tester.pumpWidget(const MaterialApp(
      home: PlataformaEditable(),
    ));

    expect(find.byType(PlataformaEditable), findsOneWidget);
  });
}
