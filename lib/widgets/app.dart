import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ciart_studio/providers/ui.dart';
import 'package:ciart_studio/repositories/document_repository.dart';
import 'package:ciart_studio/widgets/bars/menu_bar.dart';
import 'package:ciart_studio/widgets/bars/property_bar.dart';
import 'package:ciart_studio/widgets/bars/tool_bar.dart';
import 'package:ciart_studio/widgets/panels/color_picker_panel.dart';
import 'package:ciart_studio/widgets/panels/layer_panel.dart';
import 'package:ciart_studio/widgets/panels/palette_panel.dart';
import 'package:ciart_studio/widgets/panels/workspace_panel.dart';
import 'package:ciart_studio/widgets/bars/title_bar.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nabi/nabi.dart';

import 'bars/status_bar.dart';

const title = 'Ciart Studio';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DocumentRepository(),
      child: FluentApp(
        title: title,
        color: const Color(0xFFFFFFFF),
        debugShowCheckedModeBanner: false,
        theme: FluentThemeData(
          brightness: Brightness.light,
          accentColor: Colors.teal,
        ),
        home: Column(
          children: [
            TitleBar(),
            Expanded(
              child: MenuBar(
                child: Column(
                  children: [
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final layout = ref.watch(layoutProvider);

                          return Nabi(
                            registeredWidgets: {
                              'propertyBar': (context) => PropertyBar(),
                              'toolBar': (context) => ToolBar(),
                              'workspacePanel': (context) => WorkspacePanel(),
                              'colorPicker': (context) => ColorPickerPanel(),
                              'layerPanel': (context) => LayerPanel(),
                              'palettePanel': (context) => PalettePanel(),
                            },
                            layout: layout,
                          );
                        },
                      ),
                    ),
                    StatusBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
