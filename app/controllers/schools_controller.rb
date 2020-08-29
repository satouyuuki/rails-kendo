class SchoolsController < ApplicationController
  def index
    schools = School.select(:id, :name)
    render json: schools
  end
  def create
    school = School.new(school_params)
    if school.save
      render json: school
    else
      render json: school.errors
    end
  end
  private
  def school_params
    params.require(:school).permit(:name)
  end
end
