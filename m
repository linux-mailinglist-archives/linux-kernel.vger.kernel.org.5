Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7D7FF334
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346149AbjK3PIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjK3PIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:08:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F5C10E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:08:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7266C433C9;
        Thu, 30 Nov 2023 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701356904;
        bh=4wdwU/K0jATvkk/atcXZBxJh/WUP8EwtMGcCyE3gUeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlHuYFHTFVwq14ftdT6EnINBJeymXG/v3mOua2ezi5Xn/8MOP4eKlziMM0025U0YI
         ra36o/EOTsrXsl8qcps/T5RVOwYVRMyza/+yoaqHCwulQLvtj8dtfItbvbGz2esLai
         fa7POSmXASjbbjoANg+BhDbI0y4tDdbinq4LWgosoNxTeY9+34QySmeX9nvnAwtStF
         ZGrJM8vMgJ5R7mOk69Sr4eldKQ53rk89r6RtuB1G6Xujb1UPPtMoLzQT2dvnQSJEkO
         A8//ahSoj8QrVQAqRhl5o9O+oV8qY6oQK+tIEsyhYK12enynYWXwK47t9X4FuDsJjy
         e8I/Yki3ksb+Q==
Date:   Thu, 30 Nov 2023 15:08:18 +0000
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
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: riscv: Add StarFive Dubhe compatibles
Message-ID: <20231130-maturely-avert-e1dc87b36bbd@spud>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-2-jeeheng.sia@starfivetech.com>
 <20231129-revisit-prefix-5327168e91f3@spud>
 <08daada77b3e40049ef83f4eb762240c@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RhPgo4Il/hPk7nxW"
Content-Disposition: inline
In-Reply-To: <08daada77b3e40049ef83f4eb762240c@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RhPgo4Il/hPk7nxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 06:04:51AM +0000, JeeHeng Sia wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Wednesday, November 29, 2023 10:46 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: kernel@esmil.dk; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.=
org; krzk@kernel.org; conor+dt@kernel.org;
> > paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; da=
niel.lezcano@linaro.org; tglx@linutronix.de;
> > anup@brainfault.org; gregkh@linuxfoundation.org; jirislaby@kernel.org; =
michal.simek@amd.com; Michael Zhu
> > <michael.zhu@starfivetech.com>; drew@beagleboard.org; devicetree@vger.k=
ernel.org; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>
> > Subject: Re: [PATCH v2 1/6] dt-bindings: riscv: Add StarFive Dubhe comp=
atibles
> >=20
> > On Wed, Nov 29, 2023 at 02:00:38PM +0800, Sia Jee Heng wrote:
> > > Add new compatible strings for Dubhe-80 and Dubhe-90. These are
> > > RISC-V cpu core from StarFive Technology and are used in StarFive
> > > JH8100 SoC.
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Docu=
mentation/devicetree/bindings/riscv/cpus.yaml
> > > index f392e367d673..493972b29a22 100644
> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > @@ -48,6 +48,8 @@ properties:
> > >                - thead,c906
> > >                - thead,c910
> > >                - thead,c920
> > > +              - starfive,dubhe-80
> > > +              - starfive,dubhe-90
> >=20
> > s goes before t.
> Noted. Will fix it.

With the re-order,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--RhPgo4Il/hPk7nxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWilYgAKCRB4tDGHoIJi
0iCtAP4nKPPe89Aie1cg6UtOVOK8OT9ZB+Xb/O+6Am1DPsGhWwEA5igg7/ujUZcP
J8H/nEGTpT7wdjwt5SqaGwLxKfGUNwA=
=R4A9
-----END PGP SIGNATURE-----

--RhPgo4Il/hPk7nxW--
