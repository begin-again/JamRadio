$(document).ready(function() {
    var audioSection = $('section#audio');
    var trackRows = $('.tracks tbody tr')
    $('a.html5').click(function() {

        var audio = $('<audio>', {
             controls : 'controls',
             autoplay : 'autoplay'
        });

        var url = $(this).attr('href');
        $('<source>').attr('src', url).appendTo(audio);
        trackInfo.html('<p>' + play_name + '</p>');
        audioSection.html(audio);
        return false;
    });
    $('.tracks tbody tr td').not('.dl').click(function() {

        var audio = $('<audio>', {
             controls : 'controls',
             autoplay : 'autoplay'
        });

        var url = $(this).parent().find('a.html5').attr('href');
        $('<source>').attr('src', url).appendTo(audio);
        audioSection.html(audio);
        return false;
    });

});
