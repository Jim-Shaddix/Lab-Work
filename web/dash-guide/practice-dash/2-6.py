import dash
import dash_core_components as dcc
import dash_html_components as html
from numpy import sin,cos,linspace,pi
"""
    Simple Dash Application
"""

# Create dash application
app = dash.Dash(__name__)

colors = {
    "text": "red",
    "background": "black"
}

# Data to plot
x  = linspace(0,4*pi,100)
y1 = sin(x)
y2 = cos(x)

# Application layout
app.layout = html.Div(
    style={
        "color": colors["text"],
        "textAlign": "center",
        "backgroundColor": colors["background"]
    },
    children=[
        html.H1("Application Title"),
        html.Div("application description ..."),
        dcc.Graph(
            id="1",
            figure={
                "data":[
                    {'x': x, 'y': y1, "style": "Scatter", "name": "sin"},
                    {'x': x, 'y': y2, "style": "Scatter", "name": "cos"}
                ],
                "layout":{
                    "title": "Graph Title",
                    "xaxis": {"title": "x-axis"},
                    "yaxis": {"title": "y-axis"},
                    "plot_bgcolor":  colors["background"],
                    "paper_bgcolor": colors["background"],
                    "font":{"color": colors["text"]}
                }
            }
        )
    ]
)

if __name__ == '__main__':

    # Enables hot reloading
    app.run_server(debug=True)
