
# -*- coding: utf-8 -*-
import dash
import dash_core_components as dcc
import dash_html_components as html

"""
    Div tags: tags used in html to group elements together. 
        - generally div tags are used to group elements of html together
          so that you can apply the css template to them.
        - hear, strings are interpreted as paragraph tags I guess. 
          (judging by how they just add another div tag, rather that a paragraph tag)
      
    Children argument for html: 
        - specify what goes inbetween tags produced
        - other arguemnts for html components represent the other arguemnts for the tag.
    Dash Core Components:
        - use Javascript, html, and css
"""


external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

app.layout = html.Div(children=[
    html.H1(children='Hello Dash MAN'),

    html.Div(children='''
        Dash: A web application framework for Python.
    '''),

    dcc.Graph(
        id='example-graph',
        figure={
            'data': [
                {'x': [1, 2, 3], 'y': [4, 1, 2], 'type': 'bar', 'name': 'SF'},
                {'x': [1, 2, 3], 'y': [2, 4, 5], 'type': 'bar', 'name': u'Montréal'},
            ],
            'layout': {
                'title': 'Dash Data Visualization'
            }
        }
    )
])

if __name__ == '__main__':

    # HOT RELOADING: Dash will refresh browser when you make a change in the code
    app.run_server(debug=True)

