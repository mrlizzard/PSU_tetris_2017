/*
** EPITECH PROJECT, 2018
** PSU_tetris_2017
** File description:
** load_tetriminos functions
*/

# include "tetris.h"

void fill_struct(main_t *param, char *path, char *file)
{
	tetriminos_t *tmp = param->tetri;
	int id = 0;
	int err;

	while (tmp->next != NULL) {
		tmp = tmp->next;
		id++;
	}

	tmp->next = malloc(sizeof(tetriminos_t));

	if (tmp->next == NULL)
		return;

	err = set_first_values(tmp->next, path);
	tmp->next->id = id;
	tmp->next->name = parse_filename(file);
	tmp->next->path = path;
	tmp->next->next = NULL;
	if (err == 0) {
		tmp->next->form = get_tetrimino_form(path, tmp->next->height);
		tmp->next->invalid = 0;
	} else {
		tmp->next->form = NULL;
		tmp->next->invalid = 1;
<<<<<<< HEAD
	}	
=======
	}
	printf("invalid: %d\n", tmp->next->invalid);
	printf("\n");
>>>>>>> ef18785aa1635ff5a7f1dcec7cec7665b31b4de0
}

void setup_tetrimino(dir_t *dirent, main_t *param)
{
	char *path = NULL;
	stat_t info;
	int st = 0;

	if (!my_strendswith(dirent->d_name, ".tetrimino"))
		return;

	path = my_strjoin(TETRIMINOS_DIR, dirent->d_name);
	st = stat(path, &info);

	if (st < 0)
		return;

	fill_struct(param, path, dirent->d_name);
}

int get_files(main_t *param)
{
	DIR *dir = opendir(TETRIMINOS_DIR);
	dir_t *dirent = NULL;

	if (dir == NULL) {
		write(2, "Error while openning folder\n", 28);
		return (84);
	}

	while ((dirent = readdir(dir)))
		setup_tetrimino(dirent, param);

	closedir(dir);
	return (0);
}

int config_tetriminos(main_t *param)
{
	stat_t info;
	int st = stat(TETRIMINOS_DIR, &info);

	if (st < 0) {
		write(2, "Stat error. Abord.\n", 19);
		return (84);
	} else {
		if (!S_ISDIR(info.st_mode)) {
			write(2, TETRIMINOS_DIR, my_strlen(TETRIMINOS_DIR));
			write(2, " : is not a directory.\n", 23);
			return (84);
		}

		st = get_files(param);
	}

	return (st);
}
