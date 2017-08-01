# docker-jdownloader

Dockerized JDownloader (version 2) on top of Alpine Linux.

It uses:

* `supervisord` to manage processes
* `logrotate` to rotate logs
* `rsyslog` to send logs to your logging facility (defaults to 127.0.0.1)

To run it, you need to have inside folder `cfg` a file named
`org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json` containing:

```
{
  "email": "your@email.com",
  "password": "yourpassword"
}
```

Where email and password are those used to register to
https://my.jdownloader.org

After starting the container, you can see and manage your dockerized jdownloader
through the web interface available at https://my.jdownloader.org

## Version

1.0.0
