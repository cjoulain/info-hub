class AnswersController < ApplicationController
  def index
    @answers = Answer.all
    render json: @answers
  end

    def new
      @answer = Answer.new(answer_params)
      render 'new'
    end 

    # GET /answer/:id
    def show 
      @answer = Answer.find_by(id: params[:id])
      if @answer
        render json: @answer 
      else
        render json: { message: "This answer does not exist." }, status: 404
      end
    end
  
    # POST /answers
    def create 
      @answer = Answer.new(answer_params)
      if @answer.save
        render json: @answer, status: 201 
      else 
        render json: @answer.errors.full_messages, status: 400
      end
    end

    # PUT /answers/:id
    def update 
      @answer = Answer.find_by(id: params[:id])
      if @answer 
        if @answer.update(answer_params)
          render json: { message: 'Answer successfully updated.' }, status: 200 
        else 
          render json: @answer.errors.full_messages, status: 400
        end
      else 
        render json: { message: 'Unable to update Answer.' }, status: 404
      end
    end

    # DELETE /answers/:id
    def destroy
      @answer = Answer.find_by(id: params[:id])
      if @answer 
        @answer.destroy
        render json: { message: 'Answer successfully deleted.' }, status: 200
      else 
        render json: { error: 'Unable to delete Answer.' }, status: 400 
      end
    end

    private 

    def answer_params
      params.require(:answer).permit(:title, :body)
    end

end
