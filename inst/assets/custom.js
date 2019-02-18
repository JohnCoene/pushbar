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

var triggers;

document.addEventListener("DOMContentLoaded", function() {
  
  triggers = document.querySelectorAll(`[data-pushbar-id]`);

  [].forEach.call(triggers, function(el) {

    // set true
    el.addEventListener('pushbar_opening', function(e){
      Shiny.onInputChange(el.id + "_pushbar_opened:pushbarParse", true);
    });

    // set false
    el.addEventListener('pushbar_closing', function(e){
      Shiny.onInputChange(el.id + "_pushbar_opened:pushbarParse", false);
    });

  });
});

