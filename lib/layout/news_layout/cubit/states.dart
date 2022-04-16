abstract class NewsStates {}

class NewsInitialStates extends NewsStates {}

class NewsBottomNavStates extends NewsStates {}

class NewsLoadingBusinessStates extends NewsStates {}

class NewsGetBusinessSuccessStates extends NewsStates {}

class NewsGetBusinessErrorStates extends NewsStates {
  late final String error;
  NewsGetBusinessErrorStates(this.error);
}

class NewsLoadingSportStates extends NewsStates {}

class NewsGetSportSuccessStates extends NewsStates {}

class NewsGetSportErrorStates extends NewsStates {
  late final String error;
  NewsGetSportErrorStates(this.error);
}

class NewsLoadingSciencesStates extends NewsStates {}

class NewsGetSciencesSuccessStates extends NewsStates {}

class NewsGetSciencesErrorStates extends NewsStates {
  late final String error;
  NewsGetSciencesErrorStates(this.error);
}

class NewsLoadingSearchStates extends NewsStates {}

class NewsGetSearchSuccessStates extends NewsStates {}

class NewsGetSearchErrorStates extends NewsStates {
  late final String error;
  NewsGetSearchErrorStates(this.error);
}

class NewsChangeThemeStates extends NewsStates {}