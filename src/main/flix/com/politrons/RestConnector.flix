// Test
// -----

def runRequest():Unit & Impure =
    let uri:Uri[String] = FlixHttp.setConfig("www.google.com", Uri(""));
    println(uri)
    /// let method = FlixHttp.method("get",uri );
    /// let port = FlixHttp.port("80", method);
    /// let response = FlixHttp.run(port);
    /// println(response)



// Implementation
//---------------
enum Uri[x] with ToString {
    case Uri(x)
}

namespace Uri {

    pub def set(f: b, x: Uri[a]): Uri[b] =
        match x {
            case Uri(_) => Uri(f)
        }
        
}

/// enum Method[uri, method] {
///     case Method(uri, method)
/// }

/// enum Port[method, port] {
///     case Port(method, port)
/// }

//Type class contract that all [instance] must implement.
// m deifne a function type [Type -> Type] which is impure since it might have
// side effect [ef]
pub lawless class FlixHttp[m : Type -> Type] {

    pub def set(f:b, x: m[a]): m[b]

}


instance FlixHttp[Uri] {

    pub def set(f: b, x: Uri[a]): Uri[b] = Uri.set(f,x)

        
} 



namespace FlixHttp {

    pub def setConfig(f: b, x: m[a]): m[b] with FlixHttp[m] = set(f, x)

    /// pub def uri(uri:String):Uri[String] =
    ///     match o {
    ///     case B => B
    ///     case A(v) => A(f(v))
    /// }
       

    /// pub def method(method:String, uri:Uri[String]): Method[Uri[String], String] =
    ///     Method(uri, method)   

    /// pub def port(port:String, method:Method[Uri[String], String]): Port[Method[Uri[String], String], String] =
    ///     Port(method, port)  

    /// pub def run(p:Port[Method[Uri[String], String], String]): String =
    ///    match p {
    ///         case Port(m, port) => match m {
    ///             case Method(u, method) => match u {
    ///                 case Uri(uri) => "Port:${port} Method:${method} Uri:${uri}"
    ///             }
    ///         }
    ///     }

}