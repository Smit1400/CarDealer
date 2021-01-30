import torch
import torch.nn as nn

class UsedCarPricePredictionNN(nn.Module):
    def __init__(self, cat_dim, n_cont, layers, out_sz, p=0.5):
        super().__init__()
        embedded_dim = [(i, min(50, (i+1) // 2)) for i in cat_dim]
        self.embd_list = nn.ModuleList([nn.Embedding(inp, out) for inp, out in embedded_dim])
        self.drpout = nn.Dropout(p)
        self.batchnorm = nn.BatchNorm1d(n_cont)
        
        layerslist = []
        n_emb = sum([out for inp, out in embedded_dim])
        n_in = n_emb + n_cont
        
        for i in layers:
            layerslist.append(nn.Linear(n_in, i))
            layerslist.append(nn.ReLU(inplace = True))
            layerslist.append(nn.BatchNorm1d(i))
            layerslist.append(nn.Dropout(p))
            n_in = i
        layerslist.append(nn.Linear(layers[-1], out_sz))
        
        self.layers = nn.Sequential(* layerslist)
        
        
    def forward(self, x_cat, x_cont):
        embeddings = []
        for i, e in enumerate(self.embd_list):
            embeddings.append(e(x_cat[:,i]))
        x = torch.cat(embeddings, 1)
        x = self.drpout(x)
        
        x_cont = self.batchnorm(x_cont)
        
        x = torch.cat([x, x_cont], axis=1)
        
        x = self.layers(x)
        
        return x
        
        