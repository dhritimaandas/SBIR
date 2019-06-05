path='C:\Users\DHRITIMAAN DAS\Desktop\Feature_Vectors\Image\Training';
label=dir(path);
name={label.name};
x_train_img=[];
x_label_img=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=3:length(name)
    imgs_paths=char(strcat(path,'\',name(i)));
    inames_=dir(imgs_paths);
    inames={inames_.name};
    for j=3:length(inames)
        img_path=char(strcat(imgs_paths,'\',inames(j)));
        z=readNPY(img_path);
        z=z(1:200);
        mean_i=mean(z);
        var_i=var(z);
        for h=1:length(z)
            z(h)=((z(h)-mean_i)/sqrt(var_i));
        end
        %z=z/(norm(z));
        x_train_img=[x_train_img z];
        x_label_img=[x_label_img i-2];
    end
end

path_='C:\Users\DHRITIMAAN DAS\Desktop\Feature_Vectors\Sketchs\Training';
labels=dir(path_);
name_skt={labels.name};
x_train_skt=[];
x_label_skt=[];
for i=3:length(name_skt)
    skt_paths=char(strcat(path,'\',name_skt(i)));
    snames_=dir(skt_paths);
    snames={snames_.name};
    for j=3:length(snames)
        skt_path=char(strcat(skt_paths,'\',snames(j)));
        s=readNPY(skt_path);
        s=s(1:500);
        mean_s=mean(s);
        var_s=var(s);
        for p=1:length(s)
            s(p)=((s(p)-mean_s)/sqrt(var_s));
        end
        x_train_skt=[x_train_skt s];
        x_label_skt=[x_label_skt i-2];
    end
end

[Wx,Wy,r]=cca(x_train_img,x_train_skt,1);

x_train_img=Wx*x_train_img;
x_train_skt=Wy*x_train_skt;



t=MAP_MATLAB(x_train_skt, x_train_img, x_label_skt, x_label_img, 100);