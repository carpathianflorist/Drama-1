from files.helpers.wrappers import *
from files.helpers.alerts import *
from files.helpers.get import *
from files.classes import *
from flask import *
from files.__main__ import app

@app.get("/authorize")
@auth_required
def authorize_prompt(v):
	client_id = request.args.get("client_id")
	application = g.db.query(OauthApp).filter_by(client_id=client_id).first()
	if not application: return {"oauth_error": "Invalid `client_id`"}, 401
	return render_template("oauth.html", v=v, application=application)


@app.post("/authorize")
@auth_required
@validate_formkey
def authorize(v):

	client_id = request.form.get("client_id")
	application = g.db.query(OauthApp).filter_by(client_id=client_id).first()
	if not application: return {"oauth_error": "Invalid `client_id`"}, 401
	access_token = secrets.token_urlsafe(128)[:128]
	new_auth = ClientAuth(
		oauth_client = application.id,
		user_id = v.id,
		access_token=access_token
	)

	g.db.add(new_auth)

	return redirect(f"{application.redirect_uri}?token={access_token}")


@app.post("/api_keys")
@is_not_banned
def request_api_keys(v):

	new_app = OauthApp(
		app_name=request.form.get('name'),
		redirect_uri=request.form.get('redirect_uri'),
		author_id=v.id,
		description=request.form.get("description")[:256]
	)

	g.db.add(new_app)

	send_admin(1046, f"@{v.username} has requested API keys for `{request.form.get('name')}`. You can approve or deny the request [here](/admin/apps).")

	return redirect('/settings/apps')


@app.post("/delete_app/<aid>")
@is_not_banned
@validate_formkey
def delete_oauth_app(v, aid):

	aid = int(aid)
	app = g.db.query(OauthApp).filter_by(id=aid).first()

	for auth in g.db.query(ClientAuth).filter_by(oauth_client=app.id).all():
		g.db.delete(auth)

	g.db.delete(app)

	return redirect('/apps')


@app.post("/edit_app/<aid>")
@is_not_banned
@validate_formkey
def edit_oauth_app(v, aid):

	aid = int(aid)
	app = g.db.query(OauthApp).filter_by(id=aid).first()

	app.redirect_uri = request.form.get('redirect_uri')
	app.app_name = request.form.get('name')
	app.description = request.form.get("description")[:256]

	g.db.add(app)

	return redirect('/settings/apps')


@app.post("/admin/app/approve/<aid>")
@admin_level_required(3)
@validate_formkey
def admin_app_approve(v, aid):

	app = g.db.query(OauthApp).filter_by(id=aid).first()
	user = app.author

	app.client_id = secrets.token_urlsafe(64)[:64]
	g.db.add(app)

	access_token = secrets.token_urlsafe(128)[:128]
	new_auth = ClientAuth(
		oauth_client = app.id,
		user_id = user.id,
		access_token=access_token
	)

	g.db.add(new_auth)

	send_notification(1046, user, f"Your application `{app.app_name}` has been approved. Here's your access token: `{access_token}`\nPlease check the guide [here](/api) if you don't know what to do next.")

	return {"message": f"{app.app_name} approved"}


@app.post("/admin/app/revoke/<aid>")
@admin_level_required(3)
@validate_formkey
def admin_app_revoke(v, aid):

	app = g.db.query(OauthApp).filter_by(id=aid).first()

	for auth in g.db.query(ClientAuth).filter_by(oauth_client=app.id).all(): g.db.delete(auth)

	g.db.flush()
	send_notification(1046, app.author, f"Your application `{app.app_name}` has been revoked.")

	g.db.delete(app)

	return {"message": f"App revoked"}


@app.post("/admin/app/reject/<aid>")
@admin_level_required(3)
@validate_formkey
def admin_app_reject(v, aid):

	app = g.db.query(OauthApp).filter_by(id=aid).first()

	for auth in g.db.query(ClientAuth).filter_by(oauth_client=app.id).all(): g.db.delete(auth)

	g.db.flush()
	send_notification(1046, app.author, f"Your application `{app.app_name}` has been rejected.")

	g.db.delete(app)

	return {"message": f"App rejected"}


@app.get("/admin/app/<aid>")
@admin_level_required(3)
def admin_app_id(v, aid):

	aid=aid

	oauth = g.db.query(OauthApp).options(
		joinedload(
			OauthApp.author)).filter_by(
		id=aid).first()

	pids=oauth.idlist(page=int(request.args.get("page",1)),
		)

	next_exists=len(pids)==101
	pids=pids[:100]

	posts=get_posts(pids, v=v)

	return render_template("admin/app.html",
						   v=v,
						   app=oauth,
						   listing=posts,
						   next_exists=next_exists
						   )

@app.get("/admin/app/<aid>/comments")
@admin_level_required(3)
def admin_app_id_comments(v, aid):

	aid=aid

	oauth = g.db.query(OauthApp).options(
		joinedload(
			OauthApp.author)).filter_by(
		id=aid).first()

	cids=oauth.comments_idlist(page=int(request.args.get("page",1)),
		)

	next_exists=len(cids)==101
	cids=cids[:100]

	comments=get_comments(cids, v=v)


	return render_template("admin/app.html",
						   v=v,
						   app=oauth,
						   comments=comments,
						   next_exists=next_exists,
						   standalone=True
						   )


@app.get("/admin/apps")
@admin_level_required(3)
def admin_apps_list(v):

	apps = g.db.query(OauthApp).all()

	return render_template("admin/apps.html", v=v, apps=apps)


@app.post("/oauth/reroll/<aid>")
@auth_required
def reroll_oauth_tokens(aid, v):

	aid = aid

	a = g.db.query(OauthApp).filter_by(id=aid).first()

	if a.author_id != v.id: abort(403)

	a.client_id = secrets.token_urlsafe(64)[:64]
	g.db.add(a)

	return {"message": "Client ID Rerolled", "id": a.client_id}