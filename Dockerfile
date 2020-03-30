# start from the latest LTS node release
FROM node:lts as builder

# work out of the screeps folder
RUN mkdir -p /screeps
WORKDIR /screeps
# install python2 & build tools
RUN apt update && apt install -y build-essential python2.7 python-pip
# install screeps & mods
RUN npm install screeps screepsmod-auth screepsmod-admin-utils

# make run container
FROM node:lts
COPY --from=builder /screeps /screeps
WORKDIR /screeps


CMD if [ -z "$(ls data)" ] || [ -z "$(ls data/assets)" ]; then \
		echo 'unset' | npx screeps init; \
		mv assets data/assets; \
		mv db.json data/db.json; \
		mv mods.json data/mods.json; \
		chmod -R 777 data; \
	fi; \
	cp screepsrc .screepsrc; \
	npx screeps start
