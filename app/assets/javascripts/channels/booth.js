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
    $('#booth-'+data['boothId']).html(data['message']);
  },

  traffic: function(msg) {
    return this.perform('traffic', {message: msg});
  }
});
