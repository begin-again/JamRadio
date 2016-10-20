$(document).ready(function() {
    var audioSection = $('section#audio');
    var trackInfo = $('#info');
    $('a.html5').click(function() {

        var audio = $('<audio>', {
             controls : 'controls',
             autoplay : 'autoplay'
        });

        var url = $(this).attr('href');
        var play_name = $(this).data('playing');
        $('<source>').attr('src', url).appendTo(audio);
        trackInfo.html('<p>' + play_name + '</p>');
        audioSection.html(audio);
        return false;
    });
});
