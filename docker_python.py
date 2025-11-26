import os

import docker


######################
### Docker Related ###
######################

def get_current_directory():
    """
    Returns the current directory.
    """
    path = os.getcwd()

    # if os.name == 'nt':
    #     path = path.replace('\\', '/')
    #     path = path.replace(path[0:2], '/'+path[0])
    # elif os.name == 'posix':
    #     pass
    # else:
    #     print("The docker code was not tested on this OS. Please double check the path formatting.")

    return path

def transfer_path_by_system(path):
    """
    Transfers the path to the system format.
    """
    # print(path)
    if os.name == 'nt':
        path = path.replace('\\', '/')
        path = path.replace(path[0:2], '/'+path[0])
    elif os.name == 'posix':
        pass
    else:
        print("The docker code was not tested on this OS. Please double check the path formatting.")
    # print(path)
    
    return path

def start_container(path):
    """
    Starts the container and mounts the given path.
    """
    # Initialize the Docker client
    client = docker.from_env()

    # Define the container options
    container = client.containers.run(
        "zupermind/mcdp:2025",  # Image name
        command="bash -l",  # Command to execute
        auto_remove=True,  # Equivalent to --rm
        tty=True,  # Equivalent to -t
        stdin_open=True,  # Equivalent to -i
        volumes={
            path: {
                "bind": transfer_path_by_system(path),
                "mode": "rw"
            }
        },  # Equivalent to -v
        working_dir=transfer_path_by_system(path),  # Equivalent to -w
        detach=True  # Keep the container attached
    )

    return container

def run_command_in_container(container, command):
    """
    Executes a command in the given container and returns the output.
    """
    exec_result = container.exec_run(command, stdout=True, stderr=True)

    output = exec_result.output.decode('utf-8')
    
    return output

    # exec_result, stream = container.exec_run(command, stdout=True, stderr=True, stream=True)
    # if stream:
    #     for line in stream:
    #         print(line.decode('utf-8'), end='')
    # return exec_result