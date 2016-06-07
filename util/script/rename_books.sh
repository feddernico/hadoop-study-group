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

# moves txt files from sub-folders (if present) to parents
find $1 -mindepth 2 -type f -print -exec mv {} $1 \; 

# removes just the subfolders from the files folder
rm -r $1/*/

# removes every file that doesn't have .txt extension
find $1 -type f ! -iname "*.txt" -delete

# removes all the folders

for f in $1*
do
	# logging which file is processing
	echo "Processing $f file..."

	# gets the the title line from the file content	
	book_title="`grep 'Title:' $f`"  
	
	# removes the Title: part
	book_title_clean=${book_title##*Title:}
	
	#if it finds the word Complete in it, it removes the last part from the book name
	if [[ $book_title_clean == *"- Complete" ]]
	then
		echo book title clean: $book_title_clean
		book_title_clean=${book_title_clean::-11}
	fi

	# every character that is not a letter or number or a ._- is converted into a _
	file_name=$(echo $book_title_clean | sed -e 's/[^A-Za-z0-9._-]/_/g')

	file_name=$(echo $file_name | sed -e 's/__/_/g')
	
	# if the last character of the file name is a _ removes it
	if [[ $file_name == *"_" ]]
	then
		echo book title clean: $book_title_clean
		file_name=${file_name::-1}
	fi

	# gets the file name length
	file_name_len=${#file_name}

	if [[ $file_name_len > 255 ]]
	then 
		file_name=$(echo $file_name | cut -c1-100)
	fi

	# removes dots in the file
	file_name_clean=${file_name//./}.txt

	# copies the book file into the new folder called books_clean
	mkdir -p books_clean
	mv $f books_clean/$file_name_clean

	echo "file: $file_name_clean written"
done
