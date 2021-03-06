PLATFORM_FLAVOR ?= b2260

include core/arch/arm/cpu/cortex-a9.mk

$(call force,CFG_ARM32_core,y)
$(call force,CFG_SECURE_TIME_SOURCE_REE,y)
$(call force,CFG_PL310,y)
$(call force,CFG_CACHE_API,y)
$(call force,CFG_PM_STUBS,y)
$(call force,CFG_WITH_LPAE,n)
$(call force,CFG_GIC,y)

CFG_WITH_PAGER ?= n
CFG_BOOT_SYNC_CPU ?= y
CFG_TEE_CORE_EMBED_INTERNAL_TESTS ?= y
CFG_WITH_STATS ?= y
CFG_WITH_SOFTWARE_PRNG ?= n
CFG_STIH_UART ?= y
CFG_ENABLE_SCTLR_RR ?= y

ifeq ($(PLATFORM_FLAVOR),b2260)
$(call force,CFG_TEE_CORE_NB_CORE,2)
CFG_DDR_START ?= 0x40000000
CFG_DDR_SIZE ?= 0x40000000
CFG_STM_RSV_DRAM_STARTBYTES ?= 0
CFG_CORE_TZSRAM_EMUL_START ?= 0x7fe00000
CFG_DDR_TEETZ_RESERVED_START ?= 0x7e000000
CFG_DDR_TEETZ_RESERVED_SIZE ?= 0x01e00000
CFG_PL310_LOCKED ?= y
else
$(call force,CFG_TEE_CORE_NB_CORE,2)
CFG_DDR_START ?= 0x40000000
CFG_DDR_SIZE ?= 0x80000000
CFG_STM_RSV_DRAM_STARTBYTES ?= 0x02000000
CFG_CORE_TZSRAM_EMUL_START ?= 0x94a00000
CFG_DDR_TEETZ_RESERVED_START ?= 0x93a00000
CFG_DDR_TEETZ_RESERVED_SIZE ?= 0x01000000
CFG_PL310_LOCKED ?= n
endif

CFG_SHMEM_SIZE ?= 0x00200000
CFG_TZDRAM_START ?= ($(CFG_DDR_TEETZ_RESERVED_START))
CFG_TZDRAM_SIZE ?= ($(CFG_DDR_TEETZ_RESERVED_SIZE) - $(CFG_SHMEM_SIZE))
CFG_TZSRAM_START ?= ($(CFG_CORE_TZSRAM_EMUL_START))
CFG_TZSRAM_SIZE ?= ($(CFG_CORE_TZSRAM_EMUL_SIZE))
CFG_SHMEM_START ?= ($(CFG_TZDRAM_START) + $(CFG_TZDRAM_SIZE))
