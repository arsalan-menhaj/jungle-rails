const jquery = require('jquery');

$(document).ready( function {
  (".new-review-toggle").click( function {
    (".new-review").slideToggle()
  });
});