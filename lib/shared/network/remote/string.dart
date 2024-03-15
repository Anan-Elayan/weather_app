
extension AppStirng on String{
  String get baseUrlNames => 'api.openweathermap.org';
  String get baseUrl => '/data/2.5/weather?$this';
  String get units => 'metric';

  String get getApiKey => '5bba37098cfae28869ff0cd853fbf98a';

}