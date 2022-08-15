module urls_launcher;

import std.stdio : writeln, File, KeepTerminator;
import std.file : exists;
import std.range;
import std.ascii;
import std.getopt : getopt, GetoptResult, defaultGetoptPrinter;
import std.process : browse;
import core.thread.osthread;
import core.time: dur;
import std.regex : Regex, regex, Captures, matchFirst;
import std.conv : to;

void main(string[] args)
{
    string prog_name = "URLs Launcher";
    string input_filename = "";

    // Get command line option
    GetoptResult user_args = getopt(args,
        "input|i", "An input file, a list of URLs separated by a new line.", &input_filename);

    // Does user need help?
    if (user_args.helpWanted)
    {
        defaultGetoptPrinter("Command line option for " ~ prog_name ~ ".",
            user_args.options);
    }

    // Is input file specified?
    if (input_filename.length == 0)
    {
        writeln(prog_name ~ ": No file specified.\n");
        defaultGetoptPrinter("Command line options for Open URLs.",
            user_args.options);
        return;
    }

    // Does the file exist?
    if (!input_filename.exists)
    {
        writeln(prog_name ~ ": input file --" ~ input_filename ~ "-- does not exist.\n");
        return;
    }
    else
    {
        writeln(prog_name ~ ": reading --" ~ input_filename ~ "--");
    }

    // Setup regex for validating URLs
    // Source: https://regexr.com/39nr7
    Regex!char r = regex(
        r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\-\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");

    // count number of processed lines (rows with valid url)
    size_t line_count = 0;

    // Open input file for reading
    foreach (char[] line; File(input_filename).byLine(KeepTerminator.no, std.ascii.newline))
    {
        if (line.empty)
            continue;

        // capture URL using regex
        Captures!(char[]) captures = matchFirst(line, r);

        if (captures.empty)
            continue;

        // open urls
        writeln(prog_name ~ ": " ~ captures[0]);
        Thread.sleep(dur!("seconds")(1));
        browse(captures[0]);
        line_count += 1;
    }

    writeln(prog_name ~ ": processed " ~ to!string(line_count) ~ " lines.");
    writeln(prog_name ~ ": completed");
}