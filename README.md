# KcScore

Mongoid, 评分+评论 通用型评价组件。  

当前版本限制：
同来源对同对象只能进行一次评价。

## 安装


```ruby
# Gemfile
gem 'kc_score'
```

然后运行

    $ bundle

## 示例

### 学员(用户)给课程评分
```ruby
# app/models/user.rb
class User
  include KcScore::Concerns::Sourceable
  # 可以对Course进行评价，nil代表不对评分数值做限制（评分数值限制未实装）
  # 对应的，Course也会自动加载 KcScore::Concerns::Targetable
  act_as_score_sourceable :course => nil
end
```

需求示例
```ruby
# console
# user 对 course1 给予-1分的评价(相当于说 course1 没用)
user.score_it course1, -1

# user 对 course2 给予1分的评价(相当于说 course1 有用), 并填写了相应的内容
user.score_it course2, 1, '评论内容，可以为空'

# user 对 course3 给予1分的评价(相当于说 course3 不知道有没有用), 并填写了相应的内容
user.score_it course3, 1, '不知道有没有用'
```

查看课程总评分
```ruby
# 以下均可
course.score_of 'user'
course.score_of 'User'
```

### 组长(用户)对学员(用户)进行评分
建议写为 **分组** 可对 **学员** 进行评价。这样设计有如下好处：  
1. 多个组长，均可评价（控制层处理，非组件处理）
2. **用户** 对 **用户** 进行评价，评价目的十分不明确。而且造成人有3、6、9等分的感觉。

```
class Group
  include KcScore::Concerns::Sourceable
  # 可以对 组员 进行评价，nil代表不对评分数值做限制（评分数值限制未实装）
  # 对应的，User也会自动加载 KcScore::Concerns::Targetable
  act_as_score_sourceable :user => nil
end
```

示例
```ruby
# console
# group 对 user1 给予 60 分的评价
group.score_it user1, 60

# group 对 user2 给予 100 分的评价, 给予了评论
group.score_it user2, 100, "再接再厉"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kc_score. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

