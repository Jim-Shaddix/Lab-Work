
# import Flask class from module
from flask import Flask, render_template, url_for

posts = [
            {
                'author': 'James Shaddix',
                'title': 'Blog Post 1',
                'content': 'First post',
                'date_posted': 'Dec 17, 2018',
            },
            {
                'author': 'William Shaddix',
                'title': 'Blog Post 2',
                'content': 'Second post',
                'date_posted': 'Dec 17, 2018',
            }
]

# app is equal to instance of flask class
#   - allows for pathing to be used
#   - tells flask where to look for files
app = Flask(__name__)


# the app.route decorator:
#   - will make the return of a function,
#     be displayed on the webpage, specified by
#     the arguemnt.
#   - use render_template, to use an html file
#       from a templates directory!!!
@app.route("/")
@app.route("/home")
def home():

    # we can pass any keyword arguemnts... i guess it uses kwargs
    return render_template("home.html", posts=posts)


@app.route("/about")
def about():
    return render_template("about.html", title="about")

if __name__ == "__main__":
    app.run(debug=True)
