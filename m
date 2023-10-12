Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118EA7C69D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjJLJly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjJLJlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:41:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8739891
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:41:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A3AC433C7;
        Thu, 12 Oct 2023 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697103710;
        bh=nAvxg4KzDTsOzbMCukymkltoz6OpLA5eAEmEqSLDeDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6ukDJkjIGjg/RETfSZR34lITrSLkGjMTs10FWMidORsXst2UcwuhUKktEpHVw/x4
         KE8uL0+mYE715Q7Njw5fsFQE0Hi5RHgHZB56P+t0h4gKQp7u17NugHvRF6b0gGP2VA
         PPE+wUXxwnHB/7tLGOVpNta73TM2Z5Z3PWVr3oUsRkmjIxwhEGJSTxy/Wn+mUBaCOS
         tO9mT4OjYk6y0RjiJ7b+vztMPyu0oSKq0PG5jLxqzNc4go2IwKTS7dEek3Esu6hynr
         M6ynK6gTSNbbEQoDoqVTKhbLUAeIKiP/y29XFrnrpEY/eiRoHPWgLT56PHV56koSzh
         yGDofdIX1v2tA==
Date:   Thu, 12 Oct 2023 10:41:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] riscv: dts: sophgo: add initial CV1812H SoC
 device tree
Message-ID: <20231012-gratuity-siesta-b9e06b11be43@spud>
References: <MA0P287MB03321A9E3F3D8415DB9552B5FECDA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB4953AD81686694CEA4F5FC6ABBCDA@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FbIlMY2V77DRQAG0"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953AD81686694CEA4F5FC6ABBCDA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FbIlMY2V77DRQAG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 03:53:54PM +0800, Inochi Amaoto wrote:
> >On 2023/10/9 19:26, Inochi Amaoto wrote:
> >> Add initial device tree for the CV1812H RISC-V SoC by SOPHGO.
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >> ---
> >>   arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 36 +++++++++++++++++++++++=
++
> >>   1 file changed, 36 insertions(+)
> >>   create mode 100644 arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> >>
> >> diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot=
/dts/sophgo/cv1812h.dtsi
> >> new file mode 100644
> >> index 000000000000..3864d34b0100
> >> --- /dev/null
> >> +++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> >> @@ -0,0 +1,36 @@
> >> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >> +/*
> >> + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> >> + */
> >> +
> >> +#include <dt-bindings/interrupt-controller/irq.h>
> >This include is not required.
>=20
> Thx.

I can drop this include on application. Is the rest of the series okay
with you Chen Wang?

Thanks,
Conor.

>=20
> >> +#include "cv180x.dtsi"
> >> +
> >> +/ {
> >> +    compatible =3D "sophgo,cv1812h";
> >> +
> >> +    memory@80000000 {
> >> +        device_type =3D "memory";
> >> +        reg =3D <0x80000000 0x10000000>;
> >> +    };
> >What's this defined for , I see this is different against cv1800b.
>=20
> CV1812h have a embedded 256MB RAM. The cv1800b is 64MB, This is why the
> size is different. I write this node here because the RAM is embedded
> and fixed size, and leave it in the board DT is unnecessary.
>=20
> >> +
> >> +    soc {
> >> +        interrupt-parent =3D <&plic>;
> >> +
> >> +        plic: interrupt-controller@70000000 {
> >> +            compatible =3D "sophgo,cv1812h-plic", "thead,c900-plic";
> >> +            reg =3D <0x70000000 0x4000000>;
> >> +            interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>;
> >> +            interrupt-controller;
> >> +            #address-cells =3D <0>;
> >> +            #interrupt-cells =3D <2>;
> >> +            riscv,ndev =3D <101>;
> >> +        };
> >> +
> >> +        clint: timer@74000000 {
> >> +            compatible =3D "sophgo,cv1812h-clint", "thead,c900-clint";
> >> +            reg =3D <0x74000000 0x10000>;
> >> +            interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>;
> >> +        };
> >> +    };
> >> +};
> >> --
> >> 2.42.0
> >>
> >

--FbIlMY2V77DRQAG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSe/WQAKCRB4tDGHoIJi
0v+pAP4ikxNXQFMmYKQCRI/ErSVgvlUuINpu2o2hajLuAX07cgEArhvqcOM2wd87
QPOM8fdmk7XQQ2hWX5EpJjl9qMH89gQ=
=JHNn
-----END PGP SIGNATURE-----

--FbIlMY2V77DRQAG0--
