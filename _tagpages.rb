# based on code by jovandeginste
require 'yaml'

tags = []
cats = ['_posts', '_updates']
cats.each do |cat|
    Dir.glob(File.join(cat, '*.md')).each do |file|
    yaml_s = File.read(file).split(/^---$/)[1]
    yaml_h = YAML.load(yaml_s)
    if !yaml_h['tags'].nil?
        yaml_h['tags'].split(" ").each do |t|
        tags.push(t)
        end
    end
    end
end

tags.map(&:downcase).uniq.each do |tag|
  File.open(File.join('./', 'tag', "#{tag}.html"), 'w') { |f|
    f.write("---
layout: tagpage
tag: #{tag}
permalink: tag/#{tag}
sitemap: false
---")
  }
end
