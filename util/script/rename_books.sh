#!/bin/bash
#
# Author: Federico Viscioletti
#
# Description:
# This shell script will rename the text files downloaded from the Gutemberg project website using their title. 
#
# Input:
# The only input required is the folder that contains all the text files, passed as a parameter.
#
# Usage:
# ./rename_books.sh /path/to/books/folder/

# path to files to be read from input parameter	
for f in $1*
do
	# logging which file is processing
	echo "Processing $f file..."

	# gets the the title line from the file content	
	book_title="`grep 'Title:' $f`"  
	
	# removes the Title: part
	book_title_clean=${book_title##*:}
	
	#if it finds the word Complete in it, it removes the last part from the book name
	if [[ $book_title_clean == *"Complete"* ]]
	then
		book_title_clean=${book_title_clean::-11}
		file_name=$(echo $book_title_clean | sed -e 's/[^A-Za-z0-9._-]/_/g')
		file_name_clean=$file_name.txt
	else 
		file_name=$(echo $book_title_clean | sed -e 's/[^A-Za-z0-9._-]/_/g')
		# removes the last underscore before the .txt
		file_name_clean=${file_name%_*}.txt
	fi
	
	# copies the book file into the new folder called books_clean
	mkdir -p books_clean
	cp $f books_clean/$file_name_clean

	echo "file: $file_name_clean written"
done
