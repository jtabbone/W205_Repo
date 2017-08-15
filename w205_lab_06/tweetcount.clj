(ns tweetcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetcount [options]
   [
    ;; spout configuration
    {"Sentences" (python-spout-spec
          options
          "spouts.sentences.Sentences"
          ["sentence"]
          )
    }
    ;; bolt configuration
    {"ParseTweet" (python-bolt-spec
          options
          {"Sentences" :shuffle}
          "bolts.parse.ParseTweet"
          ["word"]
          :p 2
          )
    
    "CounterBolt" (python-bolt-spec
          options
          {"ParseTweet" ["word"]}
          "bolts.tweetcounter.TweetCounter"
	  ["word" "count"]
          :p 2
     	  )
     }
    ]
)