# SSH

## Use cases

-   Simple `ssh` connection

    ```sh
    ssh <user>@<remote-server>
    ```

    Where,

    -   user = user on the remote server
    -   remote-server = domain name or IP address

-   Tunnel or port forwarding

    ```sh
    ssh -L <local-port>:<remote-server>:<server-port> <jump-server>
    ```

    Example:

    ```sh
    ssh -L 8080:ssh.example.com:9090 -N -f root@ssh.example.com
    ```

    Where,

    -   `-L` specifies the target remote server to `ssh` into.
    -   `-N` specifies the session is non-interactive.
    -   `-f` specifies the `ssh` client to run in background.
    -   `root` is the user on the remote jump server.

    Note: The jump server could be standalone (different domain name/IP address) or could be the same as remote server.

## SSH Keypair

-   Create

```sh
ssh-keygen -t rsa -b 4096
```

or

```sh
ssh-keygen -t ecdsa -b 521
```

-   Copy key to server

```sh
ssh-copy-id -i ~/.ssh/key_id <remote_user>@<host>
```

```{warning}
Storing ssh keypairs in plain text is a security risk. Consider using a hardened management system to store such keys.
```

## FAQs

-   Permission is too open error

```
chmod -R 600 ~/.ssh
```

-   Permission denied

Try changing permission with non-root first. If not, then root.

```
chown <user>:<user_group> -R ~/.ssh
```