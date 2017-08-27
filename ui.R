library(shiny)
library(shinydashboard)
characters=read.table('characters.txt',stringsAsFactors = F,encoding = 'UTF-8')

## TODO:
## statistics page :

header <- dashboardHeader(title="找来找去 随机匹配")
sider <- dashboardSidebar(
  sidebarMenu(
    menuItem("来玩呗", tabName="play", icon=icon("meetup")),
    menuItem("看看呗", tabName="stat", icon=icon("line-chart")),
    menuItem("免责", tabName="license", icon=icon("legal"))
))

# choices
# 信息录入界面
# inputId, "name", "age", "city", "mail", "married", ,
# buttion: "check", "my_button","her_button"
# outpuId, "cloud"
# 标签云
choices <- c("多金", "高")
play_items <-tabItem(tabName="play",  fluidRow(
  box(
    textInput(inputId="name", label = "尊姓大名"),
    sliderInput(inputId="age", label = "贵庚", min = 20, max = 40, value = 30),
    textInput(inputId="city", label="身居何处", placeholder = "上海" ),
    textInput(inputId="phone", label = "可否给个号码", placeholder="可选"),
    textInput(inputId="mail", label = "邮箱", placeholder = "必选"),
    checkboxInput(inputId="married", label = "单身",value = TRUE),
    actionButton(inputId="check",label = "确定"),
    solidHeader = TRUE,
    width = 4
  ),
  box(
    tags$div(align="center",tags$h3("你是什么样的一个人")),
    #plotOutput(outputId="cloud",height = 300),
    #textInput(inputId="characters",label="用上面的标签描述一下你,以空格分隔",
    #      placeholder = "可爱 迷人"),
    selectizeInput('characters', label = "用上面的标签描述一下你,以空格分隔",
                   choices = characters,# width = 275,
                   multiple=T,
                   options = list(placeholder = "可爱 迷人",
                                  maxOptions = 1000)
                   ),
    actionButton(inputId="my_button",label = "这就是我"),
    DT::dataTableOutput('IPinfor'),
    width = 5 ,
    height = 500,
    background = "purple"
  ),
  box(
      width = 3,
      column( width= 12, 
        tags$h4("你希望他/她如何"),
        selectInput(inputId="choice", label = "只能选择一个哦", choices = choices),
        actionButton(inputId="her_button",label = "就这个吧")
      )
    )
))


# 主要内容
body <- dashboardBody(
  shinyjs::useShinyjs(), 
  tags$script(src="getIP.js"),
  tabItems(
    play_items,
    tabItem(tabName="stat"),
    tabItem(tabName="license")
  )

)

ui <- dashboardPage(
  header,
  sider,
  body,
  skin = "purple"
)


