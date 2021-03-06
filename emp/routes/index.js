(function () {
  'use strict';

  module.exports = function createIndexRoute(app) {
    app.get('/', function (req, res, next) {
      const redirect = req.signedInUser ? '/transfer-information' : '/sign-in';
      res.redirect(redirect);
      next();
    });
  };
})();
