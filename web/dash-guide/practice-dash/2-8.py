import dash
import dash_core_components as dcc
import dash_html_components as html
from numpy import sin,cos,pi,linspace
"""
    Basic Dash Application
"""

# create the application
app = dash.Dash(__name__)

# application colors
colors = {
    "text": "red",
    "background": "black",
}

# functions to plot
x  = linspace(0, 6*pi, 100)
y1 = cos(x)
y2 = sin(x)

# application layout
app.layout = html.Div(
    style={"textAlign": "center",
           "color": colors["text"],
           "backgroundColor": colors["background"],
    },

    children=[
        html.H1("Application Title"),
        html.Div("Application description ..."),
        dcc.Graph(
            figure={
                "data":[
                    {'x': x, 'y': y1, "style": "Scatter", "name": "Jim"},
                    {'x': x, 'y': y2, "style": "Scatter", "name": "Jim"}
                ],
                "layout":{
                    "title": "Graph Title",
                    "xaxis": {"title":"x-axis"},
                    "yaxis": {"title":"y-axis"},
                    "plot_bgcolor":  colors["background"],
                    "paper_bgcolor": colors["background"],
                    "font":{"color": colors["text"]}
                }
            }
        )
    ]
)


if __name__ == '__main__':
    app.run_server(debug=True)
