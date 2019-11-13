# Decision_Trees_for_Prediction

C5.0 and CART are two well-known decision tree algorithms 

C5.0 

overview describing how the algorithm works 

C5.0 algorithm is a successor of C4.5 algorithm also developed by Quinlan (1994) 
This node uses the C5.0 algorithm to build either a decision tree or a rule set (Gives a binary tree or multi branches tree ). A C5.0 model works by splitting the sample based on the field that provides the maximum information gain which is calculated using entropy. Each subsample defined by the first split is then split again, usually based on a different field, and the process repeats until the subsamples cannot be split any further. Finally, the lowest-level splits are reexamined, and those that do not contribute significantly to the value of the model are removed or pruned.

-	A decision tree is a straightforward description of the splits found by the algorithm. Each terminal (or "leaf") node describes a particular subset of the training data, and each case in the training data belongs to exactly one terminal node in the tree. In other words, exactly one prediction is possible for any particular data record presented to a decision tree. 
-	On other side a rule set is a set of rules that tries to make predictions for individual records. Rule sets are derived from decision trees and, in a way, represent a simplified or distilled version of the information found in the decision tree. 

Requirements: To train using this algorithm, there must be one categorical (i.e., nominal or ordinal) Target field, and one or more Input fields of any type. Fields set to Both or None are ignored. Fields used in the model must have their types fully instantiated. A weight field can also be specified.
discuss the impurity measure it uses for the attribute split test condition 
The first thing the algorithm has to do is decide which feature to split upon (since we may well have many). As described earlier, this is done so as to increase the information gain. The gain is defined as the difference between a parent’s impurity and the sum of its children’s impurities. There are a number of different impurity measures, entropy being the one favored in the implementation C5.0. The formula for entropy is given by:
Entropy(S)= ∑i to c − pi.log2(pi)

where 
S is a segment of data (i.e. a bunch of records), 
c is the number of different class levels, and 
pi refers to the proportion of values falling into class level ii.
discuss one advantage and one disadvantage of the algorithm 

Advantage. C5.0 models are quite robust in the presence of problems such as missing data and large numbers of input fields. They usually do not require long training times to estimate. In addition, C5.0 models tend to be easier to understand than some other model types, since the rules derived from the model have a very straightforward interpretation. C5.0 also offers the powerful boosting method to increase accuracy of classification. In a case of handling missing values, C5.0 allows to whether estimate missing values as a function of other attributes or apportions the case statistically among the results.

Disadvantage
A small variation in data can lead to different decision trees and may not work well for small datasets.

references to the published literature
https://www.ibm.com/support/knowledgecenter/en/SS3RA7_15.0.0/com.ibm.spss.modeler.help/c50node_general.htm
https://www.sciencedirect.com/topics/computer-science/decision-tree-algorithm
https://www.ijert.org/research/comparison-of-c5.0-cart-classification-algorithms-using-pruning-technique-IJERTV1IS4104.pdf
https://rpubs.com/mzc/mlwr_dtr_credit_mushrooms
https://pdfs.semanticscholar.org/fd39/e1fa85e5b3fd2b0d000230f6f8bc9dc694ae.pdf

CART

overview describing how the algorithm works 
ID3 uses information gain whereas C4.5 uses gain ratio for splitting. Here, CART is an alternative decision tree building algorithm. It can handle both classification and regression tasks. This algorithm uses a new metric named gini index to create decision points for classification tasks
Gini index calculation for each class and choose which has less:
Gini = 1 – Σ (Pi)2 for i=1 to number of classes

Now apply the same principle for the sub datasets, like with root and its children value. This process will be repeated until we reach to leaf node.

CART can handle both nominal and numeric attributes to construct a decision tree. 
CART uses Cost – Complexity Pruning to remove redundant branches from the decision tree to improve the accuracy. 
CART handles missing values by surrogating tests to approximate outcomes
discuss the impurity measure it uses for the attribute split test condition 
Gini Index is an attribute selection measure used by the CART decision tree algorithm. The Gini Index measures the impurity D, a data partition or set of training tuples as:

Gini = 1 – Σ (Pi)2 for i=1 to number of classes

Where pi is the probability that a tuple in D belongs to class Ci and is estimated by |Ci,D|/|D|. The sum is computed over m classes. The attribute that reduces the impurity to the maximum level (or has the minimum gini index) is selected as the splitting attribute.

Discuss one advantage and one disadvantage of the algorithm 

Advantages:
-	CART handles missing values automatically Using “surrogate splits”
-	Invariant to monotonic transformations of predictive variable
-	Not sensitive to outliers in predictive variables Unlike regression
-	Great way to explore, visualize data

Disadvantages:
-	The model is a step function, not a continuous score. So if a tree has 10 nodes, that can only take on 10 possible values.
-	Might take a large tree to get good lift  
-	Instability of model structure like Correlated variables random data fluctuations could result in entirely different trees.
-	Splits only  on one variable

references to the published literature
https://www.sciencedirect.com/topics/computer-science/decision-trees
https://cds.cern.ch/record/2253780
https://sefiks.com/2018/08/27/a-step-by-step-cart-decision-tree-example/
http://mercury.webster.edu/aleshunas/Support%20Materials/C4.5/Nguyen-Presentation%20Data%20mining.pdf
https://pdfs.semanticscholar.org/fd39/e1fa85e5b3fd2b0d000230f6f8bc9dc694ae.pdf

