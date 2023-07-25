Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9F760C71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGYHww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjGYHwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:52:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04F8DA;
        Tue, 25 Jul 2023 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690271569; x=1721807569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcDhBURo5eZ7cl3bNptbB1Maqevp36TBC3qBJjBqfYs=;
  b=osV46zZLCVUKtt5amhM9F4rP94+SFMZsbqp2eoeYrlPKidmhVqfK+CPI
   iy9V1rwaRNXg2qPZ920OxzoA/aTPAh2knotnp4qfDRWQBH0r2+iQIWeVS
   EFBa4N6kb+yW2mWyovceOSYjkueMPkIS7jVQFt45O+0qdJgwc5rWIDzja
   I4pMhxhapc6QotGxCE3nP16J8cDGkjzfjuYUAY9tdsk2kQ2jLUhPSoNb4
   cnkWV2bFPBaSqEkapg31r9DB/Lk6ylqrtMRJ1+7b//PPy4P+78cHzulRr
   OjlGHoy4J7Z5ZVijOzm4iLynpLs+ip4vaXSRxhwR5JXwoKlW13xGTHBLj
   A==;
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="asc'?scan'208";a="225792426"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2023 00:52:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Jul 2023 00:52:46 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Jul 2023 00:52:43 -0700
Date:   Tue, 25 Jul 2023 08:52:09 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xi Ruoyao <xry111@linuxfromscratch.org>
CC:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <20230725-unheard-dingy-42f0fafe7216@wendy>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imFWINvzvxawhpga"
Content-Disposition: inline
In-Reply-To: <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--imFWINvzvxawhpga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Jul 25, 2023 at 03:38:58PM +0800, Xi Ruoyao wrote:
> Hi Jisheng,
>=20
> On Sun, 2023-06-18 at 00:15 +0800, Jisheng Zhang wrote:
> > Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> > module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> > tree files for the core module and the development board.
> >=20
> > Support basic uart/gpio/dmac drivers, so supports booting to a basic
> > shell.
>=20
> Thanks for the excellent work, but when I tried to boot Linux 6.5.0-rc3
> on my Lichee Pi 4A it fails with:
>=20
> ## Flattened Device Tree blob at 01f00000
>    Booting using the fdt blob at 0x1f00000
>    Using Device Tree in place at 0000000001f00000, end 0000000001f050c4
>=20
> Starting kernel ...
>=20
> [    0.000000] Linux version 6.5.0-rc3 (lfs@stargazer) (riscv64-lfs-linux=
-gnu-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP PREEMPT Tue Jul 2=
5 13:38:20 CST 2023
> [    0.000000] Machine model: Sipeed Lichee Pi 4A
> [    0.000000] SBI specification v0.3 detected
> [    0.000000] SBI implementation ID=3D0x1 Version=3D0x9
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] earlycon: uart0 at MMIO32 0x000000ffe7014000 (options '115=
200n8')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: 0x0000000000000000..0x000000000003ffff (=
256 KiB) nomap non-reusable mmode_resv0@0
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000000003ffff]
> [    0.000000]   node   0: [mem 0x0000000000040000-0x00000001ffffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000001fff=
fffff]
> [    0.000000] SBI HSM extension detected
> [    0.000000] riscv: base ISA extensions acdfim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 17 pages/cpu s38184 r0 d31448 u69632
> [    0.000000] Kernel command line: console=3DttyS0,115200 earlycon logle=
vel=3D7
> [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 83886=
08 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304=
 bytes, linear)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 206=
4384
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:=
off
> [    0.000000] software IO TLB: area num 4.
> [    0.000000] software IO TLB: mapped [mem 0x00000000fbfff000-0x00000000=
fffff000] (64MB)
> [    0.000000] Memory: 8145304K/8388608K available (4922K kernel code, 47=
86K rwdata, 2048K rodata, 2148K init, 393K bss, 243304K reserved, 0K cma-re=
served)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4,=
 Nodes=3D1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_=
ids=3D4.
> [    0.000000]  Trampoline variant of Tasks RCU enabled.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is=
 100 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D4
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] Oops - load access fault [#1]
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc3 #1
> [    0.000000] Hardware name: Sipeed Lichee Pi 4A (DT)
> [    0.000000] epc : __plic_toggle+0x5a/0x62
> [    0.000000]  ra : __plic_init.isra.0+0x2d0/0x462
> [    0.000000] epc : ffffffff802ce8ec ra : ffffffff80618816 sp : ffffffff=
80e03c90
> [    0.000000]  gp : ffffffff80ec5bb8 tp : ffffffff80e10d40 t0 : ffffffd9=
00045940
> [    0.000000]  t1 : 0000000000000002 t2 : ffffffd90004a10c s0 : ffffffd9=
fef6ed68
> [    0.000000]  s1 : ffffffd900045680 a0 : ffffffc801002080 a1 : 00000000=
00000002
> [    0.000000]  a2 : 0000000000000000 a3 : 00000000000000f4 a4 : 00000000=
00000001
> [    0.000000]  a5 : 0000000000000000 a6 : 0000000000000b40 a7 : ffffffd9=
00045940
> [    0.000000]  s2 : ffffffd9fef6ed78 s3 : ffffffff80ef9630 s4 : 00000000=
00000001
> [    0.000000]  s5 : ffffffd9ffff5af8 s6 : 0000000000000001 s7 : ffffffff=
80815d68
> [    0.000000]  s8 : 0000000000000008 s9 : 0000000000000000 s10: ffffffff=
80815d68
> [    0.000000]  s11: ffffffff80b1b1b8 t3 : ffffffff80c003d0 t4 : 00000000=
00000001
> [    0.000000]  t5 : 0000000000000003 t6 : 0000000000000001
> [    0.000000] status: 8000000201800100 badaddr: 000000ffd8002080 cause: =
0000000000000005
> [    0.000000] [<ffffffff802ce8ec>] __plic_toggle+0x5a/0x62
> [    0.000000] [<ffffffff8061ffc8>] of_irq_init+0x14a/0x248
> [    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
> [    0.000000] [<ffffffff806034f6>] init_IRQ+0xc6/0x100
> [    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
> [    0.000000] Code: 0007 c319 9123 00e7 8082 000f 0140 411c 000f 0820 (c=
593) fff5=20
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Fatal exception in interrupt
>=20
> I guess I'm either using some unsupported configuration or making some
> stupid mistakes, but I cannot find any documentation about how to
> configure the mainline kernel for Lichee Pi 4A properly.  Could you give
> some pointers?

Are you using the vendor OpenSBI? IIRC, and the lads can probably
correct me here, you need to have an OpenSBI that contains
https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb3=
1623a42ced45f38ea6
which the vendor supplied OpenSBI does not have.

> And this line
>=20
> Memory: 8145304K/8388608K available (4922K kernel code, 4786K rwdata, 204=
8K rodata, 2148K init, 393K bss, 243304K reserved, 0K cma-reserved)
>=20
> does not match my hardware (my board is a 16 GB DRAM variant).  So in
> the future we'll need multiple DTs for all the variants?

A bootloader stage would ideally patch the DT that the kernel ends up
getting. If you're loading your own dtb, you can do it easily in U-Boot
after you extract it from your FIT image or whatever. I have no idea
what the vendor U-Boot does.

Thanks,
Conor.

--imFWINvzvxawhpga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL9/KQAKCRB4tDGHoIJi
0sPRAP4rN2G8KHfW14gYoCsEy7MZCAFTuUF3P9d1RLJ2P0j4BQEA+5Xcdo+xiUKC
f9qPTPjO3AF9dj7MLyB4oLxf1VQZdQo=
=2bfI
-----END PGP SIGNATURE-----

--imFWINvzvxawhpga--
