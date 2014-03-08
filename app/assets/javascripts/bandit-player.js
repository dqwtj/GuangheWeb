function BanditPlayer() {
  var self = this,
  pl = this,
  ua = navigator.userAgent,
  isTouchDevice = (ua.match(/ipad|ipod|iphone/i)),
  sm = soundManager;
  this.excludeClass = 'link-exclude';
	
  this.css = {
	// CSS class names appended to link during various states
    sDefault: 'bandit-player-panel', // default state
    sLoading: 'bandit-player-loading',
    sPlaying: 'bandit-player-playing',
    sPaused: 'bandit-player-paused'
  };
  
  this.includeClass = this.css.sDefault;
    
  this.getFormattedTime = function(nMSec) {
  	var sec = parseInt(nMSec/1000) % 60;
	var min = parseInt(nMSec/60000);
	return min + ':' + ((sec<10) ? '0'+sec : sec);
  };
  
  this.init = function() {
    sm._writeDebug('soundPlayer.init()');
    var oLink = $("#bandit-upyun-link");
    var bplayer = $("#bandit-player");
    bplayer.addClass(self.css.sDefault);
    if ((sm.getSoundById(oLink.attr("id")) == null) && (sm.canPlayURL(oLink.text()))) {
      sm.createSound({
      	id: oLink.attr("id"),
      	url: oLink.text(),
      });
    };
    sm._writeDebug('soundPlayer.init(): Loading Song:' + oLink.attr("id") +' from ' + oLink.text() );
        
    $(".play-button").click(function() {
      var sid = $(this).parent().siblings("a").text();
      var panel = $(this).parent().parent();
      var thisSound = sm.getSoundById(oLink.attr("id"));
      
      if (panel.hasClass(pl.css.sDefault)) {
      	pl.banOtherSounds();
        
        sm.play(sid, {
          onplay: function() {
          	panel.removeClass(pl.css.sDefault);
            panel.addClass(pl.css.sPlaying);
          },
          onpause: function() {
          	panel.removeClass(pl.css.sPlaying);
            panel.addClass(pl.css.sPaused);
          },
          onresume: function() {
          	panel.removeClass(pl.css.sPaused);
            panel.addClass(pl.css.sPlaying);
          },
          onstop: function() {
          	panel.removeClass(pl.css.sPlaying);
          	panel.removeClass(pl.css.sPaused);
            panel.addClass(pl.css.sDefault);
          },
          onfinish: function() {
          	panel.removeClass(pl.css.sPlaying);
          	panel.addClass(pl.css.sDefault);
          },
          whileloading: function() {
          	lBar.css("width", 100*this.bytesLoaded/this.bytesTotal + '%');
          },
          whileplaying: function() {
          	pTime.text(pl.getFormattedTime(this.position));
          	pBar.css("width", 100*this.position/this.durationEstimate + '%');
          },
        });
      } else if (panel.hasClass(pl.css.sPlaying)) {
        thisSound.pause();
      } else if (panel.hasClass(pl.css.sPaused)) {
        pl.banOtherSounds();
        thisSound.resume();
      }
            
    });
    
  };

  this.init();
  
}

var soundPlayer = null;

soundManager.setup({
	debugMode: false,
	consoleOnly: false,
	preferFlash: false,
    url: '/swf',
	flashversion: 9
});
