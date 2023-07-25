Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D64760CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjGYIKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGYIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:10:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FCFA4;
        Tue, 25 Jul 2023 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690272644; x=1721808644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gD9ghxtvQUKb6DIekcbQydO6E3OoEwN111Bh/9xRB+Q=;
  b=Lc18K9KmV6qTiZKawaEviP0+aqJ1St42PFxaQOBZly6Xy7vsmhqrKia9
   DokaekLHyk9DeMQwxlrPjcRD/CK5iJyVV4fyp7GjxQLzrShuZqFssheq2
   ygD5hfcq2YuzEpTwA1gi9FSfIbQbJxY9BCYt6rmE0Nfx3WhCXzxl2NbiX
   SwgTAbDtbG0eiyFO0ZKxhiTayDLhwiaafrHpzivv2BfMp8Ki2glcY4nW7
   FEQacFClIzFKCO5mqoZEGXs7CvPH06eU2hLldjCzbg4+NdbGMK91BV2I/
   eV3WWrYI5OvuugnWzrwLF791StlS2QbOPu2T3QEDiFYJ4Pca5aEobUjMZ
   g==;
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="asc'?scan'208";a="163065829"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2023 01:10:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Jul 2023 01:10:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Jul 2023 01:10:40 -0700
Date:   Tue, 25 Jul 2023 09:10:06 +0100
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
Message-ID: <20230725-distant-overrule-a98ad406125f@wendy>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
 <20230725-unheard-dingy-42f0fafe7216@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GrJ4P94jZcxwJ23/"
Content-Disposition: inline
In-Reply-To: <20230725-unheard-dingy-42f0fafe7216@wendy>
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

--GrJ4P94jZcxwJ23/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guo Ren,

On Tue, Jul 25, 2023 at 08:52:09AM +0100, Conor Dooley wrote:
> On Tue, Jul 25, 2023 at 03:38:58PM +0800, Xi Ruoyao wrote:
> > On Sun, 2023-06-18 at 00:15 +0800, Jisheng Zhang wrote:
> > > Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> > > module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> > > tree files for the core module and the development board.
> > >=20
> > > Support basic uart/gpio/dmac drivers, so supports booting to a basic
> > > shell.
> >=20
> > Thanks for the excellent work, but when I tried to boot Linux 6.5.0-rc3
> > on my Lichee Pi 4A it fails with:
> >=20
> > ## Flattened Device Tree blob at 01f00000
> >    Booting using the fdt blob at 0x1f00000
> >    Using Device Tree in place at 0000000001f00000, end 0000000001f050c4
> >=20
> > Starting kernel ...
> >=20
> > [    0.000000] Linux version 6.5.0-rc3 (lfs@stargazer) (riscv64-lfs-lin=
ux-gnu-gcc (GCC) 13.1.0, GNU ld (GNU Binutils) 2.40) #1 SMP PREEMPT Tue Jul=
 25 13:38:20 CST 2023
> > [    0.000000] Machine model: Sipeed Lichee Pi 4A
> > [    0.000000] SBI specification v0.3 detected

> > [    0.000000] SBI implementation ID=3D0x1 Version=3D0x9

> > [    0.000000] Oops - load access fault [#1]
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc3 #1
> > [    0.000000] Hardware name: Sipeed Lichee Pi 4A (DT)
> > [    0.000000] epc : __plic_toggle+0x5a/0x62
> > [    0.000000]  ra : __plic_init.isra.0+0x2d0/0x462
> > [    0.000000] epc : ffffffff802ce8ec ra : ffffffff80618816 sp : ffffff=
ff80e03c90
> > [    0.000000]  gp : ffffffff80ec5bb8 tp : ffffffff80e10d40 t0 : ffffff=
d900045940
> > [    0.000000]  t1 : 0000000000000002 t2 : ffffffd90004a10c s0 : ffffff=
d9fef6ed68
> > [    0.000000]  s1 : ffffffd900045680 a0 : ffffffc801002080 a1 : 000000=
0000000002
> > [    0.000000]  a2 : 0000000000000000 a3 : 00000000000000f4 a4 : 000000=
0000000001
> > [    0.000000]  a5 : 0000000000000000 a6 : 0000000000000b40 a7 : ffffff=
d900045940
> > [    0.000000]  s2 : ffffffd9fef6ed78 s3 : ffffffff80ef9630 s4 : 000000=
0000000001
> > [    0.000000]  s5 : ffffffd9ffff5af8 s6 : 0000000000000001 s7 : ffffff=
ff80815d68
> > [    0.000000]  s8 : 0000000000000008 s9 : 0000000000000000 s10: ffffff=
ff80815d68
> > [    0.000000]  s11: ffffffff80b1b1b8 t3 : ffffffff80c003d0 t4 : 000000=
0000000001
> > [    0.000000]  t5 : 0000000000000003 t6 : 0000000000000001
> > [    0.000000] status: 8000000201800100 badaddr: 000000ffd8002080 cause=
: 0000000000000005
> > [    0.000000] [<ffffffff802ce8ec>] __plic_toggle+0x5a/0x62
> > [    0.000000] [<ffffffff8061ffc8>] of_irq_init+0x14a/0x248
> > [    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
> > [    0.000000] [<ffffffff806034f6>] init_IRQ+0xc6/0x100
> > [    0.000000] [<ffffffff80600a7e>] start_kernel+0x40c/0x6fe
> > [    0.000000] Code: 0007 c319 9123 00e7 8082 000f 0140 411c 000f 0820 =
(c593) fff5=20
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] Kernel panic - not syncing: Fatal exception in interrupt
> >=20
> > I guess I'm either using some unsupported configuration or making some
> > stupid mistakes, but I cannot find any documentation about how to
> > configure the mainline kernel for Lichee Pi 4A properly.  Could you give
> > some pointers?
>=20
> Are you using the vendor OpenSBI? IIRC, and the lads can probably
> correct me here, you need to have an OpenSBI that contains
> https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9f=
b31623a42ced45f38ea6
> which the vendor supplied OpenSBI does not have.

Guo Ren, can you try to get this sorted out? The T-Head SDK seems to be
shipping stuff that is several years old, so new SoCs from vendors that
have used your SDK are unable to run mainline kernels (and therefore
mainstream distros), without a firmware update.

The TH1520 branch on github, seems to be based on OpenSBI v0.9:
> > [    0.000000] SBI implementation ID=3D0x1 Version=3D0x9
https://github.com/T-head-Semi/opensbi/blob/4e77060e0512ad981eee55d5a2501f6=
d88a41fd9/include/sbi/sbi_version.h#L13
OpenSBI v0.9 was released on the 18/01/2021:
https://github.com/riscv-software-src/opensbi/releases/tag/v0.9
The "fix" I linked above was included in v1.0, released on 24/12/2021.

I think it is hitting here for the Lichee Pi4a, but I know the same
thing has happened to the BeagleV Ahead, and I figure it'll impact
other SoCs going forward too.

Thanks,
Conor

--GrJ4P94jZcxwJ23/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL+DXgAKCRB4tDGHoIJi
0llcAQDR5tEZTJhPKBP4Fam+8hImDMWe66hAE6EHOP7hdNg37wD+LFu2vDyUjjEa
W2Z4F6U+kkSbDkMYZWNMVa74kTkQ5QE=
=PqE1
-----END PGP SIGNATURE-----

--GrJ4P94jZcxwJ23/--
