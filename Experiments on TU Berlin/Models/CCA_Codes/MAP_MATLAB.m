function map_K=eval_MAP_K(query_set, search_set, query_label, search_set_label, K)
    
    
query_class_arr = query_set;
search_set_class_arr = search_set;
query_label_arr = query_label;
%query_label_arr.astype(int)
search_set_label_arr = search_set_label;
%search_set_label_arr.astype(int)
num_query_sample = length(query_label_arr);
dist_q_search_class = pdist2(query_class_arr,search_set_class_arr,'euclidean');

AP=0;
    
pre=0;
    
    
for query_count=length(num_query_sample)

        
	actual_label = query_label_arr(query_count);
        
	value=dist_q_search_class(query_count,:);
        
	[sorted_value,sorted_value_idx]=sort(value,'ascend');
    %for s=1:K
    %    predicted_K_label=[predicted_K_label search_set_label_arr(s)]
    %end
	predicted_K_label = search_set_label_arr(sorted_value_idx(1:K));
        
	L=sum(ismember(predicted_K_label,actual_label));
        


        
	P=0;
        
	for r= 1:K
            
	rtr_label_r = predicted_K_label(1:r);
            
	l=sum(ismember(rtr_label_r,actual_label));
            
	precision=l/(r+1);
            
        if actual_label==predicted_K_label(r)
            delta=1;
        else
            delta=0;
        end

        P=P+(precision*delta);

        if L~=0
            AP=AP+((1/L)*P);
        end
    end
end
    
	map_K=AP/num_query_sample;

