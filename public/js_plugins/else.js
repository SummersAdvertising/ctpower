function fetch_video_url(link){
  var video = new Object();
  video.type = "video";

  var providerList = ["youtube", "vimeo"];
  for( var p in providerList ) {
    var re = new RegExp("/.*" + providerList[p] + ".*/", "g");
    if ( re.test(link) ) {
      video.provider = providerList[p];
    }
  }

  if(video.provider){
    switch(video.provider){
      case "vimeo":
      var sourceLink = "http://player.vimeo.com/video/";
      var code = /[a-zA-Z0-9\?\.\:]+\/([a-zA-Z0-9_\-]+)&?.*/.exec(link)[1];
      video.embedcode = sourceLink + code;
      break;
      
      case "youtube":
      var sourceLink = "http://www.youtube.com/embed/";
      var code = /[a-zA-Z0-9\?\.\:\/&=]+v=([a-zA-Z0-9_\-]+)&?.*/.exec(link)[1];
      video.embedcode = sourceLink + code;
      break;
    }
    $("#vLink").attr('href',sourceLink + code);
    // output(video);
    return sourceLink + code;
    // return video;
  }
  else{
    return false;
  }
};