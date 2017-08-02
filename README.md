# docker-jdownloader

Dockerized JDownloader (version 2) on top of Alpine Linux.

It uses:

* `supervisord` to manage processes
* `logrotate` to rotate logs
* `rsyslog` to send logs to your logging facility (defaults to 127.0.0.1)

## Version

1.0.1

## Instructions

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

## FAQ

### Out-of-memory errors

If your host is a Alpine Linux machine, you may get Java out of memory error
(reason: permission denied). This is because you need to enable pax softmode,
edit `/etc/sysctl.d/01-pax.conf` and add:

```
kernel.pax.softmode=1
```

Now re-create the service and you shouldn't get out-of-memory errors anymore.
