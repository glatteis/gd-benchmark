#!/bin/sh
rm vmcai-paper-bench/pdfs/*.pdf
# projected with gradient <method> vs others <method> for all learning rates
for method in ADAM Momentum-Sign Nesterov-Sign
do
	lower_method=$(echo "$method" | awk '{print tolower($0)}')
	python3 csv_to_scatter.py vmcai-paper-bench/constraints.csv "η=0.1 Projection" "η=0.1 Logarithmic Barrier,η=0.1 Logistic Sigmoid,η=0.01 Projection,η=0.01 Logarithmic Barrier,η=0.01 Logistic Sigmoid,η=0.001 Projection,η=0.001 Logarithmic Barrier,η=0.001 Logistic Sigmoid" "η=0.1 Projection" "Others" --comp-field "Add. Settings" --filter "Method:$method" --one-vs-all True --output-pdf vmcai-paper-bench/pdfs/$lower_method-constraints.pdf --seperate-legend True --symbols True
done

# methods against each other with projected with gradient
python3 csv_to_scatter.py vmcai-paper-bench/method_comparison.csv "Momentum-Sign" "ADAM,RADAM,RMSProp,Plain,Plain-Sign,Momentum,Nesterov,Nesterov-Sign" "Momentum-Sign" "Others" --comp-field "Method" --filter "Add. Settings:Projection" --one-vs-all True --output-pdf vmcai-paper-bench/pdfs/method-comparison-project-with-gradient.pdf --seperate-legend True

# Momentum-Sign vs momentum (fig 5)
python3 csv_to_scatter.py vmcai-paper-bench/method_comparison.csv "Momentum-Sign" "Momentum" "Momentum-Sign" "Momentum" --comp-field "Method" --filter "Add. Settings:Projection" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-momentum.pdf --seperate-legend True
# Momentum-Sign vs Nesterov-Sign (with gradient projection)
python3 csv_to_scatter.py vmcai-paper-bench/method_comparison.csv "Momentum-Sign" "Nesterov-Sign" "Momentum-Sign" "Nesterov-Sign" --comp-field "Method" --filter "Add. Settings:Projection" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-nesterov-sign-project-with-gradient.pdf --seperate-legend True

# Momentum-Sign vs QCQP
python3 csv_to_scatter.py vmcai-paper-bench/gd_vs_prophesy.csv "Momentum-Sign" "QCQP" "Momentum-Sign" "QCQP" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-qcqp.pdf --seperate-legend True 
# Momentum-Sign vs PSO
python3 csv_to_scatter.py vmcai-paper-bench/gd_vs_prophesy.csv "Momentum-Sign" "PSO" "Momentum-Sign" "PSO" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-pso.pdf --seperate-legend True 
# Momentum-Sign vs QCQP 20% relaxed
python3 csv_to_scatter.py vmcai-paper-bench/gd_vs_prophesy_20percent.csv "Momentum-Sign" "QCQP" "Momentum-Sign" "QCQP" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-qcqp-20percent.pdf --seperate-legend True 
# Momentum-Sign vs PSO 20% relaxed
python3 csv_to_scatter.py vmcai-paper-bench/gd_vs_prophesy_20percent.csv "Momentum-Sign" "PSO" "Momentum-Sign" "PSO" --output-pdf vmcai-paper-bench/pdfs/momentum-sign-vs-pso-20percent.pdf --seperate-legend True 

# crop legends
pdfcrop vmcai-paper-bench/pdfs/momentum-sign-vs-qcqp-legend.pdf vmcai-paper-bench/pdfs/legendmethods.pdf
pdfcrop vmcai-paper-bench/pdfs/adam-constraints-legend.pdf vmcai-paper-bench/pdfs/legendconstraints.pdf
pdfcrop vmcai-paper-bench/pdfs/method-comparison-project-with-gradient-legend.pdf vmcai-paper-bench/pdfs/legendgradientdescentmethods.pdf
