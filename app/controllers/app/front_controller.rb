module App
  # FrontsController
  class FrontController < AppController
    layout 'layouts/templates/application'

    def index
      @downloads = Download.all
    end

    def contact
      @message = Message.new
    end

    def thanks
    end

    def censo
      @censos = Censu.new
    end
  end
end
