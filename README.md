# speakeasy

Speakeasy is a static site generator written in [janet](https://github.com/janet-lang/janet)

## Installation

Make sure you have `janet` installed first:

```sh
brew install janet
```

[Find other installation instructions here](https://janet-lang.org/docs/index.html)

Then use `jpm` the janet package manager to install `speakeasy`

```sh
jpm install https://github.com/swlkr/speakeasy
```

Add speakeasy to your `$PATH` (on macOS with homebrew):

```sh
export PATH=/usr/local/Cellar/janet/<your janet version here>/bin:$PATH
```

## Quick Start

Create an `index.janet` file:

```clojure
# index.janet

[(doctype :html5)
 [:html
  [:head
    [:title "Prohibition ends here. Have a drink."]]
  [:body
    [:h1 "Welcome to the speakeasy. No snitches allowed."]]]]
```

Run speakeasy in that same directory as the `index.janet` file above:

```sh
speakeasy

# 1 html file generated
```

With any luck, the `index.janet` file above should have turned into an `index.html` file that looks like this (except it's all on one line):

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Prohibition ends here. Have a drink.</title>
  </head>
  <body>
    <h1>Welcome to the speakeasy. No snitches allowed.</h1>
  </body>
</html>
```

The sky is the limit with speakeasy, organize your files however you want, `smuggle` in other files and reference functions anywhere:

```clojure
# layout.janet

(defn layout [& body]
  [(doctype :html5)
   [:html
    [:head
      [:title "Prohibition ends here. Have a drink."]]
    [:body body]]])
```

Then in `index.janet`:

```clojure
# index.janet
(smuggle ./layout)

(layout
  [:h1 "Welcome to the speakeasy. No snitches allowed."])
```

Speakeasy's html syntax works great with atomic css frameworks like [tailwind.css](https://tailwindcss.com):

```clojure
# layout.janet

(defn layout [& body]
  [(doctype :html5)
   [:html
    [:head
      [:title "Prohibition ends here. Have a drink."]
      [:link {:href "/tailwind.min.css" :rel "stylesheet"}]]
    [:body body]]])
```

Create a new file, `html.janet`:

```clojure
# html.janet

(def h1 :h1.text-5xl.text-gray-800)
```

Then over in `index.janet`:

```clojure
# index.janet
(smuggle ./layout)
(smuggle ./html)

(layout
  [h1 "Welcome to the speakeasy. No snitches allowed."])
```

Run speakeasy one more time:

```sh
speakeasy
```

Now `index.html` should look like this:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Prohibition ends here. Have a drink.</title>
    <link href="tailwind.min.css" rel="stylesheet" />
  </head>
  <body>
    <h1 class="text-5xl text-gray-800">Welcome to the speakeasy. No snitches allowed.</h1>
  </body>
</html>
```

Happy hacking!
