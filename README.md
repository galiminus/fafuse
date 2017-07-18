# fafuse

Small Fuse wrapper I made for a friend to make the scraping of an art website easier.

## Requirements

Fafuse use Fuse and Nokogiri, on Ubuntu and Debian you should install those packets:

```
apt-get install libfuse-dev libxml2-dev libxslt-dev
```

## Installation

```
gem install fafuse
```

## Usage

```
fafuse [mount_point]
```

The top directory is always forbidden, it's not a bug. To browse informations of particular artist you can cd directly to the user's directory:

```
cd [mount_point]/[artist_slug]
```

