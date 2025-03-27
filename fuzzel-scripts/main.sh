#!/bin/bash

case "$(printf "Apps launcher\nSettings\nSomethingElse" | fuzzel -d --index)" in
	0)  ;;
	1)  ;;
    2)  ;;
	*) exit ;;
esac