// Test
// -----

def runRequest():Unit & Impure =
    let uri = FlixHttp.uri("www.google.com");
    let method = FlixHttp.method("get",uri );
    let port = FlixHttp.port("80", method);
    let response = FlixHttp.run(port);
    println(response)



// Implementation
//---------------
enum Uri[uri]  {
    case Uri(uri)
}

enum Method[uri, method] {
    case Method(uri, method)
}

enum Port[method, port] {
    case Port(method, port)
}


namespace FlixHttp {

    pub def uri(uri:String):Uri[String] =
        Uri(uri)

    pub def method(method:String, uri:Uri[String]): Method[Uri[String], String] =
        Method(uri, method)   

    pub def port(port:String, method:Method[Uri[String], String]): Port[Method[Uri[String], String], String] =
        Port(method, port)  

    pub def run(p:Port[Method[Uri[String], String], String]): String =
       match p {
            case Port(m, port) => match m {
                case Method(u, method) => match u {
                    case Uri(uri) => "Port:${port} Method:${method} Uri:${uri}"
                }
            }
        }
        
}