require "test_helper"

class NotesRouteTest < ActionDispatch::IntegrationTest
  locker_room_fixtures(:accounts, :members, :users)
  fixtures(:notes, :people)

  def test_route_to_notes
    within_subdomain_host do |host|
      assert_routing({
        method: "get",
        path:   "#{host}/notes"
      }, {
        controller: "notes",
        action:     "index"
      })
      assert_routing({
        method: "get",
        path:   "#{host}/notes?tag=ice"
      }, {
        controller: "notes",
        action:     "index"
      })
      assert_routing({
        method: "get",
        path:   "#{host}/notes?column=title&direction=desc&tag=ice"
      }, {
        controller: "notes",
        action:     "index"
      })
      assert_routing({
        method: "get",
        path:   "#{host}/notes/new"
      }, {
        controller: "notes",
        action:     "new"
      })
      assert_routing({
        method: "post",
        path:   "#{host}/notes"
      }, {
        controller: "notes",
        action:     "create"
      })
      assert_routing({
        method: "get",
        path:   "#{host}/notes/1"
      }, {
        controller: "notes",
        action:     "show", id: "1"
      })
      assert_routing({
        method: "get",
        path:   "#{host}/notes/1/edit"
      }, {
        controller: "notes",
        action:     "edit",
        id:         "1"
      })
      assert_routing({
        method: "patch",
        path:   "#{host}/notes/1"
      }, {
        controller: "notes",
        action:     "update",
        id:         "1"
      })
      assert_routing({
        method: "put",
        path:   "#{host}/notes/1"
      }, {
        controller: "notes",
        action:     "update",
        id:         "1"
      })
      assert_routing({
        method: "delete",
        path:   "#{host}/notes/1"
      }, {
        controller: "notes",
        action:     "destroy",
        id:         "1"
      })
    end
  end

  def test_route_to_journalizings
    within_subdomain_host do |host|
      assert_routing({
        method: "get",
        path:   "#{host}/finances/1/journalizings.json?type=income"
      }, {
        controller: "journalizings",
        action:     "index",
        finance_id: "1",
        format:     "json"
      })
    end
  end

  def test_route_to_finances
    within_subdomain_host do |host|
      assert_routing({
        method: "get",
        path:   "#{host}/finances"
      }, {
        controller: "finances",
        action:     "index"
      })
      assert_routing({
        method: "get",
        path:   "#{host}/finances/new"
      }, {
        controller: "finances",
        action:     "new"
      })
      assert_routing({
        method: "post",
        path:   "#{host}/finances"
      }, {
        controller: "finances",
        action:     "create"
      })
      assert_routing({
        method: "get",
        path:   "#{host}/finances/1"
      }, {
        controller: "finances",
        action:     "show",
        id:         "1"
      })
      assert_routing({
        method: "get",
        path:   "#{host}/finances/1/edit"
      }, {
        controller: "finances",
        action:     "edit",
        id:         "1"
      })
      assert_routing({
        method: "patch",
        path:   "#{host}/finances/1"
      }, {
        controller: "finances",
        action:     "update",
        id:         "1"
      })
      assert_routing({
        method: "put",
        path:   "#{host}/finances/1"
      }, {
        controller: "finances",
        action:     "update",
        id:         "1"
      })
      assert_routing({
        method: "delete",
        path:   "#{host}/finances/1"
      }, {
        controller: "finances",
        action:     "destroy",
        id:         "1"
      })
    end
  end

  private

  def within_subdomain_host
    user = locker_room_users(:oswald)
    host = "http://#{user.account.subdomain}.example.org"
    yield(host)
  end
end
