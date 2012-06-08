define ['view/admin/page', 'text!templates/admin/home_page.handlebars'],
(AdminPageView, hbs_template) ->
  class AdminHomePageView extends AdminPageView
    template: hbs_template
