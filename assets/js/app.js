$(document).ready(function() {
    var audioSection = $('section#audio');
    var trackRows = $('.tracks tbody tr')
    var trackInfo = $('#info');

    $('.tracks tbody tr td').not('.dl').click(function() {

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

});
