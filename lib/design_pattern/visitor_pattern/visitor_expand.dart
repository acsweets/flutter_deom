///访问者的统计功能，汇总和报表是金融类企业非常常用的功能，
///基本上都是一堆的计算公式，然后出一个报表，很多项目采用了数据库的存储过程来实现，
///我不是很推荐这种方式，除非海量数据处理，一个晚上要批处理上亿、几十亿条的数据，
///除了存储过程来处理还没有其他办法，你要是用应用服务器来处理，连接数据库的网络就是处于 100%占用状态，
///一个晚上也未必能处理完这批数据！除了这种海量数据外，我建议数据统计和报表的批处理通过访问者模式来处理会比较简单
///好，那我们来统计一下公司人员的工资总额