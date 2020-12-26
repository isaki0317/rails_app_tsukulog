json.body @comment.body
json.end_user_name @comment.end_user.name
json.end_user @comment.end_user.id
json.created_at @comment.created_at.strftime('%Y/%m/%d')
json.end_user_id @comment.end_user_id
json.comment_id @comment.id
json.post @comment.post.id