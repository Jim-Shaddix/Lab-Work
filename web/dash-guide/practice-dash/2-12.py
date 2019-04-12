import dash
import dash_core_components as dcc
import dash_html_components as html
from numpy import pi,cos,sin,linspace
"""
    Simple Dash Application
"""

# create the application
app = dash.Dash(__name__)

# colors
colors = {
    "text": "red",
    "background": "black"
}

# functions to plot
x  = linspace(0, 6*pi, 100)
y1 = cos(x)
y2 = sin(x)

# create
app.layout = html.Div(
    textAlign="center",
    color=colors["text"],
    backgroundColor=colors["background"],
    children=[
        html.H1("Application Title"),
        html.Div("Application Description"),
        dcc.Graph(
            id="1",
            figure={
                "data":[
                    {"x": x, "y": y1, "style": "Scatter", "name": "Fort Collins"},
                    {"x": x, "y": y2, "style": "Scatter", "name": "Fort Collins"}
                ],
                "layout":{
                    "title": "Graph title",
                    "font":{"color": colors["text"]},
                    "plot_bgcolor":  colors["background"],
                    "paper_bgcolor": colors["background"]
                }
            }
        )
    ]
)
