
description = "This application uses Titanic data from R datasets to research actually obtained survival status and predicted survival probability for various Titanic passenger types. 
Two barplots visualize the research results. 
First barplot indicates the number of survived vs unsurvived passengers grouped by existing values of passenger feature, i.e. Class, Age or Sex.
User can choose one of this features and plot will be updated according to the user's choice. 
The second plot indicates the predicted probability of survival and unsurvival for a passenger with certain feature values. 
Prediction is based on the logistic regression model fitted on the Titanic data. 
Application plugs defined by user feature values into the model and yields prediction, which is displayed as a barplot.
User can choose a value of each passenger feature and the plot will be updated according to the user's choice."

library(shiny)

# Define UI for application that draws plots.
shinyUI(fluidPage(

    # Application title
    titlePanel("Titanic Survival Research"),
    p(description),

    # Sidebar with user inputs
    sidebarLayout(
        #titlePanel("Choose Parameter"),
        sidebarPanel(
            titlePanel("Choose passanger feature"),
            #radio buttons to choose one feature for passenger survival comparison
            radioButtons("radio", label = h3("Features"),
                         choices = list("Class" = 1, "Sex" = 2, "Age" = 3), 
                         selected = 1),
            titlePanel("Set Passanger Features"),
            # SelectInput group to define a value of each passenger feature.
            selectInput("selectClass", label = h3("Select class"), 
                        choices = list("1st" = "1st", "2nd" = "2nd", "3rd" = "3rd", "Crew" = "Crew")
                        ),
            selectInput("selectSex", label = h3("Select sex"), 
                        choices = list("Male" = "Male", "Female" = "Female")
            ),
            selectInput("selectAge", label = h3("Select age"), 
                        choices = list("Child" = "Child", "Adult" = "Adult")
            )
            
        ),
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("ratioPlot"),
            plotOutput("predictionPlot")
        )
    )
))
