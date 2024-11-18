# reDockable

Okay, these names are getting out of hand. This is a Docker image that runs an SSH server on Ubuntu 20.04. It modifies the `/usr/share` directory to contain an identical file structure to a reMarkable tablet. It also enables ssh access to root with a customizable password. This is done to act as a sandbox environment for developing reMarkable modifications. With this you can test loading modifications onto a reMarkable without actually modifying, and possibly bricking, a reMarkable.

I should note, this repo only contains a very small subset of reMarkable files. These are the files related to modifying state screens and templates. However, feel free to dump your entire `/usr/share/remarkable` directory into the `remarkable` folder before building the Docker image.

If you're wondering why I would need a reMarkable sandbox, check out my project called [rePlace](https://danielstoiber.com/project/replace#redockable).

<!-- rePlace Project Card -->
<a href="https://danielstoiber.com/project/replace">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://danielstoiber.com/api/project-image.svg?projectId=replace&hideTools=true&darkMode=true">
    <img alt="Most recent project card" src="https://danielstoiber.com/api/project-image.svg?projectId=replace&hideTools=true">
  </picture>
</a>

This Docker image is inspired by [aoudiamoncef's ubuntu-sshd repository](https://github.com/aoudiamoncef/ubuntu-sshd).

## Usage

### Cloning the Repository

```bash
git clone https://github.com/da-stoi/redockable
cd redockable
```

### Building the Docker Image

Build the Docker image, copying the `remarkable` folder into the image:

```bash
docker build -t redockable:latest .
```

### Running a Container

To run a container based on the image that you just built, run the following command:

```bash
docker run -d \
  --name redockable \
  -p 22:22 \
  -e SSH_PASSWORD=redockable \
  redockable:latest
```

- `-d` runs the container in detached mode.
- `--name redockable` names the container `redockable`.
- `-p 22:22` maps your machine's port 22 to port 22 in the container. Modify the first port number to use a different port on your machine.
- `-e SSH_PASSWORD=redockable` sets the SSH user's password in the container. **Required**.

### Connecting to a Container

#### Using rePlace

1. Enable developer mode in the rePlace settings.
2. Add a new device with the new device type `reDockable`.
   - If you are connecting from the same machine that is running the container and you are using port 22, all you'll need to enter is the password you set when running the container.
   - If you are connecting from a different machine, you'll need to enter the IP address of the machine running the container and the port you mapped to port 22 in the container. (Double-check that the network isn't client-isolated, or blocks any ports.)
3. Connect to the device!

#### Using SSH

Connecting to the container is as simple as it gets:

```bash
ssh root@localhost
```

- If you are connecting from a different machine, replace `localhost` with the IP address of the machine running the container.
- If you are using a port other than 22, add `-p <port>` to the command.

#### Using SCP

You can also use SCP to transfer files to and from the container:

```bash
scp local/path/to/screen.png root@localhost:/usr/share/remarkable/
```

- If you are connecting from a different machine, replace `localhost` with the IP address of the machine running the container.
- If you are using a port other than 22, add `-P <port>` to the command.

## License

This Docker image is provided under the [MIT License](LICENSE).
