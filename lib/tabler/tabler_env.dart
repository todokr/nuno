import 'dart:io' show Platform;

class TablerEnv {
  final String inFilePath;
  final String outFilePath;

  TablerEnv(this.inFilePath, this.outFilePath);

  static TablerEnv init() {
    final envVars = Platform.environment;

    return TablerEnv(
      envVars['IN_FILE'] ?? './web/public/out.json',
      envVars['OUT_FILE'] ?? './web/public/tabled_out.csv'
    );
  }
}
