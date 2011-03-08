# Presser

Presser is a command-line program to post and upload to a Wordpress blog.

It's pretty raw, but it (barely) scratches my itch, so it might not get updated for a bit.

To run it: either install it as a gem ("rake -T" to see the rake options to do that) and run "presser", or run the bin/presser script.

The command "presser -h" will get you a list of options.

## Configuration

In order to talk to WordPress, presser needs to talk to your WordPress's xmlrpc.php file, and will need your username and password.

You can provide those on the command line, or make a .presser file in your home directoru. Running:

    presser -c

will get presser to create a sample .presser file for you. You will then need to edit it, but it's a simple file, and should be self-explanatory. The sample file will contain more options than presser will actually read. (Like I said, it's pretty raw.) But just set the username, password, and url, and either ignore or delete the rest.

## Uploading files

Presser will upload a file for you. Use this command:

    presser -U filename

Presser will upload the file and print out the url where the uploaded file can be found.
