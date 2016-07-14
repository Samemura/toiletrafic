App.booth = App.cable.subscriptions.create("BoothChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    console.log('received via channel.');
    console.dir(data);
    $('#booths').append(data['message']);
  },

  traffic: function(msg) {
    return this.perform('traffic', {message: msg});
  }
});
