default: build

image = alpine-infcloud-baikal
tag = 3.14.13.1-0.8.0
timezone = Europe/Berlin

build:
	docker build \
			--build-arg TIMEZONE=$(timezone) \
			--tag "$(image):$(tag)" \
			--tag "$(image):latest" \
			$(args) .

export:
	rm "$(image).$(tag).tgz" || true
	docker image save --output "$(image).$(tag).tgz" "$(image):$(tag)"

run:
	docker run \
			--publish 8800:8800 \
			--volume baikal-data:/var/www/baikal/Specific --volume baikal-config:/var/www/baikal/config \
			$(args) $(image)
