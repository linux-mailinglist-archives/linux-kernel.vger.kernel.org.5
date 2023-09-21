Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467A77AA18B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjIUVDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjIUVC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:02:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDF64EC8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:22:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984F5C3278F;
        Thu, 21 Sep 2023 10:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695291338;
        bh=jFAqRCOVnDBQwszMKppgpfrfYXgx2S1l2UVTVChzJ6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FB4UmtJMfn+nsX5DZ3qo2JYzuPEw/NKKLuoRNU1w4rR862MDRN47bHTygae5k0amd
         oZFJeZk6psc3v49kSRgSuKWnb6qSVKyWIinaBQSDn8SnNX157QjRg+M7ghCNAs3yIU
         ddyCNZdvngVyPb/heuhDlL/snul1qeJW5/53Yr5XQMnxSg0nftB0P18lUPoG8WAeur
         RATGdFpyQDj/qc5sLQfrnbG7H8S0URXgZ05YATQsuMLKwjM6cQVpwfw2AHy0km/r03
         Eso5n0WarjMTlhsqZh/NdkDgeUkgZbhiyBsuJ+tCvNZQCrUQgDenOwzJfsS63ybdQ3
         Z28EfOHcPvUig==
Date:   Thu, 21 Sep 2023 11:15:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 09/11] riscv: dts: add initial SOPHGO SG2042 SoC
 device tree
Message-ID: <20230921-d2db829b289c937081dc8a72@fedora>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <ffe6a61a8879232aea7b86ff8aee5d681c6bd287.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-financial-declared-7b4b4baae517@wendy>
 <CAHAQgRBmUtyz-U+1Fu9qdvyhMuSzg+o4MMbTV9duUXsoSoPqUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmkZD3PJDOz3F1Rh"
Content-Disposition: inline
In-Reply-To: <CAHAQgRBmUtyz-U+1Fu9qdvyhMuSzg+o4MMbTV9duUXsoSoPqUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmkZD3PJDOz3F1Rh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 05:56:28PM +0800, Chen Wang wrote:
> Regards,
>=20
> unicornx
>=20
> Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=B8=89 16:58=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Yo,
> >
> > On Wed, Sep 20, 2023 at 02:40:32PM +0800, Chen Wang wrote:
> > > Milk-V Pioneer motherboard is powered by SOPHON's SG2042.
> > >
> > > SG2042 is server grade chip with high performance, low power
> > > consumption and high data throughput.
> > > Key features:
> > > - 64 RISC-V cpu cores which implements IMAFDC
> >
> > That's not quite true though, is it?
>=20
> The cpu cores of SG2042 is c902 from T-HEAD, it supports vector, but
> it's v0.7, not official v1.0. If we declare it as supporting
> v-extension, the latest kernel(since 6.5) will issue rvv1.0
> instructions during booting and make c902 crash. So we have to remove
> "v" from the capability of ISA to pass the booting of machine. You can
> check the "riscv,isa =3D "rv64imafdc";" in DTS.

I know all of this, not my first rodeo looking at stuff using T-Head
cores ;)
What I meant was, imafdc is only a subset of what is supported,
there are other things like the T-Head bitmanip extensions too, right?
I'm not asking for it to be listed in the devicetree (yet), just
actually curious what else is on the c920 as I do not speak a language
that allows me to read the documentation for the cpu that I have been
able to find online.

> > > - 4 cores per cluster, 16 clusters on chip
> > > - ......
> >
> > What's a "....."? ;)
> I just cited a description from TRM of SG2042 and it looks too long. I
> will give a better description here and avoid using "......" in the
> next revision.
>=20
> >
> > >
> > > More info is available at [1].
> > >
> > > [1]: https://en.sophgo.com/product/introduce/sg2042.html
> >
> > Link: please.
> >
> > > Currently only support booting into console with only uart,
> > > other features will be added soon later.
> > >
> > > Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.c=
om>
> > > Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> >
> > There are 4 sign-offs here. Surely some of these should be
> > co-developed-bys?
> >
> > > +             cpu0: cpu@0 {
> > > +                     compatible =3D "thead,c920", "riscv";
> > > +                     device_type =3D "cpu";
> > > +                     riscv,isa =3D "rv64imafdc";
> >
> > Please also add riscv,isa-base & riscv,isa-extensions.
> >
> > > +                     reg =3D <0>;
> > > +                     i-cache-block-size =3D <64>;
> > > +                     i-cache-size =3D <65536>;
> > > +                     i-cache-sets =3D <512>;
> > > +                     d-cache-block-size =3D <64>;
> > > +                     d-cache-size =3D <65536>;
> > > +                     d-cache-sets =3D <512>;
> > > +                     next-level-cache =3D <&l2_cache0>;
> > > +                     mmu-type =3D "riscv,sv39";
> > > +
> > > +                     cpu0_intc: interrupt-controller {
> > > +                             compatible =3D "riscv,cpu-intc";
> > > +                             interrupt-controller;
> > > +                             #interrupt-cells =3D <1>;
> > > +                     };
> > > +             };
> >
> > > diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot=
/dts/sophgo/sg2042.dtsi
> > > new file mode 100644
> > > index 000000000000..747fd9764c95
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > > @@ -0,0 +1,439 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> >
> > You should add () around the GPL-2.0 OR MIT.
> >
> > > +/*
> > > + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +#include "sg2042-cpus.dtsi"
> > > +
> > > +#define SOC_PERIPHERAL_IRQ(nr) (nr)
> >
> > Why? What does this do? Where was it copied from?
> >
> It should be unnecessary=EF=BC=8C I will remove it in the next revision.
>=20
> > > +
> > > +/ {
> > > +     compatible =3D "sophgo,sg2042";
> > > +     #address-cells =3D <2>;
> > > +     #size-cells =3D <2>;
> > > +     dma-noncoherent;
> > > +
> > > +     aliases {
> > > +             serial0 =3D &uart0;
> > > +     };
> > > +
> > > +     /* the mem node will be updated by ZSBL. */
> >
> > huh? So these are random numbers below? Either put something useful here
> > or delete it please.
>=20
> The memory for SG2042 is not fixed, the bootloader will detect memory
> installed on board during booting and fill the actual address and size
> in the memory node. The comment " /* the mem node will be updated by
> ZSBL. */" is telling this.

Yes, I read the comment!

> We write memory nodes like this to make them act just as placeholders
> and the value is by default written as zero.

Why knowingly add something that is wrong, rather than omitting them
entirely?

Thanks,
Conor.

>=20
>=20
> >
> > > +     memory@0 {
> > > +             device_type =3D "memory";
> > > +             reg =3D <0x00000000 0x00000000 0x00000000 0x00000000>;
> > > +     };
> > > +
> > > +     memory@1 {
> > > +             device_type =3D "memory";
> > > +             reg =3D <0x00000000 0x00000001 0x00000000 0x00000000>;
> > > +     };
> > > +
> > > +     memory@2 {
> > > +             device_type =3D "memory";
> > > +             reg =3D <0x00000000 0x00000002 0x00000000 0x00000000>;
> > > +     };
> > > +
> > > +     memory@3 {
> > > +             device_type =3D "memory";
> > > +             reg =3D <0x00000000 0x00000003 0x00000000 0x00000000>;
> > > +     };
> >
> > > +     soc: soc {
> > > +             compatible =3D "simple-bus";
> > > +             #address-cells =3D <2>;
> > > +             #size-cells =3D <2>;
> > > +             ranges;
> > > +
> > > +             clint_mswi: interrupt-controller@7094000000 {
> > > +                     compatible =3D "sophgo,sg2042-clint-mswi", "the=
ad,c900-clint-mswi";
> > > +                     reg =3D <0x00000070 0x94000000 0x00000000 0x000=
04000>;
> >
> > & nak to this without further explanation!
> >
> > Thanks,
> > Conor.
> >

--fmkZD3PJDOz3F1Rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQwXwQAKCRB4tDGHoIJi
0jl6AQCO0iHjWqM9oAoOC3vM0RKXtmi36doTgL/y4uLTh6RcxgEApx827mJwlqM+
T2Mfp1BE1i0rJvGerwlfpLGvc4y8Pws=
=djLA
-----END PGP SIGNATURE-----

--fmkZD3PJDOz3F1Rh--
