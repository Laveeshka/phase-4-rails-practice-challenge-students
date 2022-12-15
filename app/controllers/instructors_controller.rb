class InstructorsController < ApplicationController
  def index
    instructors = Instructor.all
    render json: instructors
  end

  def show
    instructor = Instructor.find_by(id: params[:id])
    if instructor
        render json: instructor, status: :ok
    else
        render json: {error: "Instructor not found"}, status: :not_found
    end
  end

  def create
    instructor = Instructor.create!(instructors_params)
    render json: instructor, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    instructor = Instructor.find_by(id: params[:id])
    if instructor
        instructor.update(instructors_params)
        render json: instructor, status: :partial_content
    else
        render json: {error: "Instructor not found"}, status: :not_found
    end
  end

  def destroy
    instructor = Instructor.find_by(id: params[:id])
    if instructor
        instructor.destroy
    else
        render json: {error: "Instructor not found"}, status: :not_found
    end
  end

  private

  def instructors_params
    params.permit(:name)
  end
end
