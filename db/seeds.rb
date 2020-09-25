john = User.create(username: "John123", email: "John123@hotmail.com", password: "password")
tweet_one = Tweet.create(content: "This is a tweet")
tweet_two = Tweet.create(content: "This is a tweet also")
john.tweets << tweet_one
john.tweets << tweet_two
