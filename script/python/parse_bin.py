#Imports
import sys
import codecs

def parse (in_file, out_file):
    words = []
    
    binary_file = open(in_file, 'rb')
    rv32i_file  = open(out_file, "w+")
    
    for chunk in iter(lambda: binary_file.read(4), b''):
        words.append(codecs.encode(chunk, 'hex'))
    
    for word in words:
        tmp_word = word.decode("utf-8")
        nibles = [tmp_word[0:2], tmp_word[2:4], tmp_word[4:6], tmp_word[6:8]]
        rv32i_file.write(nibles[3] + nibles[2] + nibles[1] + nibles[0])
        rv32i_file.write("\n")
    
    rv32i_file.close()


if (len(sys.argv) < 2):
    sys.exit("> There are no enough elements to parse the bin file.")

parse(sys.argv[1], sys.argv[2])