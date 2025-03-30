import re

def convert_to_little_endian(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            match = re.search(r'([01]{32})$', line.strip())  # Extract 32-bit binary
            if not match:
                continue  # Skip lines without binary data
            
            binary_str = match.group(1)
            
            # Split into 8-bit chunks
            bytes_list = [binary_str[i:i+8] for i in range(0, 32, 8)]
            
            # Reverse for little-endian
            little_endian_bytes = bytes_list[::-1]
            
            # Write each 8-bit chunk in a new line
            for byte in little_endian_bytes:
                outfile.write(byte + '\n')

def main():
    input_file = 'Input.txt'  # Change as needed
    output_file = 'instructions.txt'  # Change as needed
    convert_to_little_endian(input_file, output_file)
    print(f"Conversion complete. Output written to {output_file}")

if __name__ == "__main__":
    main()
