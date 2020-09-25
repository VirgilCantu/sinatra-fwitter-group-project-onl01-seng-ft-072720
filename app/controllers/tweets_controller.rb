class TweetsController < ApplicationController

    get "/tweets" do
        @tweets = Tweet.all
        if logged_in?
            erb :"tweets/tweets"
        else
            redirect "/login"   
        end
    end

    get "/tweets/new" do
        if logged_in?
            erb :"tweets/new"
        else
            redirect "/login"
        end
    end

    post "/tweets" do
        if logged_in? && current_user && params[:content] != ""
            tweet = Tweet.create(params)
            current_user.tweets << tweet
            redirect "/users/#{current_user.id}"
        else
            redirect "/tweets/new"
        end
    end

    get "/tweets/:id" do
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :"tweets/show_tweet"
        else
            redirect "/login"
        end
    end

    get "/tweets/:id/edit" do
        @tweet = Tweet.find_by(id: params[:id])
        if logged_in? && current_user == @tweet.user
            erb :"tweets/edit_tweet"
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        if params[:content] == ""
                redirect "/tweets/#{params[:id]}/edit"
        else
                @tweet.update(content: params[:content])  
                redirect to "/tweets/#{@tweet.id}"
        end
    end

    delete '/tweets/:id' do 
        @tweet = Tweet.find_by(id: params[:id])
        if logged_in? && current_user == @tweet.user
        @tweet.delete
        redirect "/users/#{current_user.id}"
        else
        redirect "/login"
        end
    end 

end
