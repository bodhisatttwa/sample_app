ActionMailer::Base.smtp_settings = {
    default_charset: "utf-8",
    address: "tomaszkaluzn.nazwa.pl",
    port: 25,
    domain: "tomaszkaluzny.pl",
    user_name: "kontakt@tomaszkaluzny.pl",
    password: "!22011984tkTK",
    authentication: "plain",
    enable_starttls_auto: true
}

ActionMailer::Base.default_url_options[:host] = "fierce-sands-9860.herokuapp.com"