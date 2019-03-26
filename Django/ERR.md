## ERROR
#### ERR 1、mysql has gone away
###### Django framework default run close_old_connections in every request middleware to avoid "mysql has gone away".
    from django.db import connections, close_old_connections
    close_old_connections()
