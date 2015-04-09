# -*- coding: utf-8 -*-

import sublime
import sublime_plugin
import time
import os
import codecs


class BlogCommand(sublime_plugin.TextCommand):

    '''send note to blog'''

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.setting = sublime.load_settings('Blog.sublime-settings')
        self.blog_path = self.setting.get('blog_path')

    def run(self, edit):
        prefix = time.strftime("%F") + '-'
        file_name = self.view.file_name()
        print('Read from '+file_name+' with decoding utf-8')
        f = codecs.open(file_name, 'r', 'utf-8')
        lines = f.read()

        (path, file_name) = os.path.split(file_name)
        (base, extension) = os.path.splitext(file_name)
        blog_name = os.path.join(self.blog_path, prefix + file_name)
        print('Write to '+blog_name+' with encoding utf-8')

        head = '---\nlayout: post\ntitle: "' + base + '"\ndate: '
        head += time.strftime("%F") + '\ncomments: true\n---\n'

        try:
            f2 = codecs.open(blog_name, 'w', 'utf-8')
            f2.write(head + lines)
            f2.close()
        except:
            sublime.error_message("Blog Write Error!")
        else:
            sublime.status_message("Blog Write Success!")
            window = sublime.active_window()
            window.open_file(blog_name)
