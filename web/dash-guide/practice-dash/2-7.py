import dash
import dash_core_components as dcc
import dash_html_components as html
from numpy import linspace,cos,sin,pi
"""
    Basic Dash Application
"""

# Create Application
app = dash.Dash(__name__)

# Functions to plot
x  = linspace(0,6*pi,100)
y1 = cos(x)
y2 = sin(x)

# Application colors
colors = {
    "text": "red",
    "background": "black"
}

app.layout = html.Div(
    style={
        "color": colors["text"],
        "textAlign": "center",
        "backgroundColor": colors["background"]
    },
    children=[
        html.H1("Application Title"),
        html.Div("Application description ..."),
        dcc.Graph(
            id="1",
            figure={
                "data": [
                    {'x': x, 'y':y1,
                     'style': "Scatter",
                     "name":  "cos",
                     "line":  {"color": "red"},
                     "mode": "markers"
                    },
                    {'x': x,  'y':y2,
                     'style': "Scatter",
                     "name":  "sin",
                     "line":  {"color": "blue"}
                    }
                ],
                "layout":{
                    "title": "Graph Title",
                    "xaxis": {"title": "xaxis"},
                    "yaxis": {"title": "xaxis"},
                    "font":  {'color': colors["text"]},
                    "plot_bgcolor":    colors["background"],
                    "paper_bgcolor":   colors["background"]
                }
            }
        )
    ]
)


if __name__ == '__main__':

    # Enables hot reloading
    app.run_server(debug=True)
