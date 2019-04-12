import dash
import dash_core_components as dcc
import dash_html_components as html
from numpy import cos,sin,pi,linspace
"""
    Simple Dash Application
"""

# CREATE: application
app = dash.Dash(__name__)

# Colors For application
colors = {
    "text": "red",
    "background":"black"
}

# Functions to plot
x  = linspace(0,8*pi,100)
y1 = cos(x)
y2 = sin(x)

app.layout = html.Div(
    style={
        "textAlign": "center",
        "color": colors["text"],
        "backgroundColor": colors["background"]
    },
    children=[
        html.H1("Application Title"),
        html.Div("Application Description ..."),
        dcc.Graph(
            id="1",
            figure={
                "data":[
                    {'x': x, 'y': y1,
                     "style":"Scatter", "name": "cos",
                     "line":{"color":"red"}
                    },
                    {'x': x, 'y': y2,
                     "style":"Scatter", "name": "sin",
                     "line":{"color":"blue"}
                    }
                ],
                "layout":{
                    "title": "Graph Title",
                    "xaxis": {"title": "x-axis"},
                    "yaxis": {"title": "x-axis"},
                    "plot_bgcolor":  colors["background"],
                    "paper_bgcolor": colors["background"],
                    "font": {"color":colors["text"]}
                }
            }
        )
    ]
)

if __name__ == '__main__':
    app.run_server(debug=True)