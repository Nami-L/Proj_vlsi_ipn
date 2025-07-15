##=============================================================================
## [Filename]       Makefile.vcs
## [Project]        Probe
## [Author]         Luis Namigtle - namigtle066@gmail.com
## [Language]       GNU Makefile
## [Created]        Jun 2025
## [Modified]       -
## [Description]    Probe Makefile for testing the UVC
## [Notes]          -
## [Status]         Stable
## [Revisions]      -
##=============================================================================

# ===============================  VARIABLES  =================================
CUR_DATE := $(shell date +%Y-%m-%d_%H-%M-%S)

#Directores
GIT_DIR := $(shell git rev-parse --show-toplevel)
RUN_DIR := $(GIT_DIR)/work
RTL_DIR := $(GIT_DIR)/hw/rtl
TB_DIR := $(GIT_DIR)/hw/tb

#simulation configuration
SEED :=1

#Simulation mode
GUI_MODE ?= false
RUN_FLAGS ?=

# ===============================  CONTROL  ==================================
ifeq ($(GUI_MODE),true)
  RUN_FLAGS += -gui
endif

# ===============================  TOOLS SYNOPSYS  ==================================
## Busco mi archivo RTL y mi TB
## Concateno ambos archivos para despues llamarlo al simulados de synopsys
RTL_FILES := $(shell find $(RTL_DIR) -name "*.v" -or -name "*.sv")
TB_FILES := $(shell find $(TB_DIR) -name "*v" -or -name "*-sv")
FILES := $(TB_FILES) $(RTL_FILES)
TOP_MODULE := tb_contador_gray_detector
#Synopsys VCS / SIMV options

VCS_FLAGS := -full64 -sverilog \
			 -lca -debug_access+all -kdb \
			 -timescale=1ns/10ps $(FILES) -l comp.log \
			 -top $(TOP_MODULE) \
			 -j8
SIMV_FLAGS := -l simv_$(CUR_DATE).log $(RUN_FLAGS)
VERDI_FLAGS := -ssf novas.fsdb -dbdir simv.daidir -nologo -q

#Definir paleta de colores para impresion de mensajes
C_RED := \033[31m
C_GREEN := \033[32m
C_BLUE := \033[34m
C_YELLOW := \033[33m
C_ORANGE := \033[38;5;214m
NC := \033[0m
# ===============================  TARGETS  =====================================
SHELL := bash
DEFAULT_GOAL := all
.PHONY: all 
all: help

# ===============================    =====================================
#Se imprimiran las variables aquí
.PHONY: vars
vars:
	@echo ""
	@echo -e "$(C_ORANGE)Miscelanea de variables $(NC)"
	@echo "CUR_DATE : $(CUR_DATE)"
	@echo ""
	@echo -e "$(C_ORANGE)Directorio de variables $(NC)"
	@echo "GIT_DIR: $(GIT_DIR)"
	@echo "RUN_DIR: $(RUN_DIR)"
	@echo "RTL_DIR: $(RTL_DIR)"
	@echo "TB_DIR: $(TB_DIR)"
	@echo "GUI_MODE: $(GUI_MODE)"
	@echo "RUN_FLAGS: $(RUN_FLAGS)"
	@echo ""
	@echo -e "$(C_GREEN)Archivos de simulacion $(NC)"
	@echo "TB_FILES = $(TB_FILES)"
	@echo "RTL_FILES = $(RTL_FILES)"

#______________________________________________________________________________
.PHONY: compile
compile: ## Compilación del RTL y simulacion de las fuentes VCS
	@echo -e "$(C_YELLOW)Compilando project $(NC)"
	@mkdir -p $(RUN_DIR)/sim
	cd $(RUN_DIR)/sim && vcs $(VCS_FLAGS)
#______________________________________________________________________________
.PHONY: sim
sim: # Correr simulacion usando una semilla configurada
	@echo -e "$(C_YELLOW)Simulando con VCS $(NC)"
	@mkdir -p $(RUN_DIR)/sim
	cd $(RUN_DIR)/sim && ./simv +ntb_random_seed=$(SEED) $(SIMV_FLAGS)
#______________________________________________________________________________
.PHONY: verdi
verdi: ## Abrir Verdi con la simulacion
	@echo -e "$(C_YELLOW)Abriendo Verdi $(NC)"
	cd $(RUN_DIR)/sim && verdi $(VERDI_FLAGS) &

#______________________________________________________________________________
.PHONY: clean
clean: ## Limpiar el directorio de trabajo
	@echo -e "$(C_YELLOW) Limpiando el directorio de trabajo $(NC)"
	rm -rf $(RUN_DIR)

# ================================  TARGETS  ==================================
.PHONY: help
help: ## Mostrar ayuda de los targets disponibles
	@echo ""
	@echo "======================================================================"
	@echo "Usage : make [target] [variables]"
	@echo ""
	@echo "--------------------------- Targets ----------------------------------"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "- make \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "--------------------------- Variables -------------------------------"
	@echo ""
	@echo "SEED                 : Random seed used, must ve as integer mayor 0 "    
	@echo "GUI_MODE             : Enables to run the sim in gui mode [true|false]"    	
	@echo "-------------------------- Variable Values --------------------------"
	@echo ""
	@echo "SEED                 : $(SEED) "    
	@echo "GUI_MODE             : $(GUI_MODE)"
	@echo "======================================================================"
	@echo ""