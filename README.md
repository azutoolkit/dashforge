<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<br />
<div align="center">
  <a href="https://github.com/azutoolkit/dashforge">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Dashforge</h3>

  <p align="center">
    A real-time Dashboard UI to monitor jobs for the background
job processing library <a href="https://github.com/azutoolkit/joobq"><strong>JoobQ</strong></a>
    <br />
    <a href="https://github.com/azutoolkit/dashforge"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://dashforge.io">View Demo</a>
    ·
    <a href="https://github.com/azutoolkit/dashforge/issues">Report Bug</a>
    ·
    <a href="https://github.com/azutoolkit/dashforge/issues">Request Feature</a>
  </p>
</div>

## About The Project

[![DashForge Screen Shot][product-screenshot]](https://dashforge.io)

Many types of applications require background tasks that run independently of the
user interface (UI). Examples include batch jobs, intensive processing tasks, and
long-running processes such as workflows. Background jobs can be executed without
requiring user interaction--the application can start the job and then continue to
process interactive requests from users. This can help to minimize the load on the
application UI, which can improve availability and reduce interactive response times.

Dashforge Basic features include:

- Monitor current job processed (Total processed, completed, retried, dead)
- Job Queue Monitor (Jobs per Second, Total Errors, and Job Processing Latency)

<p align="right">(<a href="#top">back to top</a>)</p>

### Installation

#### Fly.io Deployment

To deploy to [Fly.io](https://fly.io) use the fly.io directory `toml` file and
customize it as per your application needs.

Then using the `fly` command-line tool deploy your apps:

```ssh
fly deploy -c ./fly.io/redis.toml
fly deploy -c ./fly.io/dashforge-worker.toml
fly deploy -c ./fly.io/dashforge.toml
```

#### Redis DB

Redis DB is where JoobQ stores and maintains the state of your Jobs as well as
create statistics using the Redis Timeseries module, and for this reason we recommend
deploy the time-series version of Redis which can be found at `docker.io/redislabs/redistimeseries:latest`

#### Worker Nodes

These worker nodes are your minions that process the Jobs, the more worker nodes
the more throughput.

```crystal
# Load JoobQ Shard
require "joobq"

# Only needed for the Scheduler below
require "../src/jobs/**"


# Configure JoobQ
JoobQ.configure do
  queue "queue:Email", ENV["EMAIL_QUEUE_WORKERS"].not_nil!.to_i, EmailJob
  queue "queue:Fail", ENV["FAIL_QUEUE_WORKERS"].not_nil!.to_i, FailJob
  queue "queue:Test", ENV["TEST_QUEUE_WORKERS"].not_nil!.to_i, TestJob

  # Define periodic schedule these Jobs will execute at an interval
  scheduler do
    cron "5 4 * * *" { TestJob.perform(1) }
    delay TestJob.new(1), for: 1.minute
    every 1.hour, EmailJob
  end
end

# Starts processing the queue
JoobQ.forge

sleep
```

#### Docker

To build the `Dockerfile` in the root directory

```ssh
docker build .
```

#### Docker Compose

```ssh
docker-compose up
```

## Roadmap

- [ ] Pagination of jobs
- [ ] Better Job Details

See the [open issues](https://github.com/gazutoolkit/dashforge/issues) for a
full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>

## Contributing

Contributions are what the makes open-source community such an amazing place to learn,
inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and
create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork it (<https://github.com/your-github-user/dashforge/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>

## Contributors

- [Elias J. Perez](https://github.com/eliasjpr) - creator and maintainer

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/azutoolkit/dashforge.svg?style=for-the-badge
[contributors-url]: https://github.com/azutoolkit/dashforge/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/azutoolkit/dashforge.svg?style=for-the-badge
[forks-url]: https://github.com/azutoolkit/dashforge/network/members
[stars-shield]: https://img.shields.io/github/stars/azutoolkit/dashforge.svg?style=for-the-badge
[stars-url]: https://github.com/azutoolkit/dashforge/stargazers
[issues-shield]: https://img.shields.io/github/issues/azutoolkit/dashforge.svg?style=for-the-badge
[issues-url]: https://github.com/azutoolkit/dashforge/issues
[license-shield]: https://img.shields.io/github/license/azutoolkit/dashforge.svg?style=for-the-badge
[license-url]: https://github.com/azutoolkit/dashforge/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[product-screenshot]: images/DashForge.png
