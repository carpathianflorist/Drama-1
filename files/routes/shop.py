from files.__main__ import app
from files.helpers.wrappers import *
from files.classes.shop import *


@app.get("/shop")
@auth_required
def shop_index(v):

    return render_template("shop/shop.html", v=v)


@app.get("/api/items")
def shop_items_get():

    cats_only = bool(int(request.args.get("cats_only", "0")))

    # option to load only categories without items
    if cats_only:

        # don't need to load related items here - overwrite default load with lazy load
        queer = g.db.query(ShopCategory).options(lazyload('*')).all()

        return jsonify([x.json_noitems for x in queer])

    queer = g.db.query(ShopCategory).all()

    return jsonify([x.json for x in queer])
