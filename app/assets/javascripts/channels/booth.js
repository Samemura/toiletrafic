window.onload = function() {
  // $('#booth-1').style.webkitAnimationPlayState="paused";
};

App.booth = App.cable.subscriptions.create("BoothChannel", {
  connected: function() {
    console.log("BoothChannel connected.");
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    console.log('received via channel.');
    console.dir(data);
    alert("トイレ" + data['boothId'] + " が空きましたよ！");
    // TODO: html が正しくリロードできない。入れ子になる。
    $('#booth-'+data['boothId']).html(data['message']);
    // $('#booth-'+data['boothId']).outerHTML(data['message']); // outerHTML is not trigger animation.
    $('#booth-'+data['boothId']).addClass('booth-state-animation');
  },

  traffic: function(msg) {
    return this.perform('traffic', {message: msg});
  }
});
