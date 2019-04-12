import dash
import dash_core_components as dcc
import dash_html_components as html


app = dash.Dash(__name__)

colors = {
    'background': '#111111',
    'text': '#7FDBFF'
}

app.layout = html.Div(
    style={'backgroundColor': colors['background']}, children=[

        # application title
        html.H1("Application Title",
                style={
                    'textAlign': 'center',
                    'color': colors['text']
                }
        ),

        # application note
        html.Div("Dash application description",
                style={
                    'textAlign': 'center',
                    'color': colors['text']
                }
        ),

        dcc.Graph(
            id="Graph Title",
            figure={
                "data": [
                    {'x': [1, 2, 3], 'y': [4, 1, 2], 'type': 'bar', 'name': 'SF'},
                    {'x': [1, 2, 3], 'y': [2, 4, 5], 'type': 'bar', 'name': u'Montréal'}
                ],
                "layout": {
                    'plot_bgcolor':  colors["background"],
                    'paper_bgcolor': colors["background"],
                    "font":{'color':colors['text']}
                }
            }
        )
    ])

if __name__ == '__main__':
    app.run_server(debug=True)
