library(shiny)
# Define server logic required to draw a histogram



server <- function(input,output,session){
  IP <- reactive({ input$getIP })
  
  observe({
    shinyjs::toggleState("my_button", input$characters !="" )
  })
  observe({
    shinyjs::toggleState("check", !input$name ==""  && !input$mail =="")
  })
  
  # output$IPinfor <- DT::renderDataTable({ 
  #   do.call("rbind", IP()) 
  # })
  
  observeEvent(input$check, {
    ## update personal information 
    IPinfor=do.call("rbind", IP())  ## six rows, 1 column.
    ## ip/city/region/country/loc/org 
    ip=IPinfor[1,1]
    city_ip=IPinfor[2,1]
    sql=paste("INSERT INTO contacts  (name,age,ip,city_ip,city_user,mail,phone,married,desc) VALUES ( ",
              paste(shQuote(input$name),  input$age,  shQuote(ip),  shQuote(city_ip),  
                    shQuote(input$city),  shQuote(input$mail),  shQuote(input$phone), 
                    shQuote(input$married), sep=','),
              
              ",'test' )"
              )
    library(RSQLite)
    sqlite    <- dbDriver("SQLite")
    con <- dbConnect(sqlite,"contacts.sqlite") # makes a new file
    dbSendQuery(con, sql)
    dbDisconnect(con)
  })
  
  observeEvent(input$my_button, {
    ## update personal characters 
    ## UPDATE contacts SET desc='test,test1,test2' WHERE ip='8.8.8.8' and mail = '123@123.com';
    
    IPinfor=do.call("rbind", IP())  ## six rows, 1 column.
    ## ip/city/region/country/loc/org 
    ip=IPinfor[1,1] 
    sql=paste(" UPDATE contacts SET desc= ", shQuote(paste(input$characters, collapse= ',')) ," where ip = ",
              shQuote(ip)," and mail = ",shQuote(input$mail)
    )
    library(RSQLite)
    sqlite    <- dbDriver("SQLite")
    con <- dbConnect(sqlite,"contacts.sqlite") # makes a new file
    dbSendQuery(con, sql)
    dbDisconnect(con)
  })
  
  
}
