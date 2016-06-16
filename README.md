# packagemaker

## Usage

- Clone this repo
- Build the container

```
docker build -t packagemaker .
```

- Compile the package

```
docker run -it --rm -v ~/:/dist packagemaker
```

The package will be available in the home directory.

## Limitation

- It's only x86_64.
- only for debian package?
