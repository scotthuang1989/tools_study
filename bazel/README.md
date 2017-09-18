## Basic concept

### Workspace

* A directory that contains source code for the software you want to build, symbolic links to directories that contains the build outputs (eg, bazel-bin, bazel-out)
* Must contain a a file called `WORKSPACE ` in the top-level directory.

### Build file

* Very similar to Makefile

* A sequence of declarations of rules, Each rule specifies its inputs, outputs, and a way to compute the outputs from the inputs.
