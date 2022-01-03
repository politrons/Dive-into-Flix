
//Using [spawn] operator, we run the function in another 
// green thread.
def asyncProcess(str:String):Unit & Impure=
     spawn String.toUpperCase(str)

//Based on Golang Channels, flix use excactly the same syntax, to run process async.
// and comunicate between threads using this channels
//We create a channek using [chan type] and the number of bytes of buffer, in case of 0 no limit.
def channelFeature():Unit & Impure = 
     let channel = chan String 0;
     publisherProcess(channel);
     consumerProcess(channel)
          
def publisherProcess(channel:Channel[String]):Unit & Impure =
     spawn channel <- "Hello world from another thread."

def consumerProcess(channel:Channel[String]):Unit & Impure =
     let response = <- channel;
     println("Async response from [publisherProcess]: ${response}")