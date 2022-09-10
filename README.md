# cicd-runner

## To setup the `cicd` user

1) Set the permissions of `setup_cicd_user.sh` to executable if not already so.
    ```bash
    $ chmod +x setup_cicd_user.sh
    ```
2) Run `setup_cicd_user.sh`
    ```bash
    $ ./setup_cicd_user.sh
    ```

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

3) As the `cicd` user, run `configure_one.sh` with the retrieved runner token.
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

5) As the `cicd` user, run `remove_one.sh` with the retrieved runner token and the name of the runner.
    ```bash
    $ RUNNER_NAME=<RUNNER_NAME> RUNNER_TOKEN=<RUNNER_TOKEN> ./remove_one.sh
    # e.g RUNNER_NAME=github-action-... RUNNER_TOKEN=AAAAA... ./remove_one.sh
    ```

## Setup workflow

As `root` or via `sudo` to `root`,

1) Run `setup-cicd-user.sh`.

2) Clone the repo for the `cicd` user
    ```bash
    $ runuser -l cicd -c 'git clone https://github.com/IFS4205-TraceIT/cicd-runner'
    ```

3) For each required runner, run `configure_one.sh`:
    ```bash
    $ runuser -l cicd -c 'cd ~/cicd-runner && chmod +x ./configure_one.sh && RUNNER_TOKEN=... RUNNER_LABELS=... ./configure_one.sh'
    ```

4) Install and start each runner as a service
    ```bash
    $ bash -c 'cd /home/cicd/cicd-runner/github-runner-... && ./svc.sh install cicd && ./svc.sh start'
    ```