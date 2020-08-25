module PostsHelper
  def render_with_hashtags(hashtag)
    hashtag.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){ |word| link_to word, "/post/tag/#{word.delete("#")}",data: {"turbolinks" => false} }.html_safe
  end

end