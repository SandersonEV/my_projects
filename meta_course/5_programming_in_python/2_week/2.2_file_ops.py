def read_file(file_name):
    """ Reads in a file.

    [IMPLEMENT ME]
        1. Open and read the given file into a variable using the File read()
           function
        2. Print the contents of the file
        3. Return the contents of the file

    Args:
        file_name: the name of the file to be read

    Returns:
        string: contents of the given file.
    """
    with open(file_name, 'r') as f:
        sam = f.read()
        print(sam)
    return sam
    
    raise NotImplementedError()

def read_file_into_list(file_name):
    """ Reads in a file and stores each line as an element in a list

    [IMPLEMENT ME]
        1. Open the given file
        2. Read the file line by line and append each line to a list
        3. Return the list

    Args:
        file_name: the name of the file to be read

    Returns:
        list: a list where each element is a line in the file.
    """
    with open(file_name, 'r') as f:
        file = f.readlines()

    return file

    raise NotImplementedError()

def write_first_line_to_file(file_contents, output_filename):
    """ Writes the first line of a string to a file.

    [IMPLEMENT ME]
        1. Get the first line of file_contents
        2. Use the File write() function to write the first line into a file
           with the name from output_filename

        We determine the first line to be everything in a string before the
        first newline ('\n') character.

    Args:
        file_contents: string to be split and written into output file
        output_filename: the name of the file to be written to
    """
    to_write = file_contents.split('\n')[0] # gets only the first line from the .txt

    with open(output_filename, 'w') as o:
        o.write(to_write)

    return o

    raise NotImplementedError()


def read_even_numbered_lines(file_name):
    """ Reads in the even numbered lines of a file

    [IMPLEMENT ME]
        1. Open and read the given file into a variable
        2. Read the file line-by-line and add the even-numbered lines to a list
        3. Return the list

    Args:
        file_name: the name of the file to be read

    Returns:
        list: a list of the even-numbered lines of the file
    """

    with open(file_name, 'r') as f:
        f_list = f.readlines()


    even_list = []
    
    for index, x in enumerate(f_list): 
        if index % 2 == 0:
            even_list.append(x)

    return even_list

    raise NotImplementedError()

def read_file_in_reverse(file_name):
    """ Reads a file and returns a list of the lines in reverse order

    [IMPLEMENT ME]
        1. Open and read the given file into a variable
        2. Read the file line-by-line and store the lines in a list in reverse order
        3. Print the list
        4. Return the list

    Args:
        file_name: the name of the file to be read

    Returns:
        list: list of the lines of the file in reverse order.
    """

    with open(file_name, 'r') as f:
        f_content = f.readlines()
        f_content.reverse()

    print(f_content)
    return f_content

    raise NotImplementedError()

'''
Here are some sample commands to help you run/test your implementations.
'''
def main():
    file_contents = read_file("sampletext.txt")
    print('\n','read_file_into_list:','\n',read_file_into_list("sampletext.txt"),'\n')
    write_first_line_to_file(file_contents, "online.txt")
    print('\n','read_even_numbered_lines:','\n',read_even_numbered_lines("sampletext.txt"),'\n')
    print('\n','read_file_in_reverse:','\n',read_file_in_reverse("sampletext.txt"),'\n')

if __name__ == "__main__":
    main()
