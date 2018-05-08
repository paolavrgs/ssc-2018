module App
  # FrontsController
  class FrontController < AppController
    layout 'layouts/templates/application'

    def index
      @downloads = Download.all
    end

    def contact
    end
  end
end
