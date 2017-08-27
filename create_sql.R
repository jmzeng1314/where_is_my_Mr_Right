library(RSQLite)
sqlite    <- dbDriver("SQLite")
con <- dbConnect(sqlite,"contacts.sqlite") # makes a new file
dbSendQuery(con,paste("CREATE TABLE IF NOT EXISTS contacts ",
            "(name VARCHAR(25) NOT NULL,",
            "age INT(2) NOT NULL,",
        "    ip VARCHAR(16) NOT NULL,",
            "city_ip VARCHAR(100) NOT NULL,",
            "city_user VARCHAR(25) NOT NULL,",
            "mail VARCHAR(25) NOT NULL,",
            "phone VARCHAR(20) DEFAULT NULL,",
           " married VARCHAR(25) NOT NULL,", 
        "    desc VARCHAR(100) NOT NULL", 
           " )   "
            ))
dbListTables(con)
dbSendQuery(con,"INSERT INTO contacts 
            (name,age,ip,city_ip,city_user,mail,phone,married,desc)
            VALUES 
            ('jimmy',26,'8.8.8.8','Macau','macau','jmzeng1314@163.com',13215794746,'yes','perfect')")
dbReadTable(con,'contacts')
dbSendQuery(con,'drop table contacts')
dbDisconnect(con)

