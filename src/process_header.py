#!/usr/bin/python3

import os
import sys
import re

def process_deprecation(input_path, output_path):
    """
    Reads a C header file, adds a deprecation attribute ONLY to functions
    found within a deprecation section, and leaves all other code untouched.
    """
    in_deprecated_section = False
    deprecation_attribute = '__attribute__((deprecated("This function is deprecated by its library.")))'

    # Ensure the output directory for the current file exists
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    with open(input_path, 'r') as infile, open(output_path, 'w') as outfile:
        for line in infile:
            stripped_line = line.strip()

						# Regex to find a #define with a name but nothing after it.
            # `\s*` handles trailing whitespace, `$` anchors to the end of the line.
            match = re.match(r'#define\s+([a-zA-Z0-9_]+)\s*$', stripped_line)
            
            if match:
                macro_name = match.group(1)
                # Rewrite the line, adding a '1' to make it a valid valued macro.
                outfile.write(f'#define {macro_name} 1\n')
                continue

            if stripped_line.startswith('// Deprecated '):
                in_deprecated_section = True
                outfile.write(line)
                continue

            # If we are in the deprecated section, check if this line is a function
            if in_deprecated_section:
                # Use your robust regex to find function declarations
                if re.match(r'[A-Z]{1,}_EXPORT\s+\w+.*\);$', stripped_line):
                    outfile.write(f'{deprecation_attribute}\n')
            
            # In all cases, write the original line
            outfile.write(line)
            

def process_macros(input_path, output_path):
    """
    Reads a C header file and fixes valueless macros to prevent ffigen parser crashes.
    e.g., '#define FOO' becomes '#define FOO 1'
    """
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    with open(input_path, 'r') as infile, open(output_path, 'w') as outfile:
        for line in infile:
            stripped_line = line.strip()
            
            # Regex to find a #define with a name but nothing after it.
            # `\s*` handles trailing whitespace, `$` anchors to the end of the line.
            match = re.match(r'#define\s+([a-zA-Z0-9_]+)\s*$', stripped_line)
            
            if match:
                macro_name = match.group(1)
                # Rewrite the line, adding a '1' to make it a valid valued macro.
                outfile.write(f'#define {macro_name} 1\n')
            else:
                # If it's not a valueless macro, write the original line.
                outfile.write(line)

def main():
    if len(sys.argv) != 3:
        print("Usage: python preprocess_headers.py <input_dir> <output_dir>")
        sys.exit(1)

    input_dir = sys.argv[1]
    output_dir = sys.argv[2]

    if not os.path.isdir(input_dir):
        print(f"Error: Input directory not found at '{input_dir}'")
        sys.exit(1)

    print(f"Starting header preprocessing. Source: '{input_dir}', Destination: '{output_dir}'")

    for root, dirs, files in os.walk(input_dir):
        for filename in files:
            if filename.endswith('.h'):
                input_path = os.path.join(root, filename)
                relative_path = os.path.relpath(input_path, input_dir)
                output_path = os.path.join(output_dir, relative_path)
                process_deprecation(input_path, output_path)
                # process_macros(input_path, output_path)

    print("Header preprocessing complete.")


if __name__ == '__main__':
    main()