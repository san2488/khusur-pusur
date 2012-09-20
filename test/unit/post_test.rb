require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should not save post without title" do
    post = Post.new
    assert !post.save, "Saved the post without a title"
  end

  test "should not save post without content" do
    post = Post.new
    assert !post.save, "Saved the post without content"
  end
end