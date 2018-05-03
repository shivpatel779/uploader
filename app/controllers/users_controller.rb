class UsersController < InheritedResources::Base

  helper_method :sort_column, :sort_direction

  def index
    @users = User.perform_search(params[:search]).order(sort_column + " " + sort_direction).paginate(per_page:10, page:params[:page])
  end

  def import
    if User.import(params[:file])
      flash[:notice] = "Users imported successfully."
      redirect_to users_path, notice: "Users has been successfully imported."
    else
      flash[:error] = "Something went wrong. Please check the file format."
      render 'welcome/upload'
    end
  end

  private

  def sort_column
    params[:sort] ||= 'name'
  end

  def sort_direction
    params[:direction] ||= 'asc'
  end

end
