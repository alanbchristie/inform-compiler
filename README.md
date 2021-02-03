# inform-compiler

![build](https://github.com/alanbchristie/inform-compiler/workflows/build/badge.svg)
![build latest](https://github.com/alanbchristie/inform-compiler/workflows/build%20latest/badge.svg)

A container image to compile Interactive Fiction ([Inform-7]) projects,
compiling text (in `story.in`) into a `story.gblorb` file.

Rather than install the Inform-7 command-line tools on the host this project
builds a container image (`alanbchristie/inform-compiler:latest`) that can be
used anywhere a container can be used.

To compile an Inform-7 project's Interactive Fiction (a `story.ni`) the user
simply needs to run the container image, mounting their project directory
into the container's `/stroy.inform` directory. The container then compiles
the story (into a `story.gblurb` file) before stopping.

To start with the very least you'll need is a project - essentially a directory
with a `Source/story.ni` file in it. To compile the story simply pass the
project into the container.

So, if your story is in `/my-files/project.inform` compile it with the
following docker command: -

    $ docker run \
        -v /my-files/project.inform:/story.inform \
        alanbchristie/inform-compiler:latest

In this example you'll find the resultant `story.gblorb` in
`/my-files/project.inform:/story.inform`.

## Building the image
The image is built automatically using GitHub Actions and available
on [Docker Hub]. You can build your own image using docker: -

    $ docker build . -t alanbchristie/inform-compiler:latest

---

[docker hub]: https://hub.docker.com
[inform-7]: http://inform7.com
