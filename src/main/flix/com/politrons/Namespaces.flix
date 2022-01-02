namespace User {
    pub def username():String = "Politrons"

    pub def password():String = "Password"
}

def login():Unit & Impure =
    let username = User.username();
    let password = User.password();
    println("${username}-${password}")