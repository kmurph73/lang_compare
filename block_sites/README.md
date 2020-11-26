modify /etc/hosts so that

```
127.0.0.1 localhost
255.255.255.255 broadcasthost
::1             localhost

# blocked sites start

# 127.0.0.1 www.reddit.com
# 127.0.0.1 old.reddit.com

# blocked sites end

# 127.0.0.1 old.reddit.com
```

turns into

```
127.0.0.1 localhost
255.255.255.255 broadcasthost
::1             localhost

# blocked sites start

127.0.0.1 www.reddit.com
127.0.0.1 old.reddit.com

# blocked sites end

# 127.0.0.1 old.reddit.com
```
