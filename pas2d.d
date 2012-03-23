module pas2d;

import std.stdio, std.file, std.regex, std.string, std.algorithm, std.array;

void main()
{
	auto lines = splitLines(readText("regexes.txt"));
	struct Pair { Regex!char from; string to; }
	Pair[] pairs;
	for (size_t n=0; n<lines.length; n+=3)
		pairs ~= Pair(regex(lines[n], "g"), lines[n+1]);

	foreach (line; stdin.byLine)
	{
		auto spaces = countUntil!`a!=' '`(line);
		if (spaces >= 0)
			line = "\t".replicate(spaces/2) ~ line[spaces..$];
		
		foreach (pair; pairs)
			line = line.idup.replace(pair.from, pair.to).dup;
		
		writeln(line);
	}
}
