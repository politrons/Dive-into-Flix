
//Using [spawn] operator, we run the function in another 
// green thread.
def asyncProcess(str:String):Unit & Impure=
     spawn String.toUpperCase(str)

//Based on Golang Channels, flix use excactly the same syntax, to run process async, and comunicate between threads using this channels
//We create a channel using [chan type] and the number of bytes of buffer, in case of 0 no limit.
def channelFeature():Unit & Impure = 
     let channel = chan String 0;
     publisherProcess(channel);
     consumerProcess(channel)
          
//Using a [Channel] we can write in that channel using syntax [channel <- message]         
def publisherProcess(channel:Channel[String]):Unit & Impure =
     spawn channel <- "Hello world from another thread."

//Using a [Channel] we can read in that channel using syntax [let message =  <- channel]     
//The behavior of the channel will block the thread until a message arrive.    
def consumerProcess(channel:Channel[String]):Unit & Impure =
     let response = <- channel;
     println("Async response from [publisherProcess]: ${response}")

//To achieve parallel computing, is so simple like create two channels and run two process
//async using [spawn] and make them write output in the channel.
//Then in the main thread we just need to merge them reading from both channels.
def parallelCompurting():Unit & Impure =
     let channel1 = chan String 0;
     let channel2 = chan String 0;
     let task1:Channel[String] -> String -> Unit & Impure=  (channel,a) -> spawn channel <- "[${a}]";
     let task2:Channel[String] -> String -> Unit & Impure =  channel -> a -> spawn channel <- "***${a}***";
     task1(channel1)("Hello parallel world");
     task2(channel2)("Hello parallel world");
     let response = "Merge results: ${<- channel1}-${<- channel2}";
     println(response)

//In order to achieve this pattern, where we make composition between async task, we just need to pass 
// The channel from the first async task to the second one. Then the second task it will be wait until 
//The first task finish his computation and write back to the channel.
 def compositionAsync():Unit & Impure =
     let channel3 = chan String 0;
     let channel4 = chan String 0;
     let task1:Channel[String] -> String -> Unit & Impure=  
     (channel,a) -> spawn channel <- "Output of first task ${a}]";
     let task2:Channel[String] -> Channel[String] -> String -> Unit & Impure =  
          channel1 -> channel2 -> a -> spawn channel2 <- "Composing ${a} with previous async task output - " + <- channel1;
     task1(channel3)("Hello async composition world");
     task2(channel3)(channel4)("Hello flatMap world");
     let response = "FlatMap results: ${<- channel4}";
     println(response)    