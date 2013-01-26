
root = global ? window

PostsIndexCtrl = ($scope, Post) ->
  $scope.posts = Post.query()
  $scope.destroy = ->
    dconfirm = confirm("Are you sure?")
    if dconfirm
      original = @post
      @post.destroy ->
        $scope.posts = _.without($scope.posts, original)

PostsIndexCtrl.$inject = ['$scope', 'Post'];

PostsCreateCtrl = ($scope, $location, Post) ->
  $scope.save = ->
    Post.save $scope.post, (post) ->
      $location.path "/posts/#{post.id}/edit"

PostsCreateCtrl.$inject = ['$scope', '$location', 'Post'];

PostsShowCtrl = ($scope, $location, $routeParams, Post) ->
  Post.get
    id: $routeParams.id
  , (post) ->
    self.original = post
    $scope.post = new Post(self.original)

PostsShowCtrl.$inject = ['$scope', '$location', '$routeParams', 'Post'];

PostsEditCtrl = ($scope, $location, $routeParams, Post) ->
  self = this
  Post.get
    id: $routeParams.id
  , (post) ->
    self.original = post
    $scope.post = new Post(self.original)

  $scope.isClean = ->
    angular.equals self.original, $scope.post

  $scope.destroy = ->
    dconfirm = confirm("Are you sure?")
    if dconfirm
      $scope.post.destroy ->
        $location.path "/posts"


  $scope.save = ->
    Post.update $scope.post, (post) ->
      $location.path "/posts"

PostsEditCtrl.$inject = ['$scope', '$location', '$routeParams', 'Post'];

# exports
root.PostsIndexCtrl  = PostsIndexCtrl
root.PostsCreateCtrl = PostsCreateCtrl
root.PostsShowCtrl   = PostsShowCtrl
root.PostsEditCtrl   = PostsEditCtrl 