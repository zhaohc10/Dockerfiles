# 在Luigi中有两个基础类：Task, Target. 另外，Parameter类对于如何控制Task类的运行是一个重要的类。
 
#     Target:
#         广义地讲，Target可对应为磁盘上的文件，或HDFS上文件,或checkpoint点，或数据库等。
#         对于Target来说，唯一需要实现的方法为exists,返回为True表示存在，否则不存在返回为False.
#         在实际应用时，写一个Target子类是很少需要用到的。直接使用开箱即可用的LocalTarget及 hdfs.HdfsTarget类就够用了。

# 	Task:
# 	    Task是任务逻辑运行的地方，提供了一些方法来定义任务的逻辑行为，主要有run, output, requires.
# 	    	Task通过类名及参数值做为标识符进行唯一区分。实际上，在同一个worker中，两个拥有相同类名及相同参数值的task不单单只是equal，而且实际上还是同一个实例。
# 		    对于多个Task，它们的类名相同，只是指定了 significant=False 的参数值才不同，
# 		    而未指定 significant=False 的参数值是相同的，对于这些Task来说，它们拥有相同的标识符，即 hash(taskA) == hash(taskB) 是True的，但它们来自于不同的实例。
# 	    Task.requires:
# 	            requires方法用来指定依赖关系，除了可指定对其他Task的依赖，还可指定为对自身Task的依赖。requires返回值可为 dicts/lists/tuples 或其他类别的封装。
# 	    Task.output:
# 	            output方法返回一个或多个的Target对象，类似于requires方法，可返回适应于实际需要的对于Target的任何封装。
# 	            实际上，建议只返回一个Target，因为如果返回多个，atomicity将会被丢失，除非Task能够确保多个Target能被原子性地创建。
# 	            当然，如果原子性不是非常重要的时候，那么就可以放心地返回多个Target。
# 	    Task.run:
# 	        run方法包含实际真正执行的代码。注意到，Luigi将任何事情切分为两个阶段，首先它指出在tasks之间的依赖关系，然后它运行每一件事情。 
# 	        input() 方法是一个内部帮助方法，用来替代在requires 中的对象的对应输出。
# 	Parameter:
#         在Python语言中，参数通常是在constructor时提供，但Luigi要求在类级别上声明所需的参数。
#         通过这样子的要求，Luigi通过处理这些模板规范化的代码来为constructor提供所需参数。


#    Configuration
#         所有的配置均可由两个配置文件进行指定，一个是在当前工作目录下的 client.cfg ，另一个则为 /etc/luigi 。当前工作目录下的 client.cfg 高于 /etc/luigi 。


class Z(luigi.Task):  
    def requires(self):  
        return S(), P()      
    ### 在执行时, 先执行 P 任务, 之后再执行 S 任务。所以当对依赖任务的执行顺序有要求时，请注意这里的排列顺序


import luigi, luigi.hdfs  
from datetime import datetime  
  
## 本示例将本地的 /tmp/abc_%Y%m%d.txt 文件上传到 HDFS 上的 /test/abc_%Y%m%d 路径  
  
class BBF(luigi.ExternalTask):  
    date = luigi.Parameter()  
  
    def output(self):  
        date = datetime.strptime(self.date, '%Y-%m-%d')  
        return luigi.LocalTarget( date.strftime("/tmp/abc_%Y%m%d.txt") )  
      
  
class BF(luigi.Task):  
    date = luigi.Parameter()  
  
    def requires(self):  
        return BBF(self.date)  
  
    def output(self):  
        date = datetime.strptime(self.date, '%Y-%m-%d')  
        return luigi.hdfs.HdfsTarget(date.strftime("/test/abc_%Y%m%d.txt"))  
  
    def run(self):  
        hdfsClient = luigi.hdfs.HdfsClientApache1()  
        hdfsClient.put( self.input().path, self.output().path )
