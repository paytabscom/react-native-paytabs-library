export default class PaymentSDKTheme {
  constructor(
    logoImage = null,
    primaryColor = null,
    primaryColorDark = null,
    primaryFontColor = null,
    primaryFontColorDark = null,
    primaryFont = null,
    secondaryColor = null,
    secondaryColorDark = null,
    secondaryFontColor = null,
    secondaryFontColorDark = null,
    secondaryFont = null,
    strokeColor = null,
    strokeColorDark = null,
    strokeThickness = null,
    inputsCornerRadius = null,
    buttonColor = null,
    buttonFontColor = null,
    buttonFont = null,
    titleFontColor = null,
    titleFontColorDark = null,
    titleFont = null,
    backgroundColor = null,
    backgroundColorDark = null,
    placeholderColor = null,
    placeholderColorDark = null
  ) {
    this.logoImage = logoImage;
    this.primaryColor = primaryColor;
    this.primaryColorDark = primaryColorDark;
    this.primaryFontColor = primaryFontColor;
    this.primaryFontColorDark = primaryFontColorDark;
    this.primaryFont = primaryFont;
    this.secondaryColor = secondaryColor;
    this.secondaryColorDark = secondaryColorDark;
    this.secondaryFontColor = secondaryFontColor;
    this.secondaryFontColorDark = secondaryFontColorDark;
    this.secondaryFont = secondaryFont;
    this.strokeColor = strokeColor;
    this.strokeColorDark = strokeColorDark; // Corrected typo from strokeThinckness to strokeThickness
    this.strokeThickness = strokeThickness;
    this.inputsCornerRadius = inputsCornerRadius;
    this.buttonColor = buttonColor;
    this.buttonFontColor = buttonFontColor;
    this.buttonFont = buttonFont;
    this.titleFontColor = titleFontColor;
    this.titleFontColorDark = titleFontColorDark;
    this.titleFont = titleFont;
    this.backgroundColor = backgroundColor;
    this.backgroundColorDark = backgroundColorDark;
    this.placeholderColor = placeholderColor;
    this.placeholderColorDark = placeholderColorDark;
  }
}
