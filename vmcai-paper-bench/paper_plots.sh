#!/usr/bin/sh
rm vmcai-paper-bench/pdfs/*.pdf
# projected with gradient <method> vs others <method> for all learning rates
for method in adam momentum-sign nesterov-sign
do
	python csv_to_scatter.py vmcai-paper-bench/constraints.csv "lr=0.1 Project with gradient" "lr=0.1 Logarithmic Barrier,lr=0.1 Logistic Sigmoid,lr=0.01 Project with gradient,lr=0.01 Logarithmic Barrier,lr=0.01 Logistic Sigmoid,lr=0.001 Project with gradient,lr=0.001 Project without gradient,lr=0.001 Logarithmic Barrier,lr=0.001 Logistic Sigmoid" "lr=0.1 Project with gradient" "Others" --comp-field "Add. Settings" --filter "Method:$method" --one-vs-all True --output-pdf vmcai-paper-bench/pdfs/$method-constraints.pdf --seperate-legend True 
done

# methods against each other with projected with gradient
python csv_to_scatter.py vmcai-paper-bench/method_comparison.csv "momentum-sign" "adam,radam,rmsprop,plain,plain-sign,momentum,nesterov,nesterov-sign" "Momentum-Sign" "Others" --comp-field "Method" --filter "Add. Settings:Project with gradient" --one-vs-all True --output-pdf vmcai-paper-bench/pdfs/method-comparison-project-with-gradient.pdf

# momentum-sign vs momentum (fig 5)
python csv_to_scatter.py vmcai-paper-bench/method_comparison.csv "momentum-sign" "momentum" "Momentum-Sign" "Momentum" --comp-field "Method" --filter "Add. Settings:Project with gradient" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-momentum.pdf --seperate-legend True
# momentum-sign vs nesterov-sign (with gradient projection)
python csv_to_scatter.py vmcai-paper-bench/method_comparison.csv "momentum-sign" "nesterov-sign" "Momentum-Sign" "Nesterov-Sign" --comp-field "Method" --filter "Add. Settings:Project with gradient" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-nesterov-sign-project-with-gradient.pdf --seperate-legend True

# momentum-sign vs qcqp
python csv_to_scatter.py vmcai-paper-bench/gd_vs_prophesy.csv "momentum-sign" "qcqp" "Momentum-Sign" "QCQP" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-qcqp.pdf --seperate-legend True 
# momentum-sign vs pso
python csv_to_scatter.py vmcai-paper-bench/gd_vs_prophesy.csv "momentum-sign" "pso" "Momentum-Sign" "PSO" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-pso.pdf --seperate-legend True 
# momentum-sign vs qcqp 20% relaxed
python csv_to_scatter.py vmcai-paper-bench/gd_vs_prophesy_20percent.csv "momentum-sign" "qcqp" "Momentum-Sign" "QCQP" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-qcqp-20percent.pdf --seperate-legend True 
# momentum-sign vs pso 20% relaxed
python csv_to_scatter.py vmcai-paper-bench/gd_vs_prophesy_20percent.csv "momentum-sign" "pso" "Momentum-Sign" "PSO" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-pso-20percent.pdf --seperate-legend True 

# crop legends
pdfcrop vmcai-paper-bench/pdfs/momentum-sign-vs-qcqp-legend.pdf vmcai-paper-bench/pdfs/legendmethods.pdf
pdfcrop vmcai-paper-bench/pdfs/adam-constraints-legend.pdf vmcai-paper-bench/pdfs/legendconstraints.pdf
