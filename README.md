# cicd-runner

## To configure and register a new runner 

1) Set the permissions of `configure_one.sh` to executable if not already so.
    ```bash
    $ chmod +x configure_one.sh
    ```

2) Browse to this [link](https://github.com/organizations/IFS4205-TraceIT/settings/actions/runners/new?arch=x64&os=linux) to get a new runner token.
    ```bash
    # Scroll down the page, under the "Configure" section
    $ ./config.sh --url https://github.com/IFS4205-TraceIT --token <RUNNER_TOKEN> # <--- Retrieve this last value
    ```

3) Run `configure_one.sh` with the retrieved runner token.
    ```bash
    $ RUNNER_TOKEN=<RUNNER_TOKEN> ./configure_one.sh
    # e.g RUNNER_TOKEN=AAAAA... ./configure_one.sh
    ```

4) The new runner will be installed in a new directory with the same name (e.g `github-action-***`) as the new runner. (Refer to command output of the previous step for the name of the new runner)

## To deregister and remove a runner

1) Ensure the runner is not running.

2) Set the permissions of `remove_one.sh` to executable if not already so.
    ```bash
    $ chmod +x remove_one.sh
    ```

3) Browse to this [link](https://github.com/organizations/IFS4205-TraceIT/settings/actions/runners) and click on the name of the runner to be removed.

4) Click on `Remove` and copy the runner token.
    ```bash
    # Under the "Remove and clean up machine (recommended)" section
    ./config.sh remove --token <RUNNER_TOKEN> # <--- Retrieve this last value
    ```

3) Run `remove_one.sh` with the retrieved runner token and the name of the runner.
    ```bash
    $ RUNNER_NAME=<RUNNER_NAME> RUNNER_TOKEN=<RUNNER_TOKEN> ./remove_one.sh
    # e.g RUNNER_NAME=github-action-... RUNNER_TOKEN=AAAAA... ./remove_one.sh
    ```