module pas2d;

import std.algorithm;
import std.array;
import std.exception;
import std.file;
import std.path;
import std.regex;
import std.stdio;
import std.string;

void main(string[] args)
{
	enforce(args.length==1, "Usage: pas2d < input.pas > output.d");
	auto lines = args[0].dirName().buildPath("regexes.txt").readText().splitLines();
	struct Pair { Regex!char from; string to; }
	Pair[] pairs;
	for (size_t n=0; n<lines.length; n+=3)
		pairs ~= Pair(regex(lines[n], "g"), lines[n+1]);

	foreach (line; stdin.byLine())
	{
		auto spaces = countUntil!`a!=' '`(line);
		if (spaces >= 0)
			line = "\t".replicate(spaces/2) ~ line[spaces..$];
		
		foreach (pair; pairs)
			line = line.idup.replace(pair.from, pair.to).dup;
		
		writeln(line);
	}
}
