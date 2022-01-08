// Test
// -----

def runRequest():Unit & Impure =
    let uri:Uri[String,  String] = FlixHttp.setConfig("www.google.com", Uri("",""));
    let method:Method[String,Uri[String,  String] ] = FlixHttp.setConfig("get", Method("",uri));
    let port:Port[String,Method[String,Uri[String,  String] ]] = FlixHttp.setConfig("80", Port("",method));
    println(port)
    /// let response = FlixHttp.run(port);
    /// println(response)



// Implementation
//---------------
enum Uri[uri, u] with ToString {
    case Uri(uri, u)
}

namespace Uri {

    pub def set(f: b, x: Uri[a, u]): Uri[b, u] =
        match x {
            case Uri(_,u) => Uri(f,u)
        }
        
}

enum Method[method, uri] with ToString {
    case Method(method, uri)
}

namespace Method {

    pub def set(f: b, x: Method[a, u]): Method[b,u] =
        match x {
            case Method(_,u) =>  Method(f,u)
        }
        
}

enum Port[method, port] with ToString {
    case Port(method, port)
}

namespace Port {

    pub def set(f: b, x: Port[a, u]): Port[b,u] =
        match x {
            case Port(_,u) =>  Port(f,u)
        }
        
}

pub lawless class FlixHttp[m : Type -> Type -> Type] {

    pub def set(f:b, x: m[a,u]): m[b,u]

}


instance FlixHttp[Uri] {

    pub def set(f: b, x: Uri[a,u]): Uri[b,u] = Uri.set(f,x)
  
} 

instance FlixHttp[Method] {

    pub def set(f: b, x: Method[a,u]): Method[b,u] = Method.set(f,x)
        
} 

instance FlixHttp[Port] {

    pub def set(f: b, x: Port[a,u]): Port[b,u] = Port.set(f,x)
        
} 

namespace FlixHttp {

    pub def setConfig(f: b, x: m[a,u]): m[b,u] with FlixHttp[m] = set(f, x)

    /// pub def run(p:Port[Method[Uri[String], String], String]): String =
    ///    match p {
    ///         case Port(m, port) => match m {
    ///             case Method(u, method) => match u {
    ///                 case Uri(uri) => "Port:${port} Method:${method} Uri:${uri}"
    ///             }
    ///         }
    ///     }

}