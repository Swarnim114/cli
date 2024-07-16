#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>

void handle_sigchld(int sig) {
    // Wait for any child process
    while(waitpid(-1, NULL, WNOHANG) > 0);
}

void create_zombie_process() {
    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(EXIT_FAILURE);
    } else if (pid == 0) {
        // Child process: immediately terminate
        exit(EXIT_SUCCESS);
    } else {
        // Parent process: sleep for a bit to allow child to terminate
        sleep(2);
    }
}

void create_orphan_process() {
    pid_t pid = fork();

    if (pid < 0) {
        perror("fork");
        exit(EXIT_FAILURE);
    } else if (pid == 0) {
        // Child process: sleep for a bit to ensure parent terminates first
        sleep(5);
        // Print new parent process ID (should be 1, init or systemd)
        printf("Orphan process adopted by PID: %d\n", getppid());
        exit(EXIT_SUCCESS);
    } else {
        // Parent process: immediately terminate
        exit(EXIT_SUCCESS);
    }
}

int main() {
    struct sigaction sa;
    sa.sa_handler = &handle_sigchld;
    sa.sa_flags = SA_RESTART | SA_NOCLDSTOP;
    sigemptyset(&sa.sa_mask);

    if (sigaction(SIGCHLD, &sa, 0) == -1) {
        perror("sigaction");
        exit(EXIT_FAILURE);
    }

    printf("Creating zombie process...\n");
    create_zombie_process();

    printf("Creating orphan process...\n");
    create_orphan_process();

    // Sleep to keep the parent process alive for a while to demonstrate orphan process handling
    sleep(10);

    return 0;
}
