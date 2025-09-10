import 'package:flutter/material.dart';

// Demonstrando conceitos de front-end: cores, tipografia e layout responsivo
class AppTheme {
  // Paleta de cores personalizada
  static const Color primaryRed = Color(0xFFE63946); // Vermelho mais vibrante
  static const Color primaryRedLight = Color(0xFFFF6B75); // Tom mais suave
  static const Color primaryRedDark = Color(0xFFB00020); // Tom mais escuro equilibrado
  
  static const Color secondaryOrange = Color(0xFFF77F00); // Laranja mais intenso
  static const Color secondaryOrangeLight = Color(0xFFFFB046); // Tom dourado
  static const Color secondaryOrangeDark = Color(0xFFC56000); // Tom terroso
  
  static const Color accentGreen = Color(0xFF4CAF50); // Verde para contraste
  static const Color accentGreenLight = Color(0xFF80E27E);
  
  static const Color backgroundLight = Color(0xFFFAFAFA); // Cinza muito claro
  static const Color backgroundDark = Color(0xFF1B1B1B); // Preto mais suave
  
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF2A2A2A); // Cinza escuro moderno
  static const Color surfaceElevated = Color(0xFF3A3A3A); // Para cards no tema escuro
  
  static const Color textPrimary = Color(0xFF1A202C); // Azul escuro suave
  static const Color textSecondary = Color(0xFF718096); // Cinza azulado
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFFA0AEC0); // Para textos menos importantes
  
  // Tipografia personalizada
  static const String fontFamily = 'Roboto';
  
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
    letterSpacing: -0.5,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
    letterSpacing: -0.25,
  );
  
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    letterSpacing: 0.1,
  );
  
  // Tema claro
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Esquema de cores moderno
    colorScheme: const ColorScheme.light(
      primary: primaryRed,
      primaryContainer: primaryRedLight,
      secondary: secondaryOrange,
      secondaryContainer: secondaryOrangeLight,
      tertiary: accentGreen,
      tertiaryContainer: accentGreenLight,
      surface: surfaceLight,
      surfaceVariant: Color(0xFFF7FAFC),
      background: backgroundLight,
      error: Color(0xFFE53E3E),
      onPrimary: textLight,
      onPrimaryContainer: textPrimary,
      onSecondary: textLight,
      onSecondaryContainer: textPrimary,
      onTertiary: textLight,
      onTertiaryContainer: textPrimary,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      onBackground: textPrimary,
      onError: textLight,
      outline: Color(0xFFE2E8F0),
      shadow: Color(0x1A000000),
    ),
    
    // Tipografia
    textTheme: const TextTheme(
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      labelLarge: labelLarge,
    ),
    
    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryRed,
      foregroundColor: textLight,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textLight,
        fontFamily: fontFamily,
      ),
    ),
    
    // Botões com design moderno
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryRed,
        foregroundColor: textLight,
        textStyle: labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2,
        shadowColor: primaryRed.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    // Botões de texto
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryRed,
        textStyle: labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    // Cards com design moderno
    cardTheme: CardThemeData(
      color: surfaceLight,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // Input
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryRed, width: 2),
      ),
      labelStyle: const TextStyle(
        color: textSecondary,
        fontFamily: fontFamily,
      ),
      hintStyle: const TextStyle(
        color: textSecondary,
        fontFamily: fontFamily,
      ),
    ),
  );
  
  // Tema escuro
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    
    colorScheme: const ColorScheme.dark(
      primary: primaryRedLight,
      primaryContainer: primaryRedDark,
      secondary: secondaryOrangeLight,
      secondaryContainer: secondaryOrangeDark,
      tertiary: accentGreenLight,
      tertiaryContainer: accentGreen,
      surface: surfaceDark,
      surfaceVariant: surfaceElevated,
      background: backgroundDark,
      error: Color(0xFFFC8181),
      onPrimary: textPrimary,
      onPrimaryContainer: textLight,
      onSecondary: textPrimary,
      onSecondaryContainer: textLight,
      onTertiary: textPrimary,
      onTertiaryContainer: textLight,
      onSurface: textLight,
      onSurfaceVariant: textMuted,
      onBackground: textLight,
      onError: textPrimary,
      outline: Color(0xFF4A5568),
      shadow: Color(0x33000000),
    ),
    
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
        letterSpacing: -0.5,
        color: textLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
        letterSpacing: -0.25,
        color: textLight,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        color: textLight,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: textLight,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
        height: 1.5,
        color: textLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: fontFamily,
        height: 1.4,
        color: textLight,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        letterSpacing: 0.1,
        color: textLight,
      ),
    ),
  );
  
  // Breakpoints para layout responsivo
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;
  
  // Função para determinar o tipo de dispositivo
  static DeviceType getDeviceType(double width) {
    if (width < mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
  
  // Padding responsivo
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return const EdgeInsets.all(16);
      case DeviceType.tablet:
        return const EdgeInsets.all(24);
      case DeviceType.desktop:
        return const EdgeInsets.all(32);
    }
  }
  
  // Número de colunas responsivo para grids
  static int getResponsiveColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return 2;
      case DeviceType.tablet:
        return 3;
      case DeviceType.desktop:
        return 4;
    }
  }
  
  // Largura máxima do conteúdo
  static double getMaxContentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return width;
      case DeviceType.tablet:
        return 800;
      case DeviceType.desktop:
        return 1200;
    }
  }
}

// Enum para tipos de dispositivo
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

// Widget responsivo personalizado
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  
  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = AppTheme.getDeviceType(width);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}

// Widget para centralizar conteúdo com largura máxima
class CenteredContent extends StatelessWidget {
  final Widget child;
  
  const CenteredContent({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    final maxWidth = AppTheme.getMaxContentWidth(context);
    
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}