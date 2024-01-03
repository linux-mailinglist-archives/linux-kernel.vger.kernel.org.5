Return-Path: <linux-kernel+bounces-16105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A199B823909
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D431DB24295
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C231EB46;
	Wed,  3 Jan 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxLMLqBF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B731EB2D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 23:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38893C433C8;
	Wed,  3 Jan 2024 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704323774;
	bh=R2NttzC+SJ7wsXu6PI+wO6f/njKyqbsjVy3lv1Bgdbs=;
	h=From:To:Cc:Subject:Date:From;
	b=AxLMLqBFQybDeVCANStXYAT5eHeShO/waEvbpyFeuY3OCtooVosXvxNOo2UtCkkpd
	 +dRfPsQK1O8VGgndxGhSG0+GvgzVgKXsw4wdpTWe7rmEH4ZlPegEVLft99EiNBu2wN
	 BxTfsduhw5sSRWU4AD7vtOU5VGl+6usWw/oEBclkAV4Li7sa4D3CE8n9l8ShLIRT9K
	 EM62qlIil4TFVj6bHt6pyybUaaj7rwLQ+QinTK/mNQ2LQGXbWDXpxxM3uCfLkLybjZ
	 rxkjwaV68pe3QBBhpIY4c10BNtgrnFqsTn4a384BpUOwcxYZyFA10Wl367bZpnZ4GK
	 1VjsiaHi5BPdw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: 
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/8] arch/ typo fixes
Date: Wed,  3 Jan 2024 17:15:57 -0600
Message-Id: <20240103231605.1801364-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos in some arch/ directories, mostly from "codespell arch/".  No
code changes, only comment changes.

Bjorn Helgaas (8):
  alpha: Fix typos
  ARC: Fix typos
  arm64: Fix typos
  arm64: dts: Fix typos
  KVM: arm64: Fix typos
  MIPS: Fix typos
  powerpc: Fix typos
  sparc: Fix typos

 arch/alpha/boot/bootpz.c                             |  4 ++--
 arch/alpha/include/asm/core_marvel.h                 |  2 +-
 arch/alpha/include/asm/fpu.h                         |  2 +-
 arch/alpha/include/asm/sfp-machine.h                 |  2 +-
 arch/alpha/include/asm/thread_info.h                 |  2 +-
 arch/alpha/include/asm/wrperfmon.h                   |  2 +-
 arch/alpha/include/uapi/asm/mman.h                   |  2 +-
 arch/alpha/kernel/err_impl.h                         |  2 +-
 arch/alpha/kernel/irq_i8259.c                        |  2 +-
 arch/alpha/kernel/osf_sys.c                          |  2 +-
 arch/alpha/kernel/pci_iommu.c                        |  4 ++--
 arch/alpha/kernel/sys_eiger.c                        |  4 ++--
 arch/alpha/kernel/sys_marvel.c                       |  2 +-
 arch/alpha/kernel/sys_miata.c                        |  2 +-
 arch/alpha/kernel/sys_takara.c                       |  2 +-
 arch/alpha/lib/ev6-memcpy.S                          |  2 +-
 arch/alpha/lib/ev6-stxcpy.S                          |  2 +-
 arch/alpha/lib/ev67-strrchr.S                        |  2 +-
 arch/alpha/lib/strrchr.S                             |  2 +-
 arch/alpha/lib/stxcpy.S                              |  2 +-
 arch/arc/boot/Makefile                               |  4 ++--
 arch/arc/boot/dts/axc003.dtsi                        |  4 ++--
 arch/arc/boot/dts/vdk_axs10x_mb.dtsi                 |  2 +-
 arch/arc/include/asm/dsp.h                           |  2 +-
 arch/arc/include/asm/entry-compact.h                 | 10 +++++-----
 arch/arc/include/asm/entry.h                         |  4 ++--
 arch/arc/include/asm/irq.h                           |  2 +-
 arch/arc/include/asm/irqflags-compact.h              |  2 +-
 arch/arc/include/asm/mmu_context.h                   |  2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h            |  2 +-
 arch/arc/include/asm/shmparam.h                      |  2 +-
 arch/arc/include/asm/smp.h                           |  4 ++--
 arch/arc/include/asm/thread_info.h                   |  2 +-
 arch/arc/include/uapi/asm/swab.h                     |  2 +-
 arch/arc/kernel/entry-arcv2.S                        |  8 ++++----
 arch/arc/kernel/entry.S                              |  4 ++--
 arch/arc/kernel/head.S                               |  2 +-
 arch/arc/kernel/intc-arcv2.c                         |  2 +-
 arch/arc/kernel/perf_event.c                         |  2 +-
 arch/arc/kernel/setup.c                              |  2 +-
 arch/arc/kernel/signal.c                             |  2 +-
 arch/arc/kernel/traps.c                              |  2 +-
 arch/arc/kernel/vmlinux.lds.S                        |  4 ++--
 arch/arc/mm/tlbex.S                                  |  8 ++++----
 arch/arm64/Kconfig                                   |  2 +-
 .../boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts  |  2 +-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi           |  2 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi               |  2 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi              |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi       |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts  |  2 +-
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi     |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi                |  4 ++--
 .../boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi    |  2 +-
 arch/arm64/boot/dts/qcom/sa8155p.dtsi                |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi           |  4 ++--
 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts     |  2 +-
 .../arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi |  2 +-
 arch/arm64/boot/dts/renesas/draak.dtsi               |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts  |  2 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi           |  2 +-
 arch/arm64/include/asm/assembler.h                   |  4 ++--
 arch/arm64/include/asm/cpufeature.h                  |  4 ++--
 arch/arm64/include/asm/kvm_hyp.h                     |  2 +-
 arch/arm64/include/asm/pgtable.h                     |  2 +-
 arch/arm64/include/asm/suspend.h                     |  2 +-
 arch/arm64/include/asm/traps.h                       |  4 ++--
 arch/arm64/kernel/acpi.c                             |  2 +-
 arch/arm64/kernel/cpufeature.c                       |  6 +++---
 arch/arm64/kernel/entry-common.c                     |  2 +-
 arch/arm64/kernel/entry-ftrace.S                     |  2 +-
 arch/arm64/kernel/entry.S                            |  2 +-
 arch/arm64/kernel/ftrace.c                           |  2 +-
 arch/arm64/kernel/machine_kexec.c                    |  2 +-
 arch/arm64/kernel/probes/uprobes.c                   |  2 +-
 arch/arm64/kernel/sdei.c                             |  2 +-
 arch/arm64/kernel/smp.c                              |  2 +-
 arch/arm64/kernel/traps.c                            |  2 +-
 arch/arm64/kvm/arch_timer.c                          |  2 +-
 arch/arm64/kvm/fpsimd.c                              |  2 +-
 arch/arm64/kvm/hyp/nvhe/host.S                       |  2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c                         |  4 ++--
 arch/arm64/kvm/inject_fault.c                        |  2 +-
 arch/arm64/kvm/vgic/vgic-init.c                      |  2 +-
 arch/arm64/kvm/vgic/vgic-its.c                       |  4 ++--
 arch/mips/bcm47xx/buttons.c                          |  6 +++---
 arch/mips/bcm63xx/clk.c                              |  4 ++--
 arch/mips/boot/compressed/dbg.c                      |  2 +-
 arch/mips/boot/elf2ecoff.c                           |  2 +-
 arch/mips/cavium-octeon/csrc-octeon.c                |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-boot-vector.c |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c     |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c   |  4 ++--
 arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-pko.c         |  2 +-
 arch/mips/cavium-octeon/octeon-platform.c            |  2 +-
 arch/mips/fw/arc/promlib.c                           |  6 +++---
 arch/mips/include/asm/debug.h                        |  2 +-
 arch/mips/include/asm/io.h                           |  4 ++--
 arch/mips/include/asm/mach-au1x00/au1000_dma.h       |  2 +-
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h      |  2 +-
 .../mips/include/asm/mach-lantiq/falcon/lantiq_soc.h |  2 +-
 .../include/asm/mach-loongson64/loongson_hwmon.h     |  2 +-
 .../mips/include/asm/mach-loongson64/loongson_regs.h |  2 +-
 arch/mips/include/asm/mach-malta/spaces.h            |  4 ++--
 arch/mips/include/asm/mips-boards/bonito64.h         |  2 +-
 arch/mips/include/asm/mips-cpc.h                     |  2 +-
 arch/mips/include/asm/mipsregs.h                     |  4 ++--
 arch/mips/include/asm/octeon/cvmx-bootinfo.h         |  2 +-
 arch/mips/include/asm/octeon/cvmx-cmd-queue.h        |  6 +++---
 arch/mips/include/asm/octeon/cvmx-pko.h              |  2 +-
 arch/mips/include/asm/octeon/cvmx-pow.h              |  4 ++--
 arch/mips/include/asm/octeon/octeon-model.h          |  4 ++--
 arch/mips/include/asm/page.h                         |  2 +-
 arch/mips/include/asm/pci.h                          |  2 +-
 arch/mips/include/asm/pgtable-bits.h                 |  2 +-
 arch/mips/include/asm/sgi/mc.h                       |  2 +-
 arch/mips/include/asm/sn/klconfig.h                  |  2 +-
 arch/mips/include/asm/sync.h                         |  2 +-
 arch/mips/include/asm/thread_info.h                  |  2 +-
 arch/mips/include/asm/timex.h                        |  2 +-
 arch/mips/include/asm/vdso/vdso.h                    |  2 +-
 arch/mips/include/uapi/asm/mman.h                    |  2 +-
 arch/mips/include/uapi/asm/msgbuf.h                  |  2 +-
 arch/mips/kernel/cpu-probe.c                         |  2 +-
 arch/mips/kernel/kprobes.c                           |  2 +-
 arch/mips/kernel/relocate.c                          |  2 +-
 arch/mips/kernel/relocate_kernel.S                   |  2 +-
 arch/mips/kernel/setup.c                             |  2 +-
 arch/mips/kernel/signal.c                            |  2 +-
 arch/mips/kernel/traps.c                             |  2 +-
 arch/mips/kernel/vpe.c                               |  4 ++--
 arch/mips/kvm/emulate.c                              |  2 +-
 arch/mips/loongson2ef/common/platform.c              |  2 +-
 arch/mips/loongson64/smp.c                           |  2 +-
 arch/mips/mm/c-r4k.c                                 |  2 +-
 arch/mips/mm/cex-gen.S                               |  2 +-
 arch/mips/mm/tlb-r3k.c                               |  2 +-
 arch/mips/mm/tlb-r4k.c                               |  2 +-
 arch/mips/mm/tlbex.c                                 |  4 ++--
 arch/mips/net/bpf_jit_comp32.c                       |  2 +-
 arch/mips/pci/ops-loongson2.c                        |  2 +-
 arch/mips/pci/pci-alchemy.c                          |  2 +-
 arch/mips/pci/pci-ar2315.c                           |  2 +-
 arch/mips/pci/pci-lantiq.c                           |  2 +-
 arch/mips/pci/pci-octeon.c                           |  2 +-
 arch/mips/pci/pci-xtalk-bridge.c                     |  2 +-
 arch/mips/pci/pcie-octeon.c                          |  2 +-
 arch/mips/ralink/mt7621.c                            |  2 +-
 arch/mips/txx9/generic/pci.c                         |  2 +-
 arch/powerpc/boot/Makefile                           |  4 ++--
 arch/powerpc/boot/dts/acadia.dts                     |  2 +-
 arch/powerpc/boot/main.c                             |  2 +-
 arch/powerpc/boot/ps3.c                              |  2 +-
 arch/powerpc/include/asm/io.h                        |  2 +-
 arch/powerpc/include/asm/opal-api.h                  |  4 ++--
 arch/powerpc/include/asm/pmac_feature.h              |  2 +-
 arch/powerpc/include/asm/uninorth.h                  |  2 +-
 arch/powerpc/include/uapi/asm/bootx.h                |  2 +-
 arch/powerpc/kernel/eeh_pe.c                         |  2 +-
 arch/powerpc/kernel/fadump.c                         |  2 +-
 arch/powerpc/kernel/misc_64.S                        |  4 ++--
 arch/powerpc/kernel/process.c                        | 12 ++++++------
 arch/powerpc/kernel/ptrace/ptrace-tm.c               |  2 +-
 arch/powerpc/kernel/smp.c                            |  2 +-
 arch/powerpc/kernel/sysfs.c                          |  4 ++--
 arch/powerpc/kvm/book3s_xive.c                       |  2 +-
 arch/powerpc/mm/cacheflush.c                         |  2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c                 |  2 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c         |  2 +-
 arch/powerpc/platforms/cell/spufs/sched.c            |  2 +-
 arch/powerpc/platforms/maple/pci.c                   |  2 +-
 arch/powerpc/platforms/powermac/pic.c                |  2 +-
 arch/powerpc/platforms/powermac/sleep.S              |  2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c           |  4 ++--
 arch/powerpc/platforms/powernv/vas-window.c          |  2 +-
 arch/powerpc/platforms/pseries/vas.c                 |  2 +-
 arch/powerpc/sysdev/xive/common.c                    |  4 ++--
 arch/powerpc/sysdev/xive/native.c                    |  2 +-
 arch/sparc/include/asm/hypervisor.h                  |  6 +++---
 arch/sparc/include/asm/ldc.h                         |  2 +-
 arch/sparc/include/asm/mmu_context_64.h              |  4 ++--
 arch/sparc/include/asm/switch_to_64.h                |  2 +-
 arch/sparc/kernel/irq_64.c                           |  2 +-
 arch/sparc/kernel/kprobes.c                          |  2 +-
 arch/sparc/kernel/ldc.c                              |  2 +-
 arch/sparc/kernel/leon_pci_grpci2.c                  |  2 +-
 arch/sparc/kernel/of_device_64.c                     |  2 +-
 arch/sparc/kernel/pci.c                              |  2 +-
 arch/sparc/kernel/pci_impl.h                         |  4 ++--
 arch/sparc/kernel/pci_schizo.c                       |  4 ++--
 arch/sparc/kernel/perf_event.c                       |  2 +-
 arch/sparc/kernel/prom_irqtrans.c                    |  2 +-
 arch/sparc/kernel/psycho_common.c                    |  2 +-
 arch/sparc/kernel/signal_32.c                        |  2 +-
 arch/sparc/kernel/signal_64.c                        |  2 +-
 arch/sparc/mm/srmmu.c                                |  2 +-
 arch/sparc/mm/tsb.c                                  |  2 +-
 arch/sparc/net/bpf_jit_comp_32.c                     |  6 +++---
 199 files changed, 260 insertions(+), 260 deletions(-)

-- 
2.34.1


