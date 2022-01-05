//Future
//-------
def runFuture():Unit & Impure=
    getFuture();
    onCallbackFuture()

def getFuture():Unit & Impure=
    let future:Future[Channel[Result[String,String]]] =Future.run(()-> "hello future world" );
    let result:Result[String,String] = Future.get(future);
    println(result)

def onCallbackFuture():Unit & Impure=
    let future:Future[Channel[Result[String,String]]] =Future.run(()-> "hello future world" );
    Future.onComplete(v -> println("Success result:${String.toUpperCase(v)}"),
                      t -> println("Error result:${String.toUpperCase(t)}"), future)

enum Future[a] with ToString{
  case Future(a)
}

//We implement Functor [map] and Monad [flatMap], so it can be used as part of the 
//implementation of MyMonad
namespace Future {

    //Supplier function to run the function in another thread, and return a Future with a Channel[Result[b]]
    //So the execution run in another thread just like in Scala
    pub def run(f: Unit -> b & ef): Future[Channel[Result[b,String]]] & Impure=
        let chann:Channel[Result[b,String]] = chan Result[b,String] 0;
        spawn try {
            chann <- Ok(f())
        } catch {
            case e: ##java.lang.RuntimeException =>
                import java.lang.Throwable.getMessage();
                chann <- Err(getMessage(e)) 
        };
        Future(chann)

    //Blocking function to obtain future result.
    //We block channel until the message arrive, and then depending the result type
    //We return the specific result.
    pub def get(o: Future[Channel[Result[b,t]]]): Result[b,t] & Impure = 
        let result: Result[b,t] = match o {
            case Future(channel) => <- channel
        };
        match result {
            case Ok(v) => Ok(v)
            case Err(t) => Err(t)
        }  

    //We create a function that expect two Consumer functions, one for the success channel, and another for failure.
    pub def onComplete(f: b -> Unit & ef,e: t -> Unit & ef, o: Future[Channel[Result[b,t]]]): Unit & Impure = 
        let result: Result[b,t] = match o {
            case Future(channel) => <- channel
        };
        match result {
            case Ok(v) => f(v)
            case Err(t) => e(t)
        }

    /// pub def map(f: a -> b & ef, o: Future[a,t]): Future[b,t] & ef = match o {
    ///     case Wrong(t) => Wrong(t)
    ///     case Good(v) => Good(f(v))
    /// }

    /// pub def flatMap(f: a -> Future[b,t] & ef, o: Future[a,t]): Future[b,t] & ef =  match o {
    ///     case Wrong(t) => Wrong(t)
    ///     case Good(v) => f(v)
    /// }
}


