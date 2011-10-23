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

This command doesn't post a file! It's here so you can upload an image that can then be shown on your blog. 

    presser -U filename

Presser will upload the file and print out the url where the uploaded file can be found.

## Edit a post

Get the post ID of the post you want to edit. You can see this in Wordpress's url for the post, in several of the views. Then:

    presser -g id

This downloads the post to a file in your current directory that you can then edit. 

To download a post and then open the file in Vim:

    presser -vg id

(Note! The order of the options is important. -vg works. -gv doesn't.)

## New posts

To create a new post template file in your current directory:

    presser -n

To create the new template and edit it in vim:

    presser -nv

At the moment, vim is hardwired to be MacVim, via MacVim's mvim wrapper script.

Once you have edited a post file, either a new one or a downloaded one, upload it to your blog like this:

    presser -o filename
