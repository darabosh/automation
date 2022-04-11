% PRETRAGA
% hts={};
% for i=1:size(ulaz,1)
%     if strcmp(ulaz.atip(i),'HTS')
%       hts{end+1,1}=ulaz.naziv{i};
%     end
% end

load('prethodna.mat');


zarez=',';
imeListe=input('unesite ime liste: ','s');
ulaz=readtable(imeListe);

hkk={'BAKLAVA',30;'BANANA PLAZMA KOCKA',12;'BANANA SPLIT PARCE',12;'BLACK BOROVNICA PARCE',12;'BLACK FANTASY PARCE',12;'BLACK JAGODA PARCE',12;'BLACK KAJSIJA PARCE',12;'BLACK MALINA PARCE',12;'BOZINA TORTA PARCE',12;'CAJNO PECIVO 1kg',1;'CAJNO PECIVO 500gr',20;'CAJNO PECIVO SA ORASIMA',0;'CHESSE CAKE PARCE',12;'CHESSE JAGODA PARCE',12;'COKO CRVENO VOCE PARCE',12;'COKO ORAH PARCE',10;'COKOLADNA MEDENA PITA',12;'COKOLADNA PARCE',10;'COKOMOKO PARCE',10;'CRVENO VOCE PARCE',12;'DOBOS PARCE',12;'EKLERI',10;'GRCKA PARCE',10;'GRILIJAS PARCE',10;'JAFFA PARCE',10;'JAGODA PARCE',12;'KAPRI KOMADNO',[];'KAPRI PARCE',[];'KARPATI PARCE',15;'KESTEN PARCE',12;'KINDER PARCE',10;'KOKOS CUPAVCI',15;'KOKOS KOCKA',24;'KOKOS ROLAT PARCE',20;'KRANC TORTA PARCE',16;'KREMA U CASI',1;'KREMPITA ',18;'KUGLICE RAZNE 400 GRAMA',5;'LEDENE KOCKE PARCE',15;'LIMUN TORTA PARCE',12;'LUDLAB PARCE',12;'MADARICA VOCNA PARCE',24;'MADJARICE',24;'MAK VISNJA ',12;'MARGARETA PARCE',12;'MARKIZA U CASI',5;'MARKOVA PARCE',10;'MEDENA PITA',12;'MINJON AKCIJA',10;'MINJON PARCE',20;'MIRKOVA PARCE',10;'MOSKVA PARCE',10;'NUGAT PARCE',12;'NUTELA PARCE',10;'OREO PARCE',12;'PAVLOVA MINI',[];'PLAZMA NUGAT PARCE',12;'PRINCES KROFNA ',15;'PRINCES MINI PAKET',1;'PUNC PARCE',12;'PUSLICE',5;'REFORM PARCE',10;'RIGO JANCI PARCE',[];'ROLADA SUSENO VOCE',10;'SACHER PARCE',12;'SAM ROLNE',10;'SAMPITA',35;'SAMPITA AKCIJA',0;'SEHEREZADA PARCE',10;'SNICKERS NOVA PARCE',12;'SOMLOI GALUSKA',20;'SPANSKI  SA MALINOM PARCE',24;'SPANSKI SA LESNIKOM PARCE',10;'SRCE PARCE',0;'STRACATELA',0;'SUBOTICKE MRVICE',5;'SUHAJDA',20;'SUHAJDA MALA',0;'SUSKAVA PARCE',15;'SVARCVALD PARCE',12;'TIRAMISU',10;'TRILECE',15;'VOCNA PARCE',10;'ZERBO',24};
hkkt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HKK')
        hkkt{end+1,1}=ulaz.naziv{i};
    end
end
if size(hkk,1)~=size(hkkt,1)
    disp('unesi novi artikal')
    return
end
% for i=1:size(ulaz,1)
%     if contains(ulaz.zaliha{i,1},zarez)
%         for z=1:size(ulaz.zaliha{i,1},2)
%             if ulaz.zaliha{i,1}(z)==','
%                 ulaz.zaliha{i,1}(z)='.';
%             end
%         end
%     end
%     if contains(ulaz.pstanje{i,1},zarez)
%         for z=1:size(ulaz.pstanje{i,1},2)
%             if ulaz.pstanje{i,1}(z)==','
%                 ulaz.pstanje{i,1}(z)='.';
%             end
%         end
%     end
%     if contains(ulaz.izlaz{i,1},zarez)
%         for z=1:size(ulaz.izlaz{i,1},2)
%             if ulaz.izlaz{i,1}(z)==','
%                 ulaz.izlaz{i,1}(z)='.';
%             end
%         end
%     end
%     if contains(ulaz.Ukupno{i,1},zarez)
%         for z=1:size(ulaz.Ukupno{i,1},2)
%             if ulaz.Ukupno{i,1}(z)==','
%                 ulaz.Ukupno{i,1}(z)='.';
%             end
%         end
%     end
%     if contains(ulaz.VrPrometa{i,1},zarez)
%         for z=1:size(ulaz.VrPrometa{i,1},2)
%             if ulaz.VrPrometa{i,1}(z)==','
%                 ulaz.VrPrometa{i,1}(z)='.';
%             end
%         end
%     end
%     if contains(ulaz.VrPoreza{i,1},zarez)
%         for z=1:size(ulaz.VrPoreza{i,1},2)
%             if ulaz.VrPoreza{i,1}(z)==','
%                 ulaz.VrPoreza{i,1}(z)='.';
%             end
%         end
%     end
% end
% ulaz.zaliha=str2double(ulaz.zaliha);
% ulaz.pstanje=str2double(ulaz.pstanje);
% ulaz.izlaz=str2double(ulaz.izlaz);
% ulaz.Ukupno=str2double(ulaz.Ukupno);
% ulaz.VrPoreza=str2double(ulaz.VrPoreza);
% ulaz.VrPrometa=str2double(ulaz.VrPrometa);

for i=1:size(ulaz,1)
    for j=1:size(ulazZaSutra,1)
        if strcmp(ulaz.naziv(i),ulazZaSutra.naziv(j))
            ulaz.pstanje(i)=ulazZaSutra.zaliha(j);
            ulaz.Ukupno(i)=ulaz.pstanje(i)+ulaz.ulaz(i);
            ulaz.zaliha(i)=ulaz.Ukupno(i)-ulaz.izlaz(i);
        end
    end
end

for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HKK')
        for j=1:size(hkk,1)
            if strcmp(ulaz.naziv(i),hkk{j,1})
                if hkk{j,2}==0
                    ulaz.ulaz(i)=ulaz.izlaz(i);
                    ulaz.zaliha(i)=0;
                    ulaz.Ukupno(i)=ulaz.ulaz(i);
                    ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                    ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
                else
                    while ulaz.zaliha(i)<0
                        ulaz.zaliha(i)=ulaz.zaliha(i)+hkk{j,2};
                        ulaz.ulaz(i)=ulaz.ulaz(i)+hkk{j,2};
                        ulaz.Ukupno(i)=ulaz.Ukupno(i)+hkk{j,2};
                    end
                    %ako se uvek prodaje manje nego ulaza stanje prodaje i
                    %ulaza ce uvek biti isto ako je pstanje na max
                    while ulaz.zaliha(i)>hkk{j,2}
                        if ulaz.ulaz(i)<hkk{j,2}
                            kolko=hkk{j,2}-ulaz.ulaz(i);
                            ulaz.ulaz(i)=ulaz.ulaz(i)+kolko;
                            ulaz.Ukupno(i)=ulaz.Ukupno(i)+kolko;
                        end
                        ulaz.zaliha(i)=ulaz.zaliha(i)-hkk{j,2};
                        ulaz.ulaz(i)=ulaz.ulaz(i)-hkk{j,2};
                        ulaz.Ukupno(i)=ulaz.Ukupno(i)-hkk{j,2};
                    end
                    ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                    ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
                end
            end
        end
    end
end

hts={'BELA COKOLADA SNIT',0;'COKO CRVENO VOCE SNIT',2;'COKO ORAH SNIT',0;'COKOLADA SNIT',2;'COKOMOKO SNIT',0;'CRVENO VOCE SNIT',2;'DOBOS SNIT',2;'GRCKA SNIT',2;'GRILIJAS SNIT',0;'JAFFA SNIT',1;'JAGODA SNIT',0;'KINDER SNIT',1;'LESNIK SNIT',0;'LUDLAB SNIT',2;'MAK VISNJA SNIT',0;'MARKOVA SNIT',1;'MIRKOVA SNIT',1;'MOSKVA SNIT',1;'NUTELA SNIT',1;'PLAZMA NUGAT SNIT',0;'PUNC SNIT',1;'RAFAELO SNIT',0;'REFORM SNIT',1;'RIGO JANCI SNIT',0;'SEHEREZADA SNIT',1;'SPANSKI LESNIK SNIT',0;'SPANSKI MALINA SNIT',0;'SUSKAVA SNIT',0;'SVARCVALD SNIT',1;'TIRAMISU MALINA SNIT',0;'VOCNA SNIT',1};
htst={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTS')
        htst{end+1,1}=ulaz.naziv{i};
    end
end
if size(hts,1)~=size(htst,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTS')
        for j=1:size(hts,1)
            if strcmp(ulaz.naziv(i),hts{j,1})
                if ulaz.zaliha(i)<0
                    tempBroj=hts{j,2}-ulaz.zaliha(i);
                    ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                    ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                end
                while ulaz.zaliha(i)>hts{j,2}
                    ulaz.zaliha(i)=ulaz.zaliha(i)-1;
                    ulaz.ulaz(i)=ulaz.ulaz(i)-1;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)-1;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

htm={'BLACK FANTASY OKRUGLA MALA',2;'BOZINA TORTA OKRUGLA MALA',0;'CHESSE CAKE OKRUGLA MALA',1;'CHESSE JAGODA OKRUGLA MALA',0;'NUGAT OKRUGLA MALA',1;'OREO OKRUGLA MALA',1;'PAVLOVA TORTA JAGODA',0;'SRCE',0;'TIRAMISU OKRUGLA MALA',0};
htmt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTM')
        htmt{end+1,1}=ulaz.naziv{i};
    end
end
if size(htm,1)~=size(htmt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTM')
        for j=1:size(htm,1)
            if strcmp(ulaz.naziv(i),htm{j,1})
                if ulaz.zaliha(i)<0
                    tempBroj=htm{j,2}-ulaz.zaliha(i);
                    ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                    ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                end
                while ulaz.zaliha(i)>htm{j,2}
                    ulaz.zaliha(i)=ulaz.zaliha(i)-1;
                    ulaz.ulaz(i)=ulaz.ulaz(i)-1;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)-1;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

htr={'BANANA SPLIT SREDNJA',0;'BELA COKOLADA SREDNJA',0;'BLACK BOROVNICA SREDNJA',0;'BLACK FANTASY SREDNJA',0;'BLACK JAGODA SREDNJA',0;'BLACK MALINA SREDNJA',0;'BOZINA TORTA SREDNJA',0;'COKO CRVENO VOCE SREDNJA',0;'COKO ORAH SREDNJA',0;'COKOLADA SREDNJA',0;'COKOMOKO SREDNJA',0;'CRVENO VOCE SREDNJA',0;'DINASTIJA SREDNJA',0;'DOBOS SREDNJA',0;'GRCKA SREDNJA',0;'GRILIJAS SREDNJA',0;'JAFFA SREDNJA',0;'JAGODA SREDNJA',0;'KINDER SREDNJA',0;'LESNIK SREDNJA',0;'LUDLAB SREDNJA',0;'MAK VISNJA SREDNJA',0;'MARKOVA SREDNJA',0;'MIRKOVA SREDNJA',0;'MOSKVA SREDNJA',0;'NUTELA SREDNJA',0;'OREO SREDNJA',0;'PLAZMA NUGAT SREDNJA',0;'PUNC SREDNJA',0;'RAFAELO SREDNJA',0;'REFORM SREDNJA',0;'RIGO JANCI SREDNJA',0;'RUSKA SREDNJA',0;'SACHER SREDNJA',0;'SEHEREZADA SREDNJA',0;'SLADOLED SREDNJA',0;'SNICKERS N SREDNJA',0;'SNICKERS SREDNJA',0;'SPANSKI LESNIK SREDNJA',0;'SPANSKI MALINA SREDNJA',0;'SUSKAVA SREDNJA',0;'SVARCVALD SREDNJA',1;'VANILA SREDNJA',0;'VOCNA SREDNJA',0};
htrt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTR')
        htrt{end+1,1}=ulaz.naziv{i};
    end
end
if size(htr,1)~=size(htrt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTR')
        for j=1:size(htr,1)
            if strcmp(ulaz.naziv(i),htr{j,1})
                if ulaz.zaliha(i)<0
                    tempBroj=htr{j,2}-ulaz.zaliha(i);
                    ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                    ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                end
                while ulaz.zaliha(i)>htr{j,2}
                    ulaz.zaliha(i)=ulaz.zaliha(i)-1;
                    ulaz.ulaz(i)=ulaz.ulaz(i)-1;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)-1;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

hto={'BANANA SPLIT OKRUGLA',1;'BLACK BOROVNICA OKRUGLA',1;'BLACK FANTASY OKRUGLA',2;'BLACK JAGODA OKRUGLA',0;'BLACK KAJSIJA OKRUGLA',0;'BLACK MALINA OKRUGLA',2;'BOZINA TORTA OKRUGLA',1;'CHESSE CAKE OKRUGLA',1;'COKOLADNA MEDENA OKRUGLA',0;'KESTEN OKRUGLA',0;'KRANC TORTA OKRUGLA',0;'LIMUN TORTA OKRUGLA',0;'MARGARETA OKRUGLA',0;'MARKIZA TORTA OKRUGLA',0;'MEDENA TORTA OKRUGLA',0;'NUGAT OKRUGLA',0;'OREO OKRUGLA',0;'PAVLOVA TORTA OKRUGLA',0;'PUNC OKRUGLA',1;'SACHER OKRUGLA',1;'SNICKERS NOVA OKRUGLA',2;'STRACATELA OKRUGLA',0;'TIRAMISU TORTA OKRUGLA',0;'VOCNA PLAZMA OKRUGLA',0};
htot={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTO')
        htot{end+1,1}=ulaz.naziv{i};
    end
end
if size(hto,1)~=size(htot,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTO')
        for j=1:size(hto,1)
            if strcmp(ulaz.naziv(i),hto{j,1})
                if ulaz.zaliha(i)<0
                    tempBroj=hto{j,2}-ulaz.zaliha(i);
                    ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                    ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                end
                while ulaz.zaliha(i)>hto{j,2}
                    ulaz.zaliha(i)=ulaz.zaliha(i)-1;
                    ulaz.ulaz(i)=ulaz.ulaz(i)-1;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)-1;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

htv={'BANANA SPLIT VELIKA',0;'BELA COKOLADA VELIKA',0;'BLACK BOROVNICA VELIKA',0;'BLACK FANTASY VELIKA',0;'BLACK JAGODA VELIKA',0;'BLACK KAJSIJA VELIKA',0;'BLACK MALINA VELIKA',0;'BOZINA TORTA VELIKA ',0;'COKO CRVENO VOCE VELIKA',0;'COKO ORAH VELIKA',0;'COKOLADA VELIKA',0;'COKOMOKO VELIKA',0;'CRVENO VOCE VELIKA',0;'DINASTIJA VELIKA',0;'DOBOS VELIKA',0;'GRCKA VELIKA',0;'GRILIJAS VELIKA',0;'JAFFA VELIKA',0;'JAGODA VELIKA',0;'KESTEN VELIKA',0;'KINDER VELIKA',0;'LESNIK VELIKA',0;'LUDLAB VELIKA',0;'MAK VISNJA VELIKA',0;'MARKOVA VELIKA',0;'MIRKOVA VELIKA',0;'MLADENACKA TORTA',0;'MOSKVA VELIKA',0;'NUTELA VELIKA',0;'ORAH VELIKA',0;'OREO VELIKA',0;'PLAZMA NUGAT VELIKA',0;'PUNC VELIKA',0;'REFORM VELIKA',0;'RUSKA VELIKA',0;'SEHEREZADA VELIKA',0;'SLADOLED VELIKA',0;'SNICKERS NOVA VELIKA',0;'SNICKERS VELIKA',0;'SPANSKI LESNIK SREDNJA',0;'SPANSKI MALINA VELIKA',0;'SUSKAVA VELIKA',0;'SVARCVALD VELIKA',0;'VANILA VELIKA',0;'VOCNA VELIKA',0};
htvt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTV')
        htvt{end+1,1}=ulaz.naziv{i};
    end
end
if size(htv,1)~=size(htvt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTV')
        for j=1:size(htv,1)
            if strcmp(ulaz.naziv(i),htv{j,1})
                if ulaz.zaliha(i)<0
                    tempBroj=htv{j,2}-ulaz.zaliha(i);
                    ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                    ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                end
                while ulaz.zaliha(i)>htv{j,2}
                    ulaz.zaliha(i)=ulaz.zaliha(i)-1;
                    ulaz.ulaz(i)=ulaz.ulaz(i)-1;
                    ulaz.Ukupno(i)=ulaz.Ukupno(i)-1;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end


hta={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTA')
        hta{end+1,1}=ulaz.naziv{i};
    end
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTA') 
        for j=1:size(hta,1)
            if strcmp(ulaz.naziv(i),hta{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

htb={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTB')
        htb{end+1,1}=ulaz.naziv{i};
    end
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTB')
        for j=1:size(htb,1)
            if strcmp(ulaz.naziv(i),htb{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

htc={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTC')
        htc{end+1,1}=ulaz.naziv{i};
    end
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTC')
        for j=1:size(htc,1)
            if strcmp(ulaz.naziv(i),htc{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

htf={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTF')
        htf{end+1,1}=ulaz.naziv{i};
    end
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTF')
        for j=1:size(htf,1)
            if strcmp(ulaz.naziv(i),htf{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

htg={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTG')
        htg{end+1,1}=ulaz.naziv{i};
    end
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTG')
        for j=1:size(htg,1)
            if strcmp(ulaz.naziv(i),htg{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end


hpm={'PAL. DZEM MALA ';'PAL. EURO. OR. MALA';'PAL. EURO. OR. SL. MALA';'PAL. EURO. PL.SL MALA';'PAL. EURO. PLA. MALA';'PAL. EURO.LES. MALA';'PAL. EURO.VIS MALA';'PAL. EUROKREM MALA';'PAL. LES. EURO. SL.  MALA';'PAL. LESNIK MALA';'PAL. NUT. LES. SL.  MALA';'PAL. NUT. PLAZ SL. MALA';'PAL. NUT. PLAZMA MALA';'PAL. NUT.VISNJA MALA';'PAL. NUTELA MALA';'PAL. ORASI MALA';'PAL. PRAZNA MALA';'PAL. PUD. VAN. BAN. MALA';'PAL. PUD. VAN. SL. MALA';'PAL. SLANA MALA';'PAL. VISNJA MALA';'PAL.NUTELA LESNIK MALA'};
hpmt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPM')
        hpmt{end+1,1}=ulaz.naziv{i};
    end
end
if size(hpm,1)~=size(hpmt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPM')
        for j=1:size(hpm,1)
            if strcmp(ulaz.naziv(i),hpm{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

hpv={'PAL NUT. LES. VELIKA';'PAL.  DZEM VELIKA';'PAL. EURO. ORASI VELIKA';'PAL. EURO. PLAZ. SL. VEL';'PAL. EURO. PLAZ. VELIKA';'PAL. EURO. VELIKA';'PAL. EURO. VISNJA VELIKA';'PAL. EURO.ORASI. SL. VEL';'PAL. LES. EURO. SL. VEL';'PAL. LES. EURO. VELIKA';'PAL. LESNIK VELIKA';'PAL. NUT. LES. SL. VEL';'PAL. NUT. PLAZ. SL. VEL';'PAL. NUT. PLAZ. VELIKA';'PAL. NUT. VISNJA VELIKA';'PAL. NUTELA VELIKA';'PAL. ORASI VELIKA';'PAL. PIPI VELIKA';'PAL. PRAZNA VELIKA';'PAL. PUD. VAN. BAN. VEL';'PAL. PUD. VAN.SL. VEL';'PAL. SA VRATOM VELIKA';'PAL. SLANA VELIKA';'PAL. VISNJA'};
hpvt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPV')
        hpvt{end+1,1}=ulaz.naziv{i};
    end
end
if size(hpv,1)~=size(hpvt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPV')
        for j=1:size(hpv,1)
            if strcmp(ulaz.naziv(i),hpv{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

htd={'BLACK JAGODA SREDNJA DEKO';'BLACK MALINA SREDNJA DEKO';'COKO C.VOCE SREDNJA DEKO';'CRVENO VOCE SREDNJA DEKO';'DOBOS SREDNJA DEKO';'LUD LAB SREDNJA DEKO';'SRCE TORTA ';'SRCE TORTA MALA '};
htdt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTD')
        htdt{end+1,1}=ulaz.naziv{i};
    end
end
if size(htd,1)~=size(htdt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HTD')
        for j=1:size(htd,1)
            if strcmp(ulaz.naziv(i),htd{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

hdd={'DODATAK';'DODATAK ANANAS';'DODATAK BANANA';'DODATAK COKO PRELIV';'DODATAK EUROKREM';'DODATAK KOKOS';'DODATAK LESNIK';'DODATAK NUTELA';'DODATAK ORASI';'DODATAK PLAZMA';'DODATAK SLADOLED K. BISKVIT';'DODATAK SLADOLED K. COKOLADA';'DODATAK SLADOLED K. JAGODA';'DODATAK SLADOLED K. PLAZMA';'DODATAK SLADOLED K. VANILA';'DODATAK SLADOLED K.JOG. VISNJA';'DODATAK SLAG S.P.'};
hddt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HDD')
        hddt{end+1,1}=ulaz.naziv{i};
    end
end
if size(hdd,1)~=size(hddt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HDD')
        for j=1:size(hdd,1)
            if strcmp(ulaz.naziv(i),hdd{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

hse={'DORUCAK';'GURMANSKI SENDVIC';'OMLET U LEPINJI';'SENDVIC DIMLJENI VRAT';'SENDVIC DJACKI';'SENDVIC INTEGRALNI';'SENDVIC KOBASICA';'SENDVIC MALI KULEN';'SENDVIC PIPI';'SENDVIC PRASKA SUNKA';'SENDVIC PRSUTA';'SENDVIC SALAMA';'SENDVIC U CEBATI';'SENDVIC VELIKI KULEN';'TOSTIRANA INTEGRALNA LEPINJA'};
hset={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HSE')
        hset{end+1,1}=ulaz.naziv{i};
    end
end
if size(hse,1)~=size(hset,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HSE')
        for j=1:size(hse,1)
            if strcmp(ulaz.naziv(i),hse{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

amb={'KUTIJA ZA TORTE';'PN 440 TACNA VELIKA ZVONO';'PN15A PLAST MALA TIRAMISU';'PN16 PLASTIKA VEL-KOMADNO';'PODLOGE ZA TORTE';'PODLOSKE ZA FONDAN TORTE';'TACNA MALA';'TACNA VELIKA'};
ambt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'AMB')
        ambt{end+1,1}=ulaz.naziv{i};
    end
end
if size(amb,1)~=size(ambt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'AMB')
        for j=1:size(amb,1)
            if strcmp(ulaz.naziv(i),amb{j,1})
                ulaz.ulaz(i)=ulaz.izlaz(i);
                ulaz.zaliha(i)=0;
                ulaz.Ukupno(i)=ulaz.ulaz(i);
            end
            ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
            ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
        end
    end
end

inventarHrane={'KIFLICE SA DZEMOM',3;'TESTENINA 400g',0;'TESTENINA 500g',0;'UKRAS 1',2;'UKRAS 2',2;'UKRAS MALI',3;'UKRAS SREDNJI',1;'UKRAS VELIKI',1;'POKLON 1',5;'POKLON 2',1;'POKLON 3',1;'POKLON 4',0;'POKLON 5',0;'ZITO',2;'ZITO SA SLAGOM',3;'PROJA MALA',0;'COKOLADNI MAFIN',0;'KIFLICE',0};
tempModifikovano=0;

hsp={'COKOLADNI MAFIN';'KIFLICE';'LAVA CAKE';'PICA MINI';'PITA GUZVARA';'PITA LENJA';'PITA LENJA PARCE';'PITA SA BUNDEVOM';'PITA SA JABUKAMA';'PITA SA KROMPIROM';'PITA SA MESOM';'PITA SA SIROM';'PITA SA SLATKIM SIROM';'PITA SA TIKVICAMA';'PITA SA VISNJAMA';'PITA SIR SUNKA GLJIVE';'PITA SPANAC';'PROJA MALA';'PROJA VELIKA';'TORTILJA';'TORTILJA MEKSICKA';'TORTILJA PIPI'};
hspt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HSP')
        hspt{end+1,1}=ulaz.naziv{i};
    end
end
if size(hsp,1)~=size(hspt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HSP')
        for j=1:size(hsp,1)
            if strcmp(ulaz.naziv(i),hsp{j,1})
                while ulaz.zaliha(i)<0
                    for k=1:size(inventarHrane,1)
                        if strcmp(ulaz.naziv(i),inventarHrane{k,1})
                            tempBroj=inventarHrane{k,2}-ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                            ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                            ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                            tempModifikovano=1;
                        end
                    end
                    if tempModifikovano==0
                        ulaz.zaliha(i)=ulaz.zaliha(i)+1;
                        ulaz.ulaz(i)=ulaz.ulaz(i)+1;
                        ulaz.Ukupno(i)=ulaz.Ukupno(i)+1;
                    end
                    tempModifikovano=0;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

hpo={'INTEGRALNE POGACICE';'KIFLICE SA DZEMOM';'KIFLICE SLANE PRAZNE';'KIFLICE SLANE PUNJENE';'KOKTEL PECIVO';'MINI MAFIN COKOLADNI';'MINI MAFIN SA VISNJAMA';'MINI PROJA';'POGACICE MLADI SIR';'POGACICE SA SAJTOM';'POGACICE ZUZU'};
hpot={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPO')
        hpot{end+1,1}=ulaz.naziv{i};
    end
end
if size(hpo,1)~=size(hpot,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPO')
        for j=1:size(hpo,1)
            if strcmp(ulaz.naziv(i),hpo{j,1})
                while ulaz.zaliha(i)<0
                    for k=1:size(inventarHrane,1)
                        if strcmp(ulaz.naziv(i),inventarHrane{k,1})
                            tempBroj=inventarHrane{k,2}-ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                            ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                            ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                            tempModifikovano=1;
                        end
                    end
                    if tempModifikovano==0
                        ulaz.zaliha(i)=ulaz.zaliha(i)+1;
                        ulaz.ulaz(i)=ulaz.ulaz(i)+1;
                        ulaz.Ukupno(i)=ulaz.Ukupno(i)+1;
                    end
                    tempModifikovano=0;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

hpp={'DANSKO EUROKREM';'DANSKO SLANI SIR';'GUBA';'HLEB CRNI';'HLEB CVETNI';'HLEB CVETNI SUSAM';'HLEB POSIP';'KIFLA INTEGRALNA';'KIFLA MINI';'KIFLA OBICNA';'KIFLA SA VIRSLOM';'KOLAC PLETENI MALI';'KOLAC PLETENI VELIKI';'KOLAC SLAVSKI';'PEREC';'PLETENICA';'POGACA MAK';'POGACA ORAH';'POGACA VISNJA';'POGACICA SA CVARCIMA';'PUNJENA KIFLA';'SAJT KIFLA';'TESTENINA 400g';'TESTENINA 500g';'TESTO MAMUZE 500g';'VEKNA INTEGRALNA MALA'};
hppt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPP')
        hppt{end+1,1}=ulaz.naziv{i};
    end
end
if size(hpp,1)~=size(hppt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPP')
        for j=1:size(hpp,1)
            if strcmp(ulaz.naziv(i),hpp{j,1})
                while ulaz.zaliha(i)<0
                    for k=1:size(inventarHrane,1)
                        if strcmp(ulaz.naziv(i),inventarHrane{k,1})
                            tempBroj=inventarHrane{k,2}-ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                            ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                            ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                            tempModifikovano=1;
                        end
                    end
                    if tempModifikovano==0
                        ulaz.zaliha(i)=ulaz.zaliha(i)+1;
                        ulaz.ulaz(i)=ulaz.ulaz(i)+1;
                        ulaz.Ukupno(i)=ulaz.Ukupno(i)+1;
                    end
                    tempModifikovano=0;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

hru={'CRTANJE 1';'CRTANJE 2';'FONDAN 1';'FONDAN 2';'FONDANT SLIKA';'JESTIVA SLIKA ';'MALA FIGURA UKRAS';'RUZA MALA UKRAS';'RUZA MINI UKRAS';'RUZA SREDNJA UKRAS';'RUZA VELIKA UKRAS';'UKRAS 1';'UKRAS 2';'UKRAS MALI';'UKRAS MINI';'UKRAS SREDNJI';'UKRAS STAPIC MALI';'UKRAS VELIKI'};
hrut={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HRU')
        hrut{end+1,1}=ulaz.naziv{i};
    end
end
if size(hru,1)~=size(hrut,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HRU')
        for j=1:size(hru,1)
            if strcmp(ulaz.naziv(i),hru{j,1})
                while ulaz.zaliha(i)<0
                    for k=1:size(inventarHrane,1)
                        if strcmp(ulaz.naziv(i),inventarHrane{k,1})
                            tempBroj=inventarHrane{k,2}-ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                            ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                            ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                            tempModifikovano=1;
                        end
                    end
                    if tempModifikovano==0
                        ulaz.zaliha(i)=ulaz.zaliha(i)+1;
                        ulaz.ulaz(i)=ulaz.ulaz(i)+1;
                        ulaz.Ukupno(i)=ulaz.Ukupno(i)+1;
                    end
                    tempModifikovano=0;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

hss={'COOKIES';'KAFA+COCKTA';'KESTEN PIRE SA SLAGOM';'MACARONS';'MED CASICA';'MED KESICA';'POKLON 1';'POKLON 2';'POKLON 3';'POKLON 4';'POKLON 5';'SENDVIC+COCKTA';'SLADOLED KG';'SLADOLED KUGLA';'SLADOLED PORCIJA';'SLATKI KORNET';'ZITO';'ZITO SA SLAGOM'};
hsst={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HSS')
        hsst{end+1,1}=ulaz.naziv{i};
    end
end
if size(hss,1)~=size(hsst,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HSS')
        for j=1:size(hss,1)
            if strcmp(ulaz.naziv(i),hss{j,1})
                if ulaz.zaliha(i)<0
                    for k=1:size(inventarHrane,1)
                        if strcmp(ulaz.naziv(i),inventarHrane{k,1})
                            tempBroj=inventarHrane{k,2}-ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                            ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                            ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                            tempModifikovano=1;
                        end
                    end
                    if tempModifikovano==0
                        tempBroj=ulaz.zaliha(i);
                        ulaz.zaliha(i)=ulaz.zaliha(i)-ulaz.zaliha(i);
                        ulaz.ulaz(i)=ulaz.ulaz(i)-ulaz.zaliha(i);
                        ulaz.Ukupno(i)=ulaz.Ukupno(i)-ulaz.zaliha(i);
                    end
                    tempModifikovano=0;
                elseif ulaz.zaliha(i)>0
                    for k=1:size(inventarHrane,1)
                        if strcmp(ulaz.naziv(i),inventarHrane{k,1})
                            if ulaz.zaliha(i)>inventarHrane{k,2}
                                tempBroj=inventarHrane{k,2}-ulaz.zaliha(i);
                                ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                                ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                                ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                            end
                        end
                    end
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

%treba stopirati izlaz kada je stanje manje on napisanog
inventarPica={'AQVA VIVA 0.25',[];'AQVA VIVA 0.5',[];'COCA-COLA 0.25',[];'COCA-COLA 0.5',[];'COCKTA',[];'COKOLADNO MLEKO 0.25',[];'FANTA ORANGE 0.25',[];'FANTA ORANGE 0.5',[];'GUARANA 0.25',[];'JOGURT 0.2 M',[];'JOGURT PEKARSKI',[];'KNJAZ 0.25',[];'KNJAZ 0.5',[];'LEDENI CAJ',[];'NEXT SOK 0.2',[];'PIVO JELEN 0.33',[];'PIVO TUBORG 0.33',[];'ROSA 0.33',[];'ROSA 0.5',[];'SCHWEPPES 0.25',[];'SCHWEPPES 0.5',[];'SPRITE 0.25',[];'SPRITE 0.5',[];'ULTRA',[];'VINO VOCNO',[]};
for i=1:size(inventarPica,1)
    tempstr={'unesite stanje ',inventarPica{i,1},': '};
    tempstr=strjoin(tempstr);
    inventarPica{i,2}=input(tempstr);
end
%zasto uopste nastimavamo kad ja svakako prodam ono sto je proslo, sto ne
%prodaju odma
alk={'PIVO JELEN 0.33',[];'PIVO TUBORG 0.33',[];'VINO VOCNO',[]};
alkt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'ALK')
        alkt{end+1,1}=ulaz.naziv{i};
    end
end
if size(alk,1)~=size(alkt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'ALK')
        for j=1:size(alk,1)
            if strcmp(ulaz.naziv(i),alk{j,1})
                for k=1:size(inventarPica,1)
                    if strcmp(ulaz.naziv(i),inventarPica{k,1})
                        tempModifikovano=1;
                        if ulaz.zaliha(i)>=inventarPica{k,2}&&ulaz.zaliha(i)-inventarPica{k,2}<10
                            tempBroj=ulaz.zaliha(i)-inventarPica{k,2};
                            ulaz.zaliha(i)=ulaz.zaliha(i)-tempBroj;
                            ulaz.izlaz(i)=ulaz.izlaz(i)+tempBroj;                             
                        end
                        if ulaz.zaliha(i)<inventarPica{k,2}&&ulaz.zaliha(i)>=0
                            tempBroj=ulaz.zaliha(i)-inventarPica{k,2};
                            if abs(tempBroj)<=ulaz.izlaz(i)
                                ulaz.izlaz(i)=ulaz.izlaz(i)+tempBroj;
                                ulaz.zaliha(i)=ulaz.zaliha(i)-tempBroj;
                            else
                                temp=ulaz.izlaz(i);
                                ulaz.izlaz(i)=0;
                                ulaz.zaliha(i)=ulaz.zaliha(i)+temp;
                            end
                        end  
                        if ulaz.zaliha(i)<0
                            ulaz.izlaz(i)=ulaz.izlaz(i)+ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+abs(ulaz.zaliha(i));
                            if ulaz.izlaz(i)>ulaz.Ukupno(i)
                                disp('izlaz pica veci od ukupnog');
                                return
                            end
                            if ulaz.izlaz(i)<0
                                disp('izlaz pica u minusu');
                                return
                            end
                        end
                    end
                end
                if tempModifikovano==0
                    ulaz.ulaz(i)=ulaz.izlaz(i);
                    ulaz.zaliha(i)=0;
                    ulaz.Ukupno(i)=ulaz.ulaz(i)+ulaz.pstanje(i);
                end
                tempModifikovano=0;
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

gaz={'CEDEVITA 0.2';'CEDEVITA 0.3';'CEDJENA MALINA 0.2';'CEDJENA NARANDZA 0.2';'CEDJENA NARANDZA 0.3';'CEDJENI GREJP 0.2';'COCA-COLA 0.25';'COCA-COLA 0.5';'COCKTA';'COCKTA 0.5';'COCKTA BLACK 0.25';'FANTA ORANGE 0.25';'FANTA ORANGE 0.5';'GUARANA 0.25';'LEDENI CAJ';'LIMUNADA 0.2';'LIMUNADA 0.3';'LIMUNADA 0.5';'LIMUNADA APARAT 0.2';'LIMUNADA APARAT 0.3';'LIMUNADA APARAT 0.5';'LIMUNADA ZA PONETI';'NEXT SOK 0.2';'PEPSI 0.5';'SCHWEPPES 0.25';'SCHWEPPES 0.5';'SPRITE 0.25';'SPRITE 0.5';'ULTRA';'ZOVA 0.2';'ZOVA 0.3';'ZOVA 0.5';'ZOVA ZA PONETI'};
gazt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'GAZ')
        gazt{end+1,1}=ulaz.naziv{i};
    end
end
if size(gaz,1)~=size(gazt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'GAZ')
        for j=1:size(gaz,1)
            if strcmp(ulaz.naziv(i),gaz{j,1})
                for k=1:size(inventarPica,1)
                    if strcmp(ulaz.naziv(i),inventarPica{k,1})
                        tempModifikovano=1;
                        if ulaz.zaliha(i)>=inventarPica{k,2}&&ulaz.zaliha(i)-inventarPica{k,2}<10
                            tempBroj=ulaz.zaliha(i)-inventarPica{k,2};
                            ulaz.zaliha(i)=ulaz.zaliha(i)-tempBroj;
                            ulaz.izlaz(i)=ulaz.izlaz(i)+tempBroj;
                        end
                        if ulaz.zaliha(i)<inventarPica{k,2}&&ulaz.zaliha(i)>=0
                            tempBroj=ulaz.zaliha(i)-inventarPica{k,2};
                            if abs(tempBroj)<=ulaz.izlaz(i)
                                ulaz.izlaz(i)=ulaz.izlaz(i)+tempBroj;
                                ulaz.zaliha(i)=ulaz.zaliha(i)-tempBroj;
                            else
                                temp=ulaz.izlaz(i);
                                ulaz.izlaz(i)=0;
                                ulaz.zaliha(i)=ulaz.zaliha(i)+temp;
                            end
                        end  
                        if ulaz.zaliha(i)<0
                            ulaz.izlaz(i)=ulaz.izlaz(i)+ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+abs(ulaz.zaliha(i));
                            if ulaz.izlaz(i)>ulaz.Ukupno(i)
                                disp('izlaz pica veci od ukupnog');
                                return
                            end
                            if ulaz.izlaz(i)<0
                                disp('izlaz pica u minusu');
                                return
                            end
                        end
                    end
                end
                if tempModifikovano==0
                    ulaz.ulaz(i)=ulaz.izlaz(i);
                    ulaz.zaliha(i)=0;
                    ulaz.Ukupno(i)=ulaz.ulaz(i)+ulaz.pstanje(i);
                end
                tempModifikovano=0;
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

top={'AB JOGURT';'CAJ DELUXE';'CAJ DOMACI';'CAJ MILFORD';'COKOLADNO MLEKO 0,2';'COKOLADNO MLEKO 0.25';'ESSPRESO';'ESSPRESO SA MLEKOM';'ESSPRESO SA SLAGOM';'ESSPRESO SLAG MLEKO';'ICECAFFE FULL KUGLA SLAG';'ICECAFFE SLADOLED';'ICECAFFE SLAG';'JOGURT 0.2 M';'JOGURT KRAVICA 0.5';'JOGURT PEKARSKI';'JOGURT TROUGAO 0.2';'KAFA LATE';'KAFA TURSKA ';'KAFA TURSKA SA MLEKOM';'KAFA TURSKA SA SLAGOM';'KAPUCINO';'MLEKO 0.2';'NESCAFE SA MLEKOM';'NESCAFE SA SLAGOM';'TOPLA COKOLADA';'TOPLA COKOLADA SLAG'};
topt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'TOP')
        topt{end+1,1}=ulaz.naziv{i};
    end
end
if size(top,1)~=size(topt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'TOP')
        for j=1:size(top,1)
            if strcmp(ulaz.naziv(i),top{j,1})
                for k=1:size(inventarPica,1)
                    if strcmp(ulaz.naziv(i),inventarPica{k,1})
                        tempModifikovano=1;
                        if strcmp(ulaz.naziv(i),'JOGURT 0.2 M')||strcmp(ulaz.naziv(i),'JOGURT PEKARSKI')
                            nepobrojano=20;
                        else
                            nepobrojano=10;
                        end
                        if ulaz.zaliha(i)>=inventarPica{k,2}&&ulaz.zaliha(i)-inventarPica{k,2}<nepobrojano
                            tempBroj=ulaz.zaliha(i)-inventarPica{k,2};
                            ulaz.zaliha(i)=ulaz.zaliha(i)-tempBroj;
                            ulaz.izlaz(i)=ulaz.izlaz(i)+tempBroj;
                        end
                        if ulaz.zaliha(i)<inventarPica{k,2}&&ulaz.zaliha(i)>=0
                            tempBroj=ulaz.zaliha(i)-inventarPica{k,2};
                            if abs(tempBroj)<=ulaz.izlaz(i)
                                ulaz.izlaz(i)=ulaz.izlaz(i)+tempBroj;
                                ulaz.zaliha(i)=ulaz.zaliha(i)-tempBroj;
                            else
                                temp=ulaz.izlaz(i);
                                ulaz.izlaz(i)=0;
                                ulaz.zaliha(i)=ulaz.zaliha(i)+temp;
                            end
                        end  
                        if ulaz.zaliha(i)<0
                            ulaz.izlaz(i)=ulaz.izlaz(i)+ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+abs(ulaz.zaliha(i));
                            if ulaz.izlaz(i)>ulaz.Ukupno(i)
                                disp('izlaz pica veci od ukupnog');
                                return
                            end
                            if ulaz.izlaz(i)<0
                                disp('izlaz pica u minusu');
                                return
                            end
                        end
                    end
                end
                if tempModifikovano==0
                    ulaz.ulaz(i)=ulaz.izlaz(i);
                    ulaz.zaliha(i)=0;
                    ulaz.Ukupno(i)=ulaz.ulaz(i)+ulaz.pstanje(i);
                end
                tempModifikovano=0;
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

vod={'AQVA VIVA 0.25';'AQVA VIVA 0.33';'AQVA VIVA 0.5';'KNJAZ 0.25';'KNJAZ 0.33';'KNJAZ 0.5';'ROSA 0.33';'ROSA 0.5';'ROSA 0.75'};
vodt={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'VOD')
        vodt{end+1,1}=ulaz.naziv{i};
    end
end
if size(vod,1)~=size(vodt,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'VOD')
        for j=1:size(vod,1)
            if strcmp(ulaz.naziv(i),vod{j,1})
                for k=1:size(inventarPica,1)
                    if strcmp(ulaz.naziv(i),inventarPica{k,1})
                        tempModifikovano=1;
                        if ulaz.zaliha(i)>=inventarPica{k,2}&&ulaz.zaliha(i)-inventarPica{k,2}<10
                            tempBroj=ulaz.zaliha(i)-inventarPica{k,2};
                            ulaz.zaliha(i)=ulaz.zaliha(i)-tempBroj;
                            ulaz.izlaz(i)=ulaz.izlaz(i)+tempBroj;
                        end
                        if ulaz.zaliha(i)<inventarPica{k,2}&&ulaz.zaliha(i)>=0
                            tempBroj=ulaz.zaliha(i)-inventarPica{k,2};
                            if abs(tempBroj)<=ulaz.izlaz(i)
                                ulaz.izlaz(i)=ulaz.izlaz(i)+tempBroj;
                                ulaz.zaliha(i)=ulaz.zaliha(i)-tempBroj;
                            else
                                temp=ulaz.izlaz(i);
                                ulaz.izlaz(i)=0;
                                ulaz.zaliha(i)=ulaz.zaliha(i)+temp;
                            end
                        end  
                        if ulaz.zaliha(i)<0
                            ulaz.izlaz(i)=ulaz.izlaz(i)+ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+abs(ulaz.zaliha(i));
                            if ulaz.izlaz(i)>ulaz.Ukupno(i)
                                disp('izlaz pica veci od ukupnog');
                                return
                            end
                            if ulaz.izlaz(i)<0
                                disp('izlaz pica u minusu');
                                return
                            end
                        end
                    end
                end
                if tempModifikovano==0
                    ulaz.ulaz(i)=ulaz.izlaz(i);
                    ulaz.zaliha(i)=0;
                    ulaz.Ukupno(i)=ulaz.ulaz(i)+ulaz.pstanje(i);
                end
                tempModifikovano=0;
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

zaustavi=0;
for i=1:size(ulaz,1)
    if ulaz.ulaz(i)<0
        disp('ima minus ulaza')
        disp(ulaz.naziv(i))
        zaustavi=1;
        if i==size(ulaz,1)
            if zaustavi==1
                return
            end
        end
    end
end
zaustavi=0;


utrosenoVrPice=0;
utrosenoVrHrana=0;
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'ALK')||strcmp(ulaz.atip(i),'GAZ')||strcmp(ulaz.atip(i),'TOP')||strcmp(ulaz.atip(i),'VOD')
        utrosenoVrPice=utrosenoVrPice+ulaz.VrPrometa(i);
    else
        utrosenoVrHrana=utrosenoVrHrana+ulaz.VrPrometa(i);
    end
end
ukPromet=utrosenoVrPice+utrosenoVrHrana;

tempstr={};
tracice=0;
for i=1:3
    tempstr={'unesite tracicu ',num2str(i),': '};
    tempstr=strjoin(tempstr);
    koliko=input(tempstr);
    tracice=tracice+koliko;
end
promet=ukPromet;

% for i=1:size(ulaz,1)
%     if strcmp(ulaz.naziv(i),'POGACICE MLADI SIR')
%         indeks=i;
%     end
% end
% while promet-tracice>=(ulaz.izlaz(indeks).*ulaz.cena(indeks)-(5.*ulaz.cena(indeks)))
%     for i=1:size(ulaz,1)
%         if strcmp(ulaz.naziv(i),'SENDVIC PIPI')
%             indekss=i;
%         end
%     end
%     ulaz.izlaz(indekss)=ulaz.izlaz(indekss)-1;
%     ulaz.ulaz(indekss)=ulaz.ulaz(indekss)-1;
%     promet=promet-ulaz.cena(indekss);
%     ulaz.VrPrometa(indekss)=ulaz.izlaz(indekss).*ulaz.cena(indekss);
%     ulaz.VrPoreza(indekss)=ulaz.VrPrometa(indekss)*0.16666667;
%     ulaz.Ukupno(indekss)=ulaz.Ukupno(indekss)-1;
%     ulaz.VrNab(indekss)=ulaz.cena(indekss).*ulaz.ulaz(indekss);
% end
    

if rem(promet-tracice,10)==5||rem(promet-tracice,10)==-5
    for i=1:size(ulaz,1)
        if strcmp(ulaz.naziv(i),'PAL. PUD. VAN.SL. VEL')
            indeks=i;
        end
    end
    promet=promet+ulaz.cena(indeks);
    ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+1;
    ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+1;
    ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
    ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
    ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+1;
    ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
end

while rem(promet-tracice,4.5)~=0
    for i=1:size(ulaz,1)
        if strcmp(ulaz.naziv(i),'POGACICE MLADI SIR')
            indeks=i;
        end
    end
    ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+0.01;
    ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+0.01;
    ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
    ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
    ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+0.01;
    ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
    promet=promet+(ulaz.cena(indeks).*0.01);
    for i=1:size(ulaz,1)
        if strcmp(ulaz.naziv(i),'MINI PROJA')
            indeks=i;
        end
    end
    ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+0.01;
    ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+0.01;
    ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
    ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
    ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+0.01;
    ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
    promet=promet+(ulaz.cena(indeks).*0.01);
    
end


if promet>tracice
    stim=promet-tracice;
    if rem(stim,4.5)==0
        tmp=stim./4.5;
        for i=1:size(ulaz,1)
            if strcmp(ulaz.naziv(i),'POGACICE MLADI SIR')
                indeks=i;
            end
        end
        ulaz.izlaz(indeks)=ulaz.izlaz(indeks)-tmp./100;
        ulaz.ulaz(indeks)=ulaz.ulaz(indeks)-tmp./100;
        ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
        ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
        ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)-tmp./100;
        ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
        promet=promet-(ulaz.cena(indeks).*(tmp./100));
    elseif rem(stim,4.5)==0.5
        tmp=floor(stim./4)-1;
        for i=1:size(ulaz,1)
            if strcmp(ulaz.naziv(i),'POGACICE MLADI SIR')
                indeks=i;
            end
        end
        ulaz.izlaz(indeks)=ulaz.izlaz(indeks)-tmp./100;
        ulaz.ulaz(indeks)=ulaz.ulaz(indeks)-tmp./100;
        ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
        ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
        ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)-tmp./100;
        ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
        promet=promet-(ulaz.cena(indeks).*(tmp./100));
        for i=1:size(ulaz,1)
            if strcmp(ulaz.naziv(i),'MINI PROJA')
                indeks=i;
            end
        end
        ulaz.izlaz(indeks)=ulaz.izlaz(indeks)-0.01;
        ulaz.ulaz(indeks)=ulaz.ulaz(indeks)-0.01;
        ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
        ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
        ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)-0.01;
        ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
        promet=promet-(ulaz.cena(indeks).*0.01);
    end
elseif promet<tracice
    stim=abs(promet-tracice);
    if rem(stim,4.5)==0
        tmp=stim./4.5;
        for i=1:size(ulaz,1)
            if strcmp(ulaz.naziv(i),'POGACICE MLADI SIR')
                indeks=i;
            end
        end
        ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+tmp./100;
        ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+tmp./100;
        ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
        ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
        ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+tmp./100;
        ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
        promet=promet+(ulaz.cena(indeks).*(tmp./100));
    elseif rem(stim,4.5)==0.5
        tmp=floor(stim./4.5)-1;
        for i=1:size(ulaz,1)
            if strcmp(ulaz.naziv(i),'POGACICE MLADI SIR')
                indeks=i;
            end
        end
        ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+tmp./100;
        ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+tmp./100;
        ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
        ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
        ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+tmp./100;
        ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
        promet=promet+(ulaz.cena(indeks).*(tmp./100));
        for i=1:size(ulaz,1)
            if strcmp(ulaz.naziv(i),'MINI PROJA')
                indeks=i;
            end
        end
        ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+0.01;
        ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+0.01;
        ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
        ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
        ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+0.01;
        ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
        promet=promet+(ulaz.cena(indeks).*0.01);
    end
end

hpo={'INTEGRALNE POGACICE';'KIFLICE SA DZEMOM';'KIFLICE SLANE PRAZNE';'KIFLICE SLANE PUNJENE';'KOKTEL PECIVO';'MINI MAFIN COKOLADNI';'MINI MAFIN SA VISNJAMA';'MINI PROJA';'POGACICE MLADI SIR';'POGACICE SA SAJTOM';'POGACICE ZUZU'};
hpot={};
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPO')
        hpot{end+1,1}=ulaz.naziv{i};
    end
end
if size(hpo,1)~=size(hpot,1)
    disp('unesi novi artikal')
    return
end
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'HPO')
        for j=1:size(hpo,1)
            if strcmp(ulaz.naziv(i),hpo{j,1})
                while ulaz.zaliha(i)<0
                    for k=1:size(inventarHrane,1)
                        if strcmp(ulaz.naziv(i),inventarHrane{k,1})
                            tempBroj=inventarHrane{k,2}-ulaz.zaliha(i);
                            ulaz.zaliha(i)=ulaz.zaliha(i)+tempBroj;
                            ulaz.ulaz(i)=ulaz.ulaz(i)+tempBroj;
                            ulaz.Ukupno(i)=ulaz.Ukupno(i)+tempBroj;
                            tempModifikovano=1;
                        end
                    end
                    if tempModifikovano==0
                        ulaz.zaliha(i)=ulaz.zaliha(i)+1;
                        ulaz.ulaz(i)=ulaz.ulaz(i)+1;
                        ulaz.Ukupno(i)=ulaz.Ukupno(i)+1;
                    end
                    tempModifikovano=0;
                end
                ulaz.VrPrometa(i)=ulaz.cena(i)*ulaz.izlaz(i);
                ulaz.VrPoreza(i)=ulaz.VrPrometa(i)*0.16666667;
            end
        end
    end
end

% if rem(promet-tracice,10)==5||rem(promet-tracice,10)==-5
%     for i=1:size(ulaz,1)
%         if strcmp(ulaz.naziv(i),'PAL. PUD. VAN.SL. VEL')
%             indeks=i;
%         end
%     end
%     promet=promet+ulaz.cena(indeks);
%     ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+1;
%     ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+1;
%     ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
%     ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
%     ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+1;
%     ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
% end
%     
% if promet>tracice
%     while rem(promet-tracice,100)~=0
%         for i=1:size(ulaz,1)
%             if strcmp(ulaz.naziv(i),'PAL. EURO. PLAZ. VELIKA')
%                 indeks=i;
%             end
%         end
%         promet=promet+ulaz.cena(indeks);
%         ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+1;
%         ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+1;
%         ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
%         ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
%         ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+1;
%         ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
%     end
%     while promet-tracice~=0
%         if promet-tracice>100
%             for i=1:size(ulaz,1)
%                 if strcmp(ulaz.naziv(i),'PAL. PIPI VELIKA')
%                     indeks=i;
%                 end
%             end
%             promet=promet-ulaz.cena(indeks);
%             ulaz.izlaz(indeks)=ulaz.izlaz(indeks)-1;
%             ulaz.ulaz(indeks)=ulaz.ulaz(indeks)-1;
%             ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
%             ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
%             ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)-1;
%             ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
%         elseif promet-tracice==100
%             for i=1:size(ulaz,1)
%                 if strcmp(ulaz.naziv(i),'PITA SIR SUNKA GLJIVE')
%                     indeks=i;
%                 end
%             end
%             promet=promet-ulaz.cena(indeks);
%             ulaz.izlaz(indeks)=ulaz.izlaz(indeks)-1;
%             ulaz.ulaz(indeks)=ulaz.ulaz(indeks)-1;
%             ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
%             ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
%             ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)-1;
%             ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
%         end
%     end
% elseif promet<tracice
%     while rem(tracice-promet,100)~=0
%         for i=1:size(ulaz,1)
%             if strcmp(ulaz.naziv(i),'PAL. EURO. PLAZ. VELIKA')
%                 indeks=i;
%             end
%         end
%         promet=promet-ulaz.cena(indeks);
%         ulaz.izlaz(indeks)=ulaz.izlaz(indeks)-1;
%         ulaz.ulaz(indeks)=ulaz.ulaz(indeks)-1;
%         ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
%         ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
%         ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)-1;
%         ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
%     end
%     while tracice-promet~=0
%         if tracice-promet>100
%             for i=1:size(ulaz,1)
%                 if strcmp(ulaz.naziv(i),'PAL. PIPI VELIKA')
%                     indeks=i;
%                 end
%             end
%             promet=promet+ulaz.cena(indeks);
%             ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+1;
%             ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+1;
%             ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
%             ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
%             ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+1;
%             ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
%         elseif tracice-promet==100
%             for i=1:size(ulaz,1)
%                 if strcmp(ulaz.naziv(i),'PITA SIR SUNKA GLJIVE')
%                     indeks=i;
%                 end
%             end
%             promet=promet+ulaz.cena(indeks);
%             ulaz.izlaz(indeks)=ulaz.izlaz(indeks)+1;
%             ulaz.ulaz(indeks)=ulaz.ulaz(indeks)+1;
%             ulaz.VrPrometa(indeks)=ulaz.izlaz(indeks).*ulaz.cena(indeks);
%             ulaz.VrPoreza(indeks)=ulaz.VrPrometa(indeks)*0.16666667;
%             ulaz.Ukupno(indeks)=ulaz.Ukupno(indeks)+1;
%             ulaz.VrNab(indeks)=ulaz.cena(indeks).*ulaz.ulaz(indeks);
%         end
%     end
% else
%     disp('lista je dobra');
% end

zaustaviUlaz=0;
for i=1:size(ulaz,1)
    if ulaz.ulaz(i)<0
        disp('ima minus ulaza')
        disp(ulaz.naziv(i))
        zaustaviUlaz=1;
        if i==size(ulaz,1)
            if zaustaviUlaz==1
                disp('error')
                return
            end
        end
    end
end


zaustaviIzlaz=0;
for i=1:size(ulaz,1)
    if ulaz.izlaz(i)<0
        disp('ima minus izlaza')
        disp(ulaz.izlaz(i))
        zaustaviIzlaz=1;
        if i==size(ulaz,1)
            if zaustaviIzlaz==1
                disp('error')
                return
            end
        end
    end
end


utrosenoVrPice=0;
utrosenoVrHrana=0;
for i=1:size(ulaz,1)
    if strcmp(ulaz.atip(i),'ALK')||strcmp(ulaz.atip(i),'GAZ')||strcmp(ulaz.atip(i),'TOP')||strcmp(ulaz.atip(i),'VOD')
        utrosenoVrPice=utrosenoVrPice+ulaz.VrPrometa(i);
    else
        utrosenoVrHrana=utrosenoVrHrana+ulaz.VrPrometa(i);
    end
end
ukPromet=utrosenoVrPice+utrosenoVrHrana;

ulaz.VrNab=ulaz.ulaz.*ulaz.cena;
ulaz.rb=(1:size(ulaz,1))';
pstanjeVr=sum(ulaz.pstanje.*ulaz.cena);
ulazVr=sum(ulaz.VrNab);
ukupnoVr=pstanjeVr+ulazVr;
zalihaVr=sum(ulaz.zaliha.*ulaz.cena);

ulaz.rb=int16(ulaz.rb);


if ukPromet==tracice && zaustaviUlaz==0 && zaustaviIzlaz==0
    disp('ulazZaSutra je dobra')
    ulazZaSutra=ulaz;
    save('prethodna.mat','ulazZaSutra');
else
    disp('ulazZaSutra NIJE dobra' )
    return
end


ulaz.naziv(end+1)={'Poc Stanje u din:'};
ulaz.naziv(end+1)={'Nabavka u din:'};
ulaz.naziv(end+1)={'Ukupno u din:'};
ulaz.naziv(end+1)={'Zaliha u din:'};
ulaz.naziv(end+1)={'Prodata hrana u din:'};
ulaz.naziv(end+1)={'Prodato pice u din:'};
ulaz.naziv(end+1)={'Ukupno prodato u din:'};
ulaz.porez(end-6)=pstanjeVr;
ulaz.porez(end-5)=ulazVr;
ulaz.porez(end-4)=ukupnoVr;
ulaz.porez(end-3)=zalihaVr;
ulaz.porez(end-2)=utrosenoVrHrana;
ulaz.porez(end-1)=utrosenoVrPice;
ulaz.porez(end)=ukPromet;

kolone={'Rb','Naziv','JM','PDV','PocStanje','Nabavka','Ukupno','Zaliha','Utroseno','Cena','VrednPrometa','ProdVrNabavRobe'};
podaci=table2cell(table(ulaz.rb,ulaz.naziv,ulaz.jm,ulaz.porez,ulaz.pstanje,ulaz.ulaz,ulaz.Ukupno,ulaz.zaliha,ulaz.izlaz,ulaz.cena,ulaz.VrPrometa,ulaz.VrNab,'VariableNames',kolone));
imeListe='lista.xlsx';
naslov={'','IZVESTAJ DNEVNOG PROMETA','','','','','','','','','',''};
date=ulaz.oddana(1);
date.Format='dd-MMM-yyyy';
date=datestr(date);
date=cellstr(date(1:11));
datum={'','Za dan:','','','','','','','','','','';'',date,'','','','','','','','','',''};
lista=vertcat(naslov,datum,kolone,podaci);
for i=1:size(lista,1)
    if strcmp(lista{i,2},'Poc Stanje u din:')
        for j=i:size(lista,1)
            lista{j,1}=[];
            lista{j,5}=[];
            lista{j,6}=[];
            lista{j,7}=[];
            lista{j,8}=[];
            lista{j,9}=[];
            lista{j,10}=[];
            lista{j,11}=[];
            lista{j,12}=[];
        end
    end
end

if ukPromet==tracice && zaustaviUlaz==0 && zaustaviIzlaz==0
    disp('lista je dobra')
    tempstr={'lista',date{1,1},'.xls'};
    tempstr=strjoin(tempstr,'');
    xlswrite(tempstr,lista);
else
    disp('lista NIJE dobra' )
    return
end



