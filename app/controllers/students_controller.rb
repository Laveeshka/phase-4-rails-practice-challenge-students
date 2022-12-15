class StudentsController < ApplicationController

    def index
        students = Student.all 
        render json: students
    end

    def show
        student = Student.find_by(id: params[:id])
        if student
            render json: student, status: :ok
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    def create
        student = Student.create!(students_params)
        render json: student, status: :created
        rescue ActiveRecord::RecordInvalid => invalid
            render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def update
        student = Student.find_by(id: params[:id])
        if student
            student.update(students_params)
            render json: student, status: :partial_content
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    def destroy
        student = Student.find_by(id: params[:id])
        if student
            student.destroy
        else
            render json: {error: "Student not found"}, status: :not_founds
        end
    end

    private
    
    def students_params
        params.permit(:name, :age, :major, :instructor_id)
    end

end
