# -*- Mode: Python3; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-

from random import randint, choice

class Maze():

	__limit = 10  # minimum

	def __init__(self, rows, cols):
		if rows % 2 == 0: rows += 1
		self.size = (max(rows, self.__limit), max(cols, self.__limit))
		self.first = [0,0]
		self.last = [0,0]
		self.maze = self.make()

	def make(self):
		matrix = []
		rows, cols = self.size
		begin, end = (2, cols - 3)
		x = randint(begin, end)
		self.first = [x,0] 
		for y in range(rows):
			if y % 2 == 0:
				matrix += [i != x for i in range(cols)]
			else:
				matrix += [i % (cols - 1) == 0 for i in range(cols)]
				if choice([True, False]):
					matrix[y * cols + x + 1] = True
					x = randint(begin, x)
				else:
					matrix[y * cols + x - 1] = True
					x = randint(x, end)
		self.last = [x, rows - 1]
		return matrix

	def reverse(self):
		matrix = []
		rows, cols = self.size
		for x in range(cols):
			for y in range(rows):
				matrix += [self.maze[y * cols + x]]
		self.maze = matrix
		self.size = (cols, rows)
		self.first = self.first[::-1]
		self.last = self.last[::-1]

	def __str__(self):
		rows, cols = self.size
		out = "Maze ({},{})\nInput {}\nOutput {}".format(rows, cols,
			self.first, self.last)
		for i in range(len(self.maze)):
			if i % cols == 0:
				out += "\n"
			out += '#' if self.maze[i] else '.' 			
		return out


if __name__ == '__main__':
	# Test
	maze = Maze(10, 10)
	print(maze)
	maze.reverse()
	print(maze)
	maze.reverse()
	print(maze)	
