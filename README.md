1] make a dockerignore file to not to import virtual environment to container
2] make requirements.txt by pip3 freeze > requirements.txt
3] add gunicorn==19.9.0 to requirements.txt for running production server
4] Update the SECRET_KEY, DEBUG, and ALLOWED_HOSTS variables in settings.py
	SECRET_KEY = os.environ.get('SECRET_KEY', default='foo')
	DEBUG = int(os.environ.get('DEBUG', default=0))
	ALLOWED_HOSTS = ['localhost', '127.0.0.1','NAME.herokuapp.com']
	*NAME is the name of slug which u get from web console or heroku create  command
5] add a .gitignore file
7] add whitenoise==4.1.2 to requirements.txt for managing static content
8] add  'whitenoise.middleware.WhiteNoiseMiddleware' to MIDDLEWARE in settings.py
9] add path for static files and compression and caching support
	STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
	STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
10] build and run container
	docker build -t web:latest .
	docker run -d --name testapp -e "PORT=8765" -e "DEBUG=1" -p 80:8765 web:latest 
11] For sending this container to first do heroku authentication
	heroku container:login
	heroku auth:token
	docker login --username=EMAIL --password=TOKEN registery.heroku.com
12] For final launch 
	heroku container:push web --app NAME
	heroku container:release web -a NAME
