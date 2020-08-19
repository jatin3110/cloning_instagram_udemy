# Challenge 1. Finding 5 oldest users.

SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;

# Challenge 2. Most popular registration day.

SELECT
    username,
    DAYNAME(created_at), 
    COUNT(*) AS total
FROM users
GROUP BY DAYNAME(created_at)
ORDER BY total DESC;

# Challenge 3. identify inactive users

SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

# Challenge 4. Most popular photo

SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

# Challenge 5. Calculate average number of photos

SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg;
                          
-- 6. Find the five most popular hashtags

SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5;       

-- 7. Finding the bots - the users who have liked every single photo

SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 