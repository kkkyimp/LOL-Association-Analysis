library(networkD3)
library(readxl)
data <- read.csv('~/R数据.csv', sep = ",")


#边数据集
#边数据集MisLinks，共包含三列，依次是起点、终点、边的粗细(大小、权重)。

MisLinks=data.frame(data[,2],data[,4],data[,5])

MisLinks=data.frame(matrix(0,length(data[,2]),3))
colnames(MisLinks) <- c('qi','zhong','lift')


names=data.frame(data[,1],data[,2])#  位置   名字  ###索引表
names=names[!duplicated(names),]

for (i in 1:length(data[,2])) {
  MisLinks[i,1]=as.numeric( which(as.character( data[i,1])==names[,1] &
                        as.character( data[i,2])==names[,2]))-1
  MisLinks[i,2]=as.numeric( which(as.character( data[i,3])==names[,1] &
                        as.character( data[i,4])==names[,2]))-1
} 
MisLinks[,3]=data[,5]


#节点数据集
#点数据集MisNodes，共包含三列，节点名称，节点分组，节点大小(重要性、集中度)

MisNodes=data.frame(matrix(NA,length(names[,1]),3))
MisNodes[,1]=names[,2]
MisNodes[,2]=names[,1]
#for (i in 1:length(names[,1])){
#  if (names[i,1]=='上'){t=1}
#  if (names[i,1]=='野'){t=2}
#  if (names[i,1]=='中'){t=3}
#  if (names[i,1]=='下'){t=4}
#  if (names[i,1]=='辅'){t=5}
#  MisNodes[i,2]=t
#}

t= as.data.frame(table(data[,1:2]))
count=list()
for (i in 1:length(names[,2])) {
  count[i]=t[which(as.character(names[i,2])==t[,2] &as.character(names[i,1])==t[,1]),3]*2
}
count=data.frame(unlist(count))

MisNodes[,3]=count

colnames(MisNodes) <- c('dian','weizhi','cishu')




#MyClickScript <- 'alert("You clicked " + d.name + " which is in row " +
#(d.index + 1) + " of your original R data frame");'


html=forceNetwork(
#边数据集
Links = MisLinks,
# 节点数据集
Nodes = MisNodes,
#边数据集中起点对应的列
Source = "qi",
# 边数据集中终点对应的列
Target = "zhong",
# 边数据集中边的宽度对应的列
Value = "lift",
# 节点数据集中节点名称对应的列
NodeID = "dian",
# 节点数据集中节点分组对应的列
Group = "weizhi",
# 图宽度

width = 1200,

# 图高度

height = 1000,

# 图是否允许缩放

zoom = T,

# 图是否有边界

bounded=T,

# 图是否显示图例

legend=T,
# 鼠标没有停留时其他节点名称的透明度

opacityNoHover = 1,

# 所有节点初始透明度

opacity = 1,

# 节点斥力大小(负值越大斥力越大)

charge=-100,

# 节点颜色，可以建立不同分组和颜色的一一映射关系



Nodesize = "cishu" ,#节点大小，节点数据框中

# 节点绝对大小

radiusCalculation = JS(" d.nodesize"),

# 节点名称的字体

fontFamily = "宋体",

# 节点名称的字号

fontSize = 16,

# 边是否显示箭头

arrows = F,

# 边颜色，Cols可以是一个预先设置的列表

linkColour = "gray",

# 鼠标点击事件

#clickAction =  MyClickScript


  
)

saveNetwork(html,"NetWorkLOL赛事.html",selfcontained=TRUE)#save HTML

