//Future
//-------
def runFuture():Unit & Impure=
    getFuture();
    onCallbackFuture();
    mapFuture();
    flatMapFuture()

def getFuture():Unit & Impure=
    import java.lang.Thread:currentThread();
    import java.lang.Thread.getName();
    let future:Future[Channel[Result[String,String]]] =Future.run(()-> "hello future world in Thread ${getName(currentThread())}" );
    let result:Result[String,String] = Future.get(future);
    println(result)

def onCallbackFuture():Unit & Impure=
    let future:Future[Channel[Result[String,String]]] =Future.run(()-> "hello future world" );
    Future.onComplete(v -> println("Success result:${String.toUpperCase(v)}"),
                      t -> println("Error result:${String.toUpperCase(t)}"), future)

def mapFuture():Unit & Impure=
    let future:Future[Channel[Result[String,String]]] =Future.run(()-> "hello future world" );
    let newFuture = future |>
    Future.map(v -> String.toUpperCase(v)) |>
    Future.map(v -> "${v} using map operator for transformation") |>
    Future.map(v -> String.toUpperCase(v)); 
    let result:Result[String,String] = Future.get(newFuture);
    println(result)

def flatMapFuture():Unit & Impure=
    import java.lang.Thread:currentThread();
    import java.lang.Thread.getName();
    let future:Future[Channel[Result[String,String]]] =Future.run(()-> "hello future world in ${getName(currentThread())}" );
    let newFuture = future |>
    Future.flatMap(v -> Future.run(()->String.toUpperCase(v))) |>
    Future.flatMap(v -> Future.run(()->"${v} using flatMap operator for composition")) |>
    Future.map(v -> String.toUpperCase(v)); 
    let result:Result[String,String] = Future.get(newFuture);
    println(result)

// Implementation
//---------------

enum Future[a] with ToString{
  case Future(a)
}

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
         match o {
            case Future(channel) => match <- channel {
                case Ok(v) => Ok(v)
                case Err(t) => Err(t)
            }
        }

    //We create a function that expect two Consumer functions, one for the success channel, and another for failure.
    pub def onComplete(f: b -> Unit & ef,e: t -> Unit & ef, o: Future[Channel[Result[b,t]]]): Unit & Impure = 
        match o {
            case Future(channel) => match <- channel {
                case Ok(v) => f(v)
                case Err(t) => e(t)
             }
        }

    //[Map] operator allow make a transformation inside the Future monad, creating a new thread and making the transformation
    //Once the first thread finish. 
    //This operator works completely async and it will return a Future with the transformation of the body
    pub def map(f: a -> b & ef, o: Future[Channel[Result[a,t]]]): Future[Channel[Result[b,t]]] & Impure = 
        let newChann:Channel[Result[b,t]] = chan Result[b,t] 0;
        match o {
            case Future(channel) => spawn match <- channel {
                case Ok(v) => newChann <- Ok(f(v))
                case Err(t) => newChann <- Err(t)
            }
        };
        Future(newChann)

    //[FlatMap] operator allow make a composition between Futures, once the first thread finish, it pass the output to allow 
    //composition with the creation of a new Future. 
    //This operator works completely async and it will return a Future with the transformation of the body
    pub def flatMap(f: a -> Future[Channel[Result[b,t]]] & ef, o: Future[Channel[Result[a,t]]]): Future[Channel[Result[b,t]]] & Impure = 
        match o {
            case Future(channel) => match <- channel {
                case Ok(v) => f(v)
                case Err(t) => 
                    let errChann:Channel[Result[b,t]] = chan Result[b,t] 0;
                    Future(errChann <- Err(t))
            }
        }
}


