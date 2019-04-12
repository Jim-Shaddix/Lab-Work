import dash
import dash_core_components as dcc
import dash_html_components as html
from numpy import sin,cos,pi,linspace
"""
    Basic Dash Application
"""

# Create's application
app = dash.Dash(__name__)

# Colors that will be used for the application
colors = {
    "text": "red",
    "background": "black"
}

# Functions to Plot
x  = linspace(0,6*pi,100)
y1 = cos(x)
y2 = sin(x)

# Application Layout
app.layout = html.Div(
    style={
        "textAlign": "center",
        "color": colors["text"],
        "backgroundColor": colors["background"]
    },
    children=[
        html.H1("Application Title"),
        html.Div("Application description ... "),
        dcc.Graph(
            id="1",
            figure={
                "data":[
                    {'x':x, 'y':y1, "style": "Scatter", "name": "cos"},
                    {'x':x, 'y':y2, "style": "Scatter", "name": "sin"}
                ],
                "layout":{
                    "title": "Graph Title",
                    "xaxis": {"title": "x-axis"},
                    "yaxis": {"title": "y-axis"},
                    "plot_bgcolor": colors["background"],
                    "paper_bgcolor": colors["background"],
                    "font": {"color": colors["text"]}
                }
            }
        )
    ]
)

if __name__ == '__main__':

    # Enables hot reloading
    app.run_server(debug=True)
