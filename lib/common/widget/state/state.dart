class PageState {

  int _state = STATE_LOADING;

  get state => _state;
  set state(value) => _state = value;


  static const int STATE_LOADING = 0;
  static const int STATE_EMPTY = 1;
  static const int STATE_ERROR = 2;

}