#import dash
#import dash_core_components as dcc
#import dash_html_components as html
#
#external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
#
## initilaize the application
#app = dash.Dash(__name__, external_stylesheets = external_stylesheets)
#
## NEW:
#colors = {
#          'background': '#111111',
#          'text': '#7FDBFF'
#         }
#
#
## Divider, with background color
## - because we want all of the components to have the same background!!!
## - we supply a dictionary to style, as opposed to a semicolon sepperated string used in html.
##       - the keys in style are camel cased textalign -> textAlign
## children: is always the first arguemnt, and is therefore often omitted.
#app.layout(html.Div(style={'backgroundColor': colors['background']}),children=[
#
#    # HEADER (colored text, centered)
#    html.H1(
#        children = 'Second Dash Program',
#        style={
#            'textAlign':'center',
#            'color': colors['text']
#        }
#    ),
#    # Paragraph (colored text, centered)
#    html.Div(children='Dash: is a web application framework', style={
#        'textAlign':'center',
#        'color': colors['text']
#    }),
#
#    dcc.Graph(
#        id='example-graph-2',
#        figure={
#            'data': [
#                {'x': [1, 2, 3], 'y': [4, 1, 2], 'type': 'bar', 'name': 'SF'},
#                {'x': [1, 2, 3], 'y': [2, 4, 5], 'type': 'bar', 'name': u'Montréal'},
#            ],
#            'layout': {
#                'plot_bgcolor': colors['background'],
#                'paper_bgcolor': colors['background'],
#                'font': {
#                    'color': colors['text']
#                }
#            }
#        }
#    )
#
#
#])
#
#
#if __name__ == '__main__':
#    app.run_server(debug=True)




import dash
import dash_core_components as dcc
import dash_html_components as html

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

colors = {
    'background': '#111111',
    'text': '#7FDBFF'
}

app.layout = html.Div(style={'backgroundColor': colors['background']}, children=[
    html.H1(
        children='Hello Dash',
        style={
            'textAlign': 'center',
            'color': colors['text']
        }
    ),

    html.Div(children='Dash: A web application framework for Python.', style={
        'textAlign': 'center',
        'color': colors['text']
    }),

    dcc.Graph(
        id='example-graph-2',
        figure={
            'data': [
                {'x': [1, 2, 3], 'y': [4, 1, 2], 'type': 'bar', 'name': 'SF'},
                {'x': [1, 2, 3], 'y': [2, 4, 5], 'type': 'bar', 'name': u'Montréal'},
            ],
            'layout': {
                'plot_bgcolor': colors['background'],
                'paper_bgcolor': colors['background'],
                'font': {
                    'color': colors['text']
                }
            }
        }
    )
])

if __name__ == '__main__':
    app.run_server(debug=True)
