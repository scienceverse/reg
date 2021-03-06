### dat_tab ----
dat_tab <- tabItem(
  tabName = "dat_tab",

  dataTableOutput("dat_table"),
  actionButton("dat_add", "Add Data", icon("plus")),
  actionButton("dat_delete", "Delete Data", icon("trash")),
  downloadButton("download_data", "Download Data"),
  downloadButton("download_cb", "Download Codebook"),
  actionButton("dat_clear", "Clear", icon("times")),

  # general info ----
  box(width=12, collapsible = TRUE, collapsed = F,
      title = "Required Info",
      textInput("dat_id", "Data ID", "", "100%"),
      textAreaInput("dat_desc", "Data Description", "", "100%")
  ),
  # upload tab ----
  box(width=12, collapsible = TRUE, collapsed = T,
      title = "Upload Data",
      fileInput("dat_file", NULL, width = "100%")
  ),
  cinfo("dat_info"),
  # simulate tab ----
  box(width=12, collapsible = TRUE, collapsed = T,
      title = "Simulate Factorial Data",
      HTML("<p>Scienceverse uses <a href='https://debruine.github.io/faux/' target='_blank'>faux</a> to simulate data with factorial designs.</p>"),
      actionButton("sim_data", "Simulate Data"),
      actionButton("sim_demo", "Load Demo"),
      actionButton("sim_clear", "Clear", icon("times")),
      fluidRow(
        column(3, actionButton("factor_add", "Add Factor", icon("plus"))),
        column(3, selectInput("factor_chooser", NULL,
                              c("New Factor" = 0), selected = 0))
      ),
      fluidRow(
        column(3, textInput("factor_name", "Factor name", "")),
        column(3, textInput("factor_desc", "Factor description", "")),
        column(3, selectInput("factor_levels", "Levels", 2:10, 2)),
        column(3, selectInput("factor_type", "Factor type", c("between", "within")))
      ),
      uiOutput("level_list_display"),

      fluidRow(
        column(3, textInput("dv_name", "DV Label", "y", "100%", "DV name")),
        column(3, textInput("dv_def", "DV Description", "value", "100%", "DV definition")),
        column(3, textInput("id_name", "ID Label", "id", "100%", "ID name")),
        column(3, textInput("id_def", "ID Description", "Subject ID", "100%", "ID definition"))
      ),

      fluidRow(
        column(3, textInput("n", "n", 100, "100%")),
        column(3, textInput("mu", "mu", 0, "100%")),
        column(3, textInput("sd", "sd", 1, "100%")),
        column(3, textInput("r", "r", 0, "100%"))
      ),

      fluidRow(
        column(6, selectInput("long", "Data Format",
                              c("wide (each row is a subject)" = "FALSE",
                                "long (each row is an observation)" = "TRUE"), "FALSE")),
        column(6, selectInput("empirical", "Parameters describe",
                              c("population" = "FALSE",
                                "sample" = "TRUE"), "FALSE"))
      ),
      tabsetPanel(type = "tabs",
                  tabPanel("Design Summary", dataTableOutput("design_summary")),
                  tabPanel("Design Plot",
                           checkboxGroupInput("plot_geoms", NULL,
                                              c("violin" = "violin",
                                                "boxplot" = "box",
                                                "mean ±SD" = "pointrangeSD"), selected = "pointrangeSD", inline = TRUE),
                           plotOutput("sim_plot"))
      )
  ),

  # data tab ----
  box(id="data-box", width=12, collapsible = TRUE, collapsed = T,
    title = "Data and Codebook",
    tabsetPanel(
      type = "tabs",
      # data table ----
      tabPanel("Data",
        dataTableOutput("data_table")
      ),
      # codebook ----
      tabPanel("Edit Codebook",
        h4("This section is under construction and quite buggy"),
        uiOutput("var_list"),
        hidden(textInput("var_name", "Name")),
        textInput("var_desc", "Description", width="100%"),
        selectInput("var_type", "Data Type",
                    c("Integer (int)" = "int",
                      "Character (string)" = "string",
                      "Double (float)" = "float",
                      "Logical (bool)" = "bool")),
        actionButton("var_update", "Update")
      ),
      # codebook JSON ----
      tabPanel("Codebook JSON",
        HTML("<p>The codebook uses <a href='https://psych-ds.github.io' target='_blank'>Psych-DS</a> format, which is currently in development.</p>"),
        verbatimTextOutput("codebook_json")
      )
    )
  )
)
