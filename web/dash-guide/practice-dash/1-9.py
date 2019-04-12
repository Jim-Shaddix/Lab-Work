import dash
import dash_core_components as dcc
import dash_html_components as html
"""
    Simple Dash application that makes some cool plots
"""
x = [1, 2, 3]
y = [1, 5, 3]

app = dash.Dash(__name__)

app.layout = html.Div([

    html.H1("Application Title"),
    html.Div("Application Description"),
    dcc.Graph(
        id="1",
        figure={
            "data":[
                {"x": x, "y": y, "type": "bar", "showlegend":False,"text":"some text ..."},
                {"x": x, "y": y, "type": "Scatter"}],
            "layout":{
                "title":"Graph Title",

                "xaxis":{"title":"x-axis", "color":"red",  "showticklabels":False, "showgrid":False},
                "yaxis":{"title":"y-axis", "color":"blue", "showticklabels":False, "showgrid":False},
            }
        }
    )

])


if __name__ == '__main__':

    # Enables Hot Reloading
    app.run_server(debug=True)
