Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830F1813616
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjLNQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLNQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:22:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F1BE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:22:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E424EC433C8;
        Thu, 14 Dec 2023 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702570956;
        bh=OMKVLv9NYzhuXYvDBlUO7M+vxpTr7gLzVqD9Q0PQcIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=stjZi4UCT11AygYn1GChVhEvqQTM3fNvheYZz3LHZGZ9HTKo2sjML7eLHMDrBOLaI
         vCixHOyPXvKnNUOtaVR9qUcMqXyCoXe5LPJrfk9R7UdN4RWNuaArx6zhv19JmTnggd
         I2rwJZEv8VltqXZaR4GQIkz5a78aOXYWi1GlZqrL+bW4H1I0I00B+qN1uePGJVb5US
         j2DmYClWJH2DfHlt2SnqJpmPF+GT5eKEs522NTiyRAWk58ze/dB37FeAPeuNLlPxM4
         rWfXg2YQnux5pYfakB0kNae6Rebj7iBf62T7a8YsMwlJBhGlP1xuDnv24x9C2bPrTE
         ytbJyAPXGwB9w==
Date:   Thu, 14 Dec 2023 16:22:29 +0000
From:   Conor Dooley <conor@kernel.org>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     "kernel@esmil.dk" <kernel@esmil.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
Message-ID: <20231214-platonic-unhearing-27e2ec3d8f75@spud>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
 <20231201121410.95298-3-jeeheng.sia@starfivetech.com>
 <20231213-imminent-favorable-a7d25e6555af@spud>
 <f6665b5c235148279104c4c3fa9ff080@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i1pQ8XIdCyW9abGP"
Content-Disposition: inline
In-Reply-To: <f6665b5c235148279104c4c3fa9ff080@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i1pQ8XIdCyW9abGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:36:57AM +0000, JeeHeng Sia wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Wednesday, December 13, 2023 8:43 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: kernel@esmil.dk; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.=
org; krzk@kernel.org; conor+dt@kernel.org;
> > paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; da=
niel.lezcano@linaro.org; tglx@linutronix.de;
> > anup@brainfault.org; gregkh@linuxfoundation.org; jirislaby@kernel.org; =
michal.simek@amd.com; Michael Zhu
> > <michael.zhu@starfivetech.com>; drew@beagleboard.org; devicetree@vger.k=
ernel.org; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Con=
or Dooley <conor.dooley@microchip.com>
> > Subject: Re: [PATCH v3 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
> >=20
> > On Fri, Dec 01, 2023 at 08:14:06PM +0800, Sia Jee Heng wrote:
> > > Add device tree bindings for the StarFive JH8100 RISC-V SoC.
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/starfive.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/=
Documentation/devicetree/bindings/riscv/starfive.yaml
> > > index cc4d92f0a1bf..12d7844232b8 100644
> > > --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > > @@ -30,6 +30,10 @@ properties:
> > >                - starfive,visionfive-2-v1.3b
> > >            - const: starfive,jh7110
> > >
> > > +      - items:
> > > +          - enum:
> > > +              - starfive,jh8100-evb
> >=20
> > Hmm, reading some of the other threads it appears that the evaluation
> > platform that you guys have is actually just an FPGA? Could you please
> > provide more information as to what this "evb" actually is?
> >=20
> > If it is just an FPGA-based evaluation platform I don't think that we
> > want to merge patches for the platform. I'm fine with patches adding
> > peripheral support, but the soc/board dts files and things like pinctrl
> > or clock drivers I am not keen on.
> > Perhaps Emil also has an opinion on this.
> Eco the same reply here. I am not sure what you mean. We verified on FPGA=
 & Emulator,
> and the logic is pretty much close to the real silicon.

"Pretty much close" That doesn't give me confidence. The compatible
should uniquely identify an SoC, but if it is used for both the actual
SoC and for something "pretty much close" to the actual SoC then that
does not hold.

> I did mention that in the cover letter as well.

Ah apologies for missing that. I try to read cover letters but the
volume of mail gets to me at times.

> I am new to Linux, so I am wondering if there is a Linux upstream guideli=
ne mentioning
> that pre-silicon software is not allowed to upstream?

I wouldn't say that this is the case, but things like clock and pinctrl
drivers are the sort of things that are likely to vary in your "pretty
much close" as that is the kind of thing that change for your final
integration, versus a more "standalone" peripheral.

For dts stuff, in RISC-V at least, we've been operating so far on the
basis that systems implemented entirely on an FPGA are not suitable for
inclusion in mainline. I would say that this can probably be relaxed to
allow systems where there are publicly available, versioned, designs or
bitstreams that are widely used that these devicetrees correspond to.
This would suit something like if AMD published a bitstream using one
of their new MicroblazeV cpu cores as a sort of "reference design".

> Hope there is an updated Linux
> upstream guideline that benefit other vendors.

I have no idea if there is one or not. I think it generally varies on
individual maintainers etc, and for something like a dts it comes down
to the platform maintainer (Emil) I suppose. Sending stuff out before
your SoC has been produced is really great though, so it is a fine line
to avoid discouraging something we really like to see.

Cheers,
Conor.

--i1pQ8XIdCyW9abGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsrxQAKCRB4tDGHoIJi
0uK+AQC2DmGOWd1dZ0NqujXAEMZ7V/aeOWxTvJb3NvzYserHSgEA+qqzaBqI+4z6
fZ+r3FZkfxYU9XjFsStLKJA6ZdgoSwU=
=qiyL
-----END PGP SIGNATURE-----

--i1pQ8XIdCyW9abGP--
