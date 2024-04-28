#!/bin/bash
input_dir=$1
output_dir=$2
if [ "$#" -eq 0 ]; then
        echo "Введите 2 названия - название директории, из которой хотите скопировать файлы и название директории, в 
которую эти файлы сохранить"
        exit 1
fi
if [ "$#" -eq 1 ]; then
        echo "Введите название директории, в которую сохранить файлы. Если директории с введенным названием не 
найдется, автоматически создаться новая директория с таким названием"
        exit 1
fi
if [ "$#" -gt 2 ]; then
        echo "Введено больше 2ух значений"
        exit 1
fi
if [ ! -d "$input_dir" ]; then
        echo "Входной директории с таким названием не нашлось"
        exit 1
fi
if [ ! -d "$output_dir" ]; then
        echo "Выходной директории с таким названием не нашлось. Создается новая директория.."
        mkdir "$output_dir"
fi


echo "Скопировать в том числе скрытые файлы? (да-1; нет-0)"
read answer
if [ "$answer" -eq "0" ]; then
	id=0 #id для того, чтобы приписывать это значение к файлам с одинаковым названием
	for file in $(find "$input_dir" -type f); do
		file_name=$(basename "$file")
		if [ -e "$output_dir/$file_name" ]; then
			((id+=1))
			file_name="${file_name}_${id}"
		fi
		cp -a "$file" "$output_dir/$file_name"
	done
echo "Файлы скопированы без скрытых файлов."

elif [ "$answer" -eq "1" ]; then 
	id=0 #id для того, чтобы приписывать это значение к файлам с одинаковым названием
        for file in $(find "$input_dir" -type f); do
                file_name=$(basename "$file")
                if [ -e "$output_dir/$file_name" ]; then
                        ((id+=1))
                        file_name="${file_name}_${id}"
                fi
                cp "$file" "$output_dir/$file_name"
        done
echo "Файлы скопированы, включая скрытые файлы."
   
else
    echo "Введено некорректное значение. Пожалуйста, введите 0 или 1."
    exit 1
fi

