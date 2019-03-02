function stringFromSecond(length) {
    var h, m, s;
    h = Math.floor(length/3600);
    m = Math.floor((length % 3600) / 60);
    s = (length % 3600) % 60;
    return ("00" + h).substr(-2) + ":" + ("00" + m).substr(-2) + ":" + ("00" + s).substr(-2);
 }

function playMusic(name, location) {
  $(name)[0].currentTime = location;
  $(name)[0].play();
}

function forwardMusic(name, value, max) {
  loc = $(name)[0].currentTime
  loc = loc + value

  if (loc < 0) {
    loc = 0;
  }

  if (loc > max) {
    loc = max;
  }

  $(name)[0].currentTime = loc;

  return loc;
}

function remove_alert() {
  $('.flash').children().remove();
}