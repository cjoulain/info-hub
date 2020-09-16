class AnswersController < ApplicationController

  def index
    @question = Question.find_by(id: params[:question_id])
    if @question 
      render json: @question.answers
    else 
      render json: { message: "Unable to find Question." }, status: 404
    end    
  end

  # GET /questions/:id/answers/:id
  def show 
    @answer = Answer.find_by(id: params[:id])
    if @answer
      render json: @answer 
    else
      render json: { message: "This answer does not exist." }, status: 404
    end
  end

  # POST /questions/:id/answers/:id
  def create 
    @question = Question.find_by(id: params[:question_id])
    if @question
      @answer = @question.answers.new(answer_params)
      if @answer.save
        render json: @answer, status: 201 
      else 
        render json: @answer.errors.full_messages, status: 400
      end
    else
      render json: { error: "A valid question is needed to post an an answer."}, status: 404
    end
  end

  # PUT /questions/:id/answers/:id
  def update 
    @question = Question.find_by(id: params[:question_id])
    if @question
      @answer = @question.answers.find_by(id: params[:id]) # this checks by ID in case there are multiple answers
      if @answer.update(answer_params)
        render json: { message: 'Answer successfully updated.' }, status: 200 
      else 
        render json: @answer.errors.full_messages, status: 400
      end
    else 
      render json: { error: 'Unable to update Answer.' }, status: 404
    end
  end

  # DELETE /questions/:id/answers/:id
  def destroy
    @question = Question.find_by(id: params[:question_id])
    if @question
      @answer = @question.answers.find_by(id: params[:id])
      if @answer 
        @answer.destroy
        render json: { message: 'Answer successfully deleted.' }, status: 200
      else 
        render json: { error: 'Unable to delete Answer.' }, status: 400 
      end
    else 
      render json: { error: 'Unable to find Question.' }, status: 404
    end
  end

  private 

  def answer_params
    params.require(:answer).permit(:body)
  end

end
