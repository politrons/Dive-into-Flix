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
    pub def get(o: Future[Channel[Result[b,t]]]): Result[b,t] & Impure = 
        let result: Result[b,t] = match o {
            case Future(channel) => <- channel
        };
        match result {
            case Ok(v) => Ok(v)
            case Err(t) => Err(t)
            /// case Wrong(t) => Wrong(t)
            /// case Good(channel) => Good(<- channel)
        }  

    /// pub def onComplete(f: b -> b & ef , e: t -> b & ef, o: Future[Channel[b],t]): Unit & Impure = match o {
    ///     case Wrong(t) => Wrong(e(t))
    ///     case Good(channel) => 
    ///         let result:b = f(<- channel);
    ///         Good(result)
    /// }    

    /// pub def map(f: a -> b & ef, o: Future[a,t]): Future[b,t] & ef = match o {
    ///     case Wrong(t) => Wrong(t)
    ///     case Good(v) => Good(f(v))
    /// }

    /// pub def flatMap(f: a -> Future[b,t] & ef, o: Future[a,t]): Future[b,t] & ef =  match o {
    ///     case Wrong(t) => Wrong(t)
    ///     case Good(v) => f(v)
    /// }
}

def runFuture():Unit & Impure=
    let future:Future[Channel[Result[String,String]]] =Future.run(()-> "hello future world");
    let result:Result[String,String] = Future.get(future);
    println(result)