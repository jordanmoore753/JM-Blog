# Basic Blog App

This is a blog application which supports users, posts, and comments.

## Users

Only users can make posts and comments.

A user can have many posts and comments.

The users's `name` is used as the **Author** field for the post. The `email` is kept private.

## Posts

A post can have many comments. A post can have one user.

A post has the following public fields:

1. Author (corresponding to `id` of `user`)
2. Title
3. Body

## Comments

A comment belongs to one post. 

A comment has the following public fields:

1. Author (corresponding to `id` of `user`)
2. Body

Private fields:

1. post_id (corresponding to `id` of `post`)

## Sessions

Sessions are the persisting state (logged in user) of the application.

State in the session includes:

1. Encrypted User ID.

## Flow

A user signs up. They receive a confirmation email and use the token in there to authenticate to the site. 

A user logs in which creates a new `Session`. They are redirected to the `/posts` index, where all of the most recent posts can be seen. They can:

1. View posts in index of posts.
2. View their profile (includes all posts by them).
3. Click on specific post.
4. Log out.

A user clicks on a specific post. They can:

1. Read the `body` of the post.
2. Read the comments of the post.
3. Create a comment for the post.
4. Update any comments on the post that belong to them.
5. Update the post.
6. Delete comments.