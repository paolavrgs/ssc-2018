module Admin
  # CensusController
  class CensusController < AdminController
    before_action :authenticate_user!, except: %i[new create]
    before_action :set_censu, only: [:show, :edit, :update, :destroy]
    before_action :show_history, only: [:index]
    before_action :set_attachments

    # GET /census
    def index
      @q = Censu.ransack(params[:q])
      census = @q.result(distinct: true)
      @objects = census.page(@current_page).order(position: :desc)
      @total = census.size
      @census = @objects.order(:position)
      if !@objects.first_page? && @objects.size.zero?
        redirect_to census_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /census/1
    def show
    end

    # GET /census/new
    def new
      @censu = Censu.new
      authorize Censu
    end

    # GET /census/1/edit
    def edit
      authorize Censu
    end

    # POST /census
    def create
      @censu = Censu.new(censu_params)

      if @censu.save
        # redirect(@censu, params)
        redirect_to app_censoexito_es_path(@censu.id)
      else
        render :new
      end
    end

    # PATCH/PUT /census/1
    def update
      if @censu.update(censu_params)
        redirect(@censu, params)
      else
        render :edit
      end
      authorize Censu
    end

    def clone
      @censu = Censu.clone_record params[:censu_id]

      if @censu.save
        redirect_to admin_census_path
      else
        render :new
      end
      authorize Censu
    end

    # DELETE /census/1
    def destroy
      @censu.destroy
      redirect_to admin_census_path, notice: actions_messages(@censu)
      authorize Censu
    end

    def destroy_multiple
      Censu.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        admin_census_path(page: @current_page, search: @query),
        notice: actions_messages(Censu.new)
      )
      authorize Censu
    end

    def import
      Censu.import(params[:file])
      redirect_to(
        admin_census_path(page: @current_page, search: @query),
        notice: actions_messages(Censu.new)
      )
      authorize Censu
    end

    def download
      @census = Censu.all
      respond_to do |format|
        format.html
        format.xls { send_data(@census.to_xls) }
        format.json { render :json => @census }
      end
      authorize Census
    end

    def reload
      @q = Censu.ransack(params[:q])
      census = @q.result(distinct: true)
      @objects = census.page(@current_page).order(position: :desc)
    end

    def sort
      Censu.sorter(params[:row])
      render :index
    end

    private

    def set_attachments
      @attachments = ['logo', 'brand', 'photo', 'avatar', 'cover', 'image',
                      'picture', 'banner', 'attachment', 'pic', 'file']
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_censu
      @censu = Censu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def censu_params
      params.require(:censu).permit(:name, :last_name, :calle, :casa,
                                    :piso, :edad, :sector, :birthdate,
                                    :profesion, :nivel_estudio, :position, :jefe_familia)
    end

    def show_history
      get_history(Censu)
    end
  end
end
