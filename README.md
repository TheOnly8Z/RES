# Resource Extraction & Salvage (RES) System
1. Break down props for materials
2. Use tools and machines to extract resources from the world
3. Craft stuff with your resources

## Basic progression
0. Multitool
1. Workstation, Storage Cabinets
2. Burners, Drills, Smelter
3. Pumpjack, Refinery, Generator
4. Foundry, Autolathe

## Multitool
One multitool SWEP with different modes.

### Crowbar
- Salvage props

### E-Tool (shovel/axe/hoe)
- Dig up detritus
- Place, construct and repair certain buildings (sandbags, walls etc.)
- (Planned) Plant and harvest trees

### Hammer
- Place, construct and repair most buildings (machines, containers, etc.)

### Resource Bag
- Pick up and drop resources
- Very limited capacity
- Drops stuff on death

## Resources
Most resources exist physically in the world, either as a resource block or within a container or machine.

### Special
- Power
  - Generated by various machines
- (Planned) Scrips
  - Granted by selling resources and stuff
  - Spend on airdrops and other goodies

### Crude
- Wood
  - Salvaged from wooden props
- Scrap
  - Salvaged from metal props
- Oil
  - Salvaged from barrel props
  - Harvested by pumpjacks
- Detritus (sand/gravel)
  - Dug up from soft surfaces using E-Tool
- Ore
  - Harvested by drills

### Processed
- Coal
  - Harvested from drills
  - Smelted from wood
- Metal
  - Smelted from scrap and ore
- Fuel
  - Salvaged from fuel props
  - Refined from oil
- Glass
  - Salvaged from glass props
  - Smelted from detritus
- Plastic
  - Salvaged from plastic/rubber props
  - Smelted from oil
- Cement
  - Salvaged from concrete props
  - Refined from detritus
- Chemicals
  - Salvaged from container props
  - Refined from ore

### Refined
- Steel
  - Synthesized from Metal + Coal
- Polymer
  - Synthesized from Plastic + Chemicals
- Explosives
  - Synthesized from Fuel + Chemicals

### Parts
- Simple Parts
  - Assembled from Scrap + Wood
- Industrial Parts
  - Assembled from Metal + Polymer
- Electronic Parts
  - Assembled from Metal + Chemicals
- Advanced Parts
  - Assembled from Steel + Polymer + Glass

## Buildings
Power is automatically taken from nearby generators and can be turned into a resource.

### Storage Crates / Cabinets / Tanks
Stores resources. Higher tier containers can hold more types and more capacity.

### Workstation
General purpose assembly station for non-building stuff

Can make parts, but takes some time and requires player

### Burner
Create power from wood or coal

### Generator
Create power from fuel

### Drill
Place on a site to get coal or ore. If there's no deposit, mines detritus.

Has internal power and resource storage, but can only be manually operated.

Can be undeployed and moved around with gravgun

### Pumpjack
Static building that drills for oil.

### Smelter
Consume power to **smelt** raw resources
- Ore -> Metal
- Scrap -> Metal
- Oil -> Plastic
- Wood -> Coal
- Detritus -> Glass

### Refinery
Consume power to **refine** raw resources
- Ore -> Chemicals
- Oil -> Fuel
- Detritus -> Cement

### Foundry
Consume power to **synthesize** refined resources

### Autolathe
Consume power to **assemble** parts quickly and automatically