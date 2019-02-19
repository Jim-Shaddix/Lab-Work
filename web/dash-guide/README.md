

# Dash #
- dash is declaritive (as opposed to imperative): we use a bunch of high 
    level expressions, rather than writing out each logical step.
1. composed of 3 different libraries
    1. dash
    2. dash_core_components 
        - higher level componenets with interactivity
        - each component is described through keyword arguements
        - children is always the first keyword attribute
            - accepts either "string", single-component, or list of components
    3. dash_html_components: 
        - used for all html tags
            - use keyword arguemnts, for tags
    4. uses "hot-reloading" if:
        - app.run_server(debug=True)
        which means it will reload on save.
    5.  
2. 2 parts:
    1. layout
    2. interactivity



