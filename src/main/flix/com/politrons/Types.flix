enum Sex with ToString {
    case Male
    case Female
}

namespace User {

    pub def username():String = "Politrons"

    pub def password():String = "Password"

    pub def sex():Sex = Male()
}

def login():Unit & Impure =
    let username = User.username();
    let password = User.password();
    let sex = User.sex();
    println("${username}-${password}-${sex}")