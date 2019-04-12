
import dash
import dash_core_components as dcc
import dash_html_components as html

"""
    create a basic bar graph:
    
    LIBRARIES:
        1. dash: allows me initialize the application
        2. dash_html_components allows me to create any html tag
            - children parameter: describes what goes inbetween the 
             created tags.
            - the other parameters accept dictionaries as arguemnts, 
              as opposed to colon delimted strings in html.
        3. dash_core_components: 
            - provides higher level functionality components using 
              javascript, css and html.
"""

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets = external_stylesheets)

app.layout = html.Div(children=[
    html.H1(children = "Main Header"),
    html.Div(children=["just some plain paragragh"]),
    dcc.Graph(
        id="id of the graph",
        figure={
            'data':[
                {'x':[1,2,3], 'y':[4,1,2], 'type':'bar','name':'SF'},
                {'x':[1,2,3], 'y':[2,4,5], 'type':'bar','name':'Montreal'},
            ],
            'layout':{
                'title': 'Title of the graph!!!'
            }
        }

    )

])

if __name__ == '__main__':
    # enables hot reloading
    app.run_server(debug=True)