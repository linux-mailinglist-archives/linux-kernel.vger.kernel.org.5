Return-Path: <linux-kernel+bounces-19334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FA826B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF01F22291
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45213AF9;
	Mon,  8 Jan 2024 10:27:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614B213AC9;
	Mon,  8 Jan 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rMmMM-00026i-00; Mon, 08 Jan 2024 10:55:54 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 53BBCC0135; Mon,  8 Jan 2024 10:41:14 +0100 (CET)
Date: Mon, 8 Jan 2024 10:41:14 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-mips@vger.kernel.org
Subject: Re: [PATCH 6/8] MIPS: Fix typos
Message-ID: <ZZvDOl8mBbeDmdyu@alpha.franken.de>
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-7-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103231605.1801364-7-helgaas@kernel.org>

On Wed, Jan 03, 2024 at 05:16:03PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/mips".  Only touches comments,
> no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/bcm47xx/buttons.c                            | 6 +++---
>  arch/mips/bcm63xx/clk.c                                | 4 ++--
>  arch/mips/boot/compressed/dbg.c                        | 2 +-
>  arch/mips/boot/elf2ecoff.c                             | 2 +-
>  arch/mips/cavium-octeon/csrc-octeon.c                  | 2 +-
>  arch/mips/cavium-octeon/executive/cvmx-boot-vector.c   | 2 +-
>  arch/mips/cavium-octeon/executive/cvmx-bootmem.c       | 2 +-
>  arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c     | 4 ++--
>  arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c   | 2 +-
>  arch/mips/cavium-octeon/executive/cvmx-pko.c           | 2 +-
>  arch/mips/cavium-octeon/octeon-platform.c              | 2 +-
>  arch/mips/fw/arc/promlib.c                             | 6 +++---
>  arch/mips/include/asm/debug.h                          | 2 +-
>  arch/mips/include/asm/io.h                             | 4 ++--
>  arch/mips/include/asm/mach-au1x00/au1000_dma.h         | 2 +-
>  arch/mips/include/asm/mach-au1x00/gpio-au1000.h        | 2 +-
>  arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h  | 2 +-
>  arch/mips/include/asm/mach-loongson64/loongson_hwmon.h | 2 +-
>  arch/mips/include/asm/mach-loongson64/loongson_regs.h  | 2 +-
>  arch/mips/include/asm/mach-malta/spaces.h              | 4 ++--
>  arch/mips/include/asm/mips-boards/bonito64.h           | 2 +-
>  arch/mips/include/asm/mips-cpc.h                       | 2 +-
>  arch/mips/include/asm/mipsregs.h                       | 4 ++--
>  arch/mips/include/asm/octeon/cvmx-bootinfo.h           | 2 +-
>  arch/mips/include/asm/octeon/cvmx-cmd-queue.h          | 6 +++---
>  arch/mips/include/asm/octeon/cvmx-pko.h                | 2 +-
>  arch/mips/include/asm/octeon/cvmx-pow.h                | 4 ++--
>  arch/mips/include/asm/octeon/octeon-model.h            | 4 ++--
>  arch/mips/include/asm/page.h                           | 2 +-
>  arch/mips/include/asm/pci.h                            | 2 +-
>  arch/mips/include/asm/pgtable-bits.h                   | 2 +-
>  arch/mips/include/asm/sgi/mc.h                         | 2 +-
>  arch/mips/include/asm/sn/klconfig.h                    | 2 +-
>  arch/mips/include/asm/sync.h                           | 2 +-
>  arch/mips/include/asm/thread_info.h                    | 2 +-
>  arch/mips/include/asm/timex.h                          | 2 +-
>  arch/mips/include/asm/vdso/vdso.h                      | 2 +-
>  arch/mips/include/uapi/asm/mman.h                      | 2 +-
>  arch/mips/include/uapi/asm/msgbuf.h                    | 2 +-
>  arch/mips/kernel/cpu-probe.c                           | 2 +-
>  arch/mips/kernel/kprobes.c                             | 2 +-
>  arch/mips/kernel/relocate.c                            | 2 +-
>  arch/mips/kernel/relocate_kernel.S                     | 2 +-
>  arch/mips/kernel/setup.c                               | 2 +-
>  arch/mips/kernel/signal.c                              | 2 +-
>  arch/mips/kernel/traps.c                               | 2 +-
>  arch/mips/kernel/vpe.c                                 | 4 ++--
>  arch/mips/kvm/emulate.c                                | 2 +-
>  arch/mips/loongson2ef/common/platform.c                | 2 +-
>  arch/mips/loongson64/smp.c                             | 2 +-
>  arch/mips/mm/c-r4k.c                                   | 2 +-
>  arch/mips/mm/cex-gen.S                                 | 2 +-
>  arch/mips/mm/tlb-r3k.c                                 | 2 +-
>  arch/mips/mm/tlb-r4k.c                                 | 2 +-
>  arch/mips/mm/tlbex.c                                   | 4 ++--
>  arch/mips/net/bpf_jit_comp32.c                         | 2 +-
>  arch/mips/pci/ops-loongson2.c                          | 2 +-
>  arch/mips/pci/pci-alchemy.c                            | 2 +-
>  arch/mips/pci/pci-ar2315.c                             | 2 +-
>  arch/mips/pci/pci-lantiq.c                             | 2 +-
>  arch/mips/pci/pci-octeon.c                             | 2 +-
>  arch/mips/pci/pci-xtalk-bridge.c                       | 2 +-
>  arch/mips/pci/pcie-octeon.c                            | 2 +-
>  arch/mips/ralink/mt7621.c                              | 2 +-
>  arch/mips/txx9/generic/pci.c                           | 2 +-
>  65 files changed, 80 insertions(+), 80 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

