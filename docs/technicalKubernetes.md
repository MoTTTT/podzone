# Kubernetes

Kubernetes is a technology that provides a set of functionality to manage the lifecycle of computing loads. It provides features that provide for high availability, using clustering technologies.

## Clustering

Clustering provides a layer of abstraction for computing resources, spanning virtual or physical machines.

## Abstraction of Resources

### Virtual or Physical machine

```mermaid
---
title: Example of Computing resources of a machine instance
---
graph LR

OS1[Operating System APIs] --> OS2[Machine Resources]

subgraph OS2[Machine Resources]
  subgraph  RAM
    subgraph 16 GB
    end
  end
  subgraph  CPU
    subgraph 4 Cores
    end
  end
  subgraph  Disk
    subgraph 125 GB
    end
  end
  subgraph  Network
    subgraph 1 GB Ethernet
    end
  end
end
```

### Clustered Resources

```mermaid
---
title: Computing resources of a machine cluster
---
graph LR
OS1[Cluster APIs] --> OS2[Cluster Resources]
subgraph OS2[Cluster Resources]
  subgraph Machine 1
    subgraph  RAM
      subgraph 16 GB
      end
    end
    subgraph  CPU
      subgraph 4 Cores
      end
    end
    subgraph  Disk
      subgraph 125 GB
      end
    end
    subgraph  Network
      subgraph 1 GB Ethernet
      end
    end
  end
  subgraph Machine 2
    subgraph  RAM
      subgraph 16 GB
      end
    end
    subgraph  CPU
      subgraph 4 Cores
      end
    end
    subgraph  Disk
      subgraph 125 GB
      end
    end
    subgraph  Network
      subgraph 1 GB Ethernet
      end
    end
  end
  subgraph Machine 3
    subgraph  RAM
      subgraph 16 GB
      end
    end
    subgraph  CPU
      subgraph 4 Cores
      end
    end
    subgraph  Disk
      subgraph 125 GB
      end
    end
    subgraph  Network
      subgraph 1 GB Ethernet
      end
    end
  end
end
```

```mermaid
---
title: Abstracted Resources
---
graph LR
OS1[Cluster APIs] --> OS2[Cluster Resources]
subgraph OS2[Cluster Resources]
  subgraph  RAM
    subgraph 48 GB
    end
  end
  subgraph  CPU
    subgraph 12 Cores
    end
  end
  subgraph  Disk
    subgraph 125 GB
    end
  end
  subgraph  Network
    subgraph 1 GB Ethernet
    end
  end
end
```
