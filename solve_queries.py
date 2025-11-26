from docker_python import start_container, run_command_in_container, get_current_directory, transfer_path_by_system

import yaml


def main():
    # Read the template catalog yaml file
    with open("reinforced_concrete.mcdplib/concrete_catalogues/concrete_catalogue_1.yaml", 'r', encoding="UTF-8") as file_stream:
        data = yaml.safe_load(file_stream)
        print(f"Template Catalogue Data schema: {data.keys()}")

        # see the first implementation of the template catalogue
        implementation_name = next(iter(data['implementations'].keys()))
        print(f"Implementation name: {implementation_name}")
        implementation = data['implementations'][implementation_name]
        print(f"Implementation: {implementation}")

        # write the implementation to the actual catalogue file
        with open("rover_continuous.mcdplib/battery_catalogues/battery_catalogue_run.yaml", 'w', encoding="UTF-8") as file_stream:
            yaml.dump(data, file_stream)

    # start the docker container
    curret_path = transfer_path_by_system(get_current_directory())
    container_instance = start_container(curret_path)

    # run mcdp solver for a specific query
    query = "rover_continuous.concrete_section"
    output = run_command_in_container(container_instance, f"mcdp-solve-query {query}")
    print(output)

    # read the output file and parse the results. Pay attention to which output file you are reading!
    with open("out/out-000/output.yaml", 'r', encoding="UTF-8") as file_stream:
        data = yaml.safe_load(file_stream)
        optimistic_antichain = eval(data['optimistic']['minimals'])
        print("Optimistic antichain:")
        print(optimistic_antichain)
        for resource_element in optimistic_antichain:
            print("Resource element:")
            print(resource_element)
            for single_resource in resource_element:
                print("Single resources in the resource antichain:")
                print(single_resource)
                if isinstance(single_resource, tuple):
                    print("The resource element is a Tuple (element in the product of posets)")
                    print(single_resource[0])
                    print(single_resource[1])

    # Do as many queries as you want!

    # Stop the container when done
    container_instance.stop()

if __name__ == '__main__':
    main()
  