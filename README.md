# Introduction

TODO

# Contributing

You can contribute to the IG development by creating your own fork and submitting pull requests. While you are making local changes on your machine, you'll likely want to build the IG to see the results before committing.  This can be done by running the `./build.sh` script in the `/ig` directory. The build depends on having Docker installed and running on your machine.

Once you have committed and pushed your new branch to your fork, you can choose to also have the IG site be built and published for your branch. If you have GitHub actions enabled for your fork, and you create a pull request to your oun forked repository, a build should run whenever there are IG changes pushed to your branch. Once you are happy with the results, you can also create a pull request against the upstream repository. Such a pull request will also trigger a build under the upstream repository.

# IG builds

The IG can be built locally with the `build.sh` script as described above.

The GitHub Actions based build works as follows:
* A push to a branch named `main, master, dev, or development`, or a pull request for any other branch, will trigger a build of the latest commit from that branch.
* The built IG is published through GitHub Pages by committing the content of the IG `output` folder to a path in the `gh-pages` branch.
* You can see the links to the built sites at [this page](https://github.com/phenopackets/core-ig/blob/gh-pages/IG_BUILDS.md) or a similar page in your own repository if you enable GitHub Actions builds in your own fork.
* It is possible that a `merged` IG site is also built for your pull request. This occurs when the target/base branch (the branch that your PR will be merged into based on your PR request) has moved from when you started your branch. This temporary `merged` site shows you the overall outcome of merging your changes and how they might be affected by or affect other changes since you started your branch. This `merged` site can be reached with the link that is suffixed with `_MERGED`.
