from locust import HttpLocust, TaskSet, task


class UserBehavior(TaskSet):

    def os_start(self):
        self.login(self)

    def login(self):
        self.client.post('/login', {"username":"grauwoelfchen", "password":"secret"})

    @task(1)
    def index(self):
        self.client.get('/')


class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 9000
