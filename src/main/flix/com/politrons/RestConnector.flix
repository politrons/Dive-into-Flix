// Test
// -----

def runRequest():Unit & Impure =
    let uri:Uri[String,  String] = FlixHttp.setConfig(Uri("www.google.com",""));
    let method:Method[String,Uri[String,  String] ] = FlixHttp.setConfig(Method("get",uri));
    let port:Port[String,Method[String,Uri[String,  String] ]] = FlixHttp.setConfig(Port("80",method));
    println(port)
    /// let response = FlixHttp.run(port);
    /// println(response)



// Implementation
//---------------
enum Uri[uri, u] with ToString {
    case Uri(uri, u)
}

namespace Uri {

    pub def set(x: Uri[a, u]): Uri[a, u] =
        match x {
            case Uri(a,u) => Uri(a,u)
        }
        
}

enum Method[method, uri] with ToString {
    case Method(method, uri)
}

namespace Method {

    pub def set(x: Method[a, u]): Method[a,u] =
        match x {
            case Method(a,u) =>  Method(a,u)
        }
        
}

enum Port[method, port] with ToString {
    case Port(method, port)
}

namespace Port {

    pub def set(x: Port[a, u]): Port[a,u] =
        match x {
            case Port(a,u) =>  Port(a,u)
        }
        
}

pub lawless class FlixHttp[m : Type -> Type -> Type] {

    pub def set(x: m[a,u]): m[a,u]

}


instance FlixHttp[Uri] {

    pub def set(x: Uri[a,u]): Uri[a,u] = Uri.set(x)
  
} 

instance FlixHttp[Method] {

    pub def set(x: Method[a,u]): Method[a,u] = Method.set(x)
        
} 

instance FlixHttp[Port] {

    pub def set(x: Port[a,u]): Port[a,u] = Port.set(x)
        
} 

namespace FlixHttp {

    pub def setConfig(x: m[a,u]): m[a,u] with FlixHttp[m] = set(x)

    /// pub def run(p:Port[Method[Uri[String], String], String]): String =
    ///    match p {
    ///         case Port(m, port) => match m {
    ///             case Method(u, method) => match u {
    ///                 case Uri(uri) => "Port:${port} Method:${method} Uri:${uri}"
    ///             }
    ///         }
    ///     }

}