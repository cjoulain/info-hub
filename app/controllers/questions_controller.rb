class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    render json: @questions
  end

    def new
      @question = Question.new(question_params)
      render 'questions/new'
    end 

    # GET /question/:id
    def show 
      @question = Question.find_by(id: params[:id])
      if @question
        render json: @question 
      else
        render json: { message: "This question does not exist." }, status: 404
      end
    end
  
    # POST /questions
    def create 
      @question = Question.new(question_params)
      if @question.save
        render json: @question, status: 201 
      else 
        render json: @question.errors.full_messages, status: 400
      end
    end

    # PUT /questions/:id
    def update 
      @question = Question.find_by(id: params[:id])
      if @question 
        if @question.update(question_params)
          render json: { message: 'Question successfully updated.' }, status: 200 
        else 
          render json: @question.errors.full_messages, status: 400
        end
      else 
        render json: { message: 'Unable to update Question.' }, status: 404
      end
    end

    # DELETE /questions/:id
    def destroy
      @question = Question.find_by(id: params[:id])
      if @question 
        @question.destroy
        render json: { message: 'Question successfully deleted.' }, status: 200
      else 
        render json: { error: 'Unable to delete Question.' }, status: 400 
      end
    end

    private 

    def question_params
      params.require(:question).permit(:title, :body)
    end
  
end
