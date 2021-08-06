from files.__main__ import app
from files.helpers.wrappers import *


@app.route("/shop")
@auth_required
def shop_index(v):

    return render_template("shop/shop.html", v=v)
