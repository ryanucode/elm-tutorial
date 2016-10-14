--type IntList = Empty | Node Int IntList
type List a = Empty | Node a (List a)

list = Node 1 Empty

main = list

