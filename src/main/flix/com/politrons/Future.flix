enum Future[a,t] with ToString{
  case Good(a)
  case Wrong(t)

}

//We implement Functor [map] and Monad [flatMap], so it can be used as part of the 
//implementation of MyMonad
namespace Future {

    /// pub def run(f: () -> b & ef): Future[b,t] & ef =
    
    ///     Good(f())

    pub def map(f: a -> b & ef, o: Future[a,t]): Future[b,t] & ef = match o {
        case Wrong(t) => Wrong(t)
        case Good(v) => Good(f(v))
    }

    pub def flatMap(f: a -> Future[b,t] & ef, o: Future[a,t]): Future[b,t] & ef =  match o {
        case Wrong(t) => Wrong(t)
        case Good(v) => f(v)
    }
}

def runFuture():Unit & Impure=
    let future:Future[String, String] =Good("hello");
    println(future)