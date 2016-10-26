var audioSection = $('section#audio');
var trackInfo = $('#info');

//$('.tracks tfoot .prev').click()
function setListeners() {
  console.log('setListeners');
  $('.tracks tbody tr td').not('.dl, .artist, .album').click(function() {

    var audio = $('<audio>', {
         controls : 'controls',
         autoplay : 'autoplay'
    });

    var track_item = $(this).parent().find('a.html5');
    var url = $(track_item).attr('href');
    var play_name = $(track_item).data('playing');
    trackInfo.html('<p>' + play_name + '</p>');
    $('<source>').attr('src', url).appendTo(audio);
    audioSection.html(audio);
    return false;
  });
}

function getTracks(direction) {
  var url = '/tracks/next/' + direction;
  console.log("getTracks => " + url);
  $.ajax({
      type: 'post',
      url: url,
      dataType: 'html',
      timeout: 10000,
      async: true,

      success: function(data, textStatus, jqXHR)
      {
          replaceTracks(data);
      },
      error: function(data, textStatus, jqXHR) {
          console.log(textStatus);
      }
  });
}
// replace existing tbody
function replaceTracks(data) {
  console.log("replaceTracks called...");
  $('table.tracks tbody').html(data);
  $('.tracks tbody tr td').not('.dl, .artist, .album').click(function() {
    var audio = $('<audio>', {
         controls : 'controls',
         autoplay : 'autoplay'
    });

    var track_item = $(this).parent().find('a.html5');
    var url = $(track_item).attr('href');
    var play_name = $(track_item).data('playing');
    trackInfo.html('<p>' + play_name + '</p>');
    $('<source>').attr('src', url).appendTo(audio);
    audioSection.html(audio);
    return false;
  });
}

setListeners();
