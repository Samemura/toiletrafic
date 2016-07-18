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
    var msg = "トイレ" + data['boothId'] + ((data['boothState'] == "vacant") ? " が空きましたよ！" : " が使用されました。") ;

    $('#booth-'+data['boothId']).removeClass('booth-state-animation'); // removeClass -> addClass need process so should be before alert.
    alert(msg);
    $('#booth-'+data['boothId']).html(data['html']);
    $('#booth-'+data['boothId']).addClass('booth-state-animation');
  },

  traffic: function(msg) {
    return this.perform('traffic', {message: msg});
  }
});
