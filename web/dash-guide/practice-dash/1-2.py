
import dash
import dash_core_components as dcc
import dash_html_components as html

# CSS Style sheets
external_style_sheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

# init the application
app = dash.Dash(__name__, external_stylesheets=external_style_sheets)

app.layout = html.Div(children=[

    html.H1("Title of The Application"),
    html.Div(children="some paragraph"),
    html.Div(children=["another paragraph",'and yet another']),
    dcc.Graph(
        id="some identifier for the app",
        figure={
            'data': [
                    {'x': [1, 2, 3], 'y': [1, 2, 3], 'type': 'Scatter', 'name': 'SF','text': ['A','B','C'], 'mode': "markers+text"},
                    {'x': [1, 2, 3], 'y': [1, 4, 9], 'type': 'Scatter', 'name': 'montreal'}
            ],
            'layout': {
                'title': 'Dash application for data visualization',
            }
        }
    )
])


if __name__ == '__main__':
    app.run_server(debug=True)
