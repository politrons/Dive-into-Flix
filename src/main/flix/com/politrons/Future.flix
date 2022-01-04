enum Future[a,t] with ToString{
  case Good(a)
  case Wrong(t)

}

//We implement Functor [map] and Monad [flatMap], so it can be used as part of the 
//implementation of MyMonad
namespace Future {

    //Supplier function to run the function in another thread, and return a Future with a Channel[b]
    //So the execution run in another thread just like in Scala
    pub def run(f: Unit -> b & ef): Future[Channel[b],t] & Impure=
        let chann = chan b 0;
        spawn chann <- f();
        Good(chann)

    //Blocking function to obtain future result.
    pub def get(o: Future[Channel[b],t]): Future[b,t] & Impure = match o {
        case Wrong(t) => Wrong(t)
        case Good(channel) => Good(<- channel)
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
    let future:Future[Channel[String], String] =Future.run(()-> "hello future world");
    let result:Future[String, String] = Future.get(future);
    println(result)