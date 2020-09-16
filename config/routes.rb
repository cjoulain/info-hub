Rails.application.routes.draw do
  resources :questions do # /questions[/:id]
    resources :answers do # /questions/:question_id/answers/[:id]
    end
  end
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
