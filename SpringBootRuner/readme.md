# Spring Boot App Runner

This script is designed to run multiple Spring Boot applications in separate gnome-terminal windows. It is useful for developers who work on multiple Spring Boot applications and want to run them simultaneously.

## Prerequisites

- gnome-terminal app
- Maven

## Usage

1. Place the script in the root folder of your Spring Boot applications.
2. Open the terminal and navigate to the root folder.
3. Run the script using the following command:

    ```bash
    ./spring-boot-app-runner.sh
    ```

4. The script will display a list of Spring Boot applications found in the root folder.
5. Enter the sequence of the applications you want to run. The order is significant.
6. Optionally, enter the number of seconds you want to sleep between running each application.
7. The script will open a separate gnome-terminal window for each application and run it using Maven.

## Note

- If gnome-terminal app is not installed on your system, the script will prompt you to install it using the command `sudo apt install gnome-terminal`.
- If the script cannot find any Spring Boot application in the root folder, it will display an error message and exit.
- If you enter an invalid sequence of application numbers, the script will display an error message and exit.
- You can run this with any parameter and then number of services that you run,
    or you can run it with number of services you want to start and number of sleep you want for example:
    ```bash
        ./sprin-boot-app-runer.sh 123 2
    ```
  with this command 1, 2 and 3 services are start, first services start and then sleep 5 second,
    and then start second service and then 5 second sleep and then start third service :)