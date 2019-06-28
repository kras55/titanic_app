library(shiny)
# contigency table to dataframe converting

# Convert from data frame of counts to data frame of cases.
# `countcol` is the name of the column containing the counts
countsToDataFrame <- function(x, countcol = "Freq") {
    # Get the row indices to pull from x
    idx <- rep.int(seq_len(nrow(x)), x[[countcol]])
    
    # Drop count column
    x[[countcol]] <- NULL
    
    # Get the rows from x
    x[idx, ]
}

dat <- countsToDataFrame(as.data.frame(Titanic))
head(dat)

# Conditional plot drawing function
draw_barplot = function(param){
    barplot(apply(Titanic, c(4, param), sum), col=c("red", "darkblue"), 
            ylim = c(0, max(colSums(apply(Titanic, c(4, param), sum))) * 1.25),
            ylab="Passenger number",
            main = paste("Number of survived and not survived passengers according to their", names(dat)[param])
    )
    
    legend("top", legend = c("survived", "not survived"), col = c("darkblue", "red"), bty = 'n', pch = c(15))
}



## creating relevant model using logistic regression

logit.fit <- glm(Survived ~ ., family = 'binomial', dat)
get_prediction <- function(testing) {
    sex <- tolower(testing$Sex[1])
    age <- tolower(testing$Age[1])
    class <- tolower(testing$Class[1])
    prob <- predict(logit.fit, newdata = testing, type = 'response')
    plot_data <- c(Survive = prob, Not_Survive = 1- prob)
    barplot(plot_data, col = c("darkblue", "red"), 
            names.arg = c("Survival", "Non-Survival"),
            xlab="Survival status", ylab="Probability",
            main = paste("Predicted probabilities of survival and non-survival for", class, "class", sex, age, "passenger")
    )
}
# define server logic required to draw a plots

shinyServer(function(input, output) {
    output$ratioPlot <- renderPlot({ 
        # generate relevant to chosen feature barplot
        draw_barplot(as.numeric(input$radio))
    })
    output$predictionPlot <- renderPlot({
        passData <- data.frame(Class = input$selectClass,  Sex=input$selectSex,   Age = input$selectAge)
        # generate barplot according to defined passanger features.
        get_prediction(passData)
    })
})
