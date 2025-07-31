FROM ajetunmobi/kuberepo:django1.0
ENV PYTHONUNBUFFERED=1 
RUN useradd djangouser
RUN mkdir /home/myapp
RUN chown djangouser:djangouser /home/myapp && chmod 700 /home/myapp
RUN su djangouser
WORKDIR /home/myapp
COPY . .
RUN mkdir /home/myapp/media
VOLUME /home/myapp/media
RUN pip install -r requirements.txt
RUN find /home/myapp -type d -exec chown djangouser {} \;
RUN find /home/myapp -type f -exec chown djangouser {} \;
USER djangouser
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate
EXPOSE 80
CMD ["python3","manage.py", "runserver", "0.0.0.0:8000"]
