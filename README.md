# cicd-runner

## To configure a new runner 

1) Set the permissions of `configure_one.sh` to executable.
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
    ```

4) The new runner will be installed in a new directory with the same name as the new runner. (Refer to command output of the previous step for the name of the new runner)