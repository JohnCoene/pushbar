var pushbar; 

Shiny.addCustomMessageHandler('pushbar-setup', function(opts) {
  pushbar = new Pushbar(opts);
});
Shiny.addCustomMessageHandler('pushbar-open', function(id) {
  pushbar.open(id);
});

Shiny.addCustomMessageHandler('pushbar-close', function(msg) {
  pushbar.close();
});