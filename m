Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2547774A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjHHUbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjHHUbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67A59D5;
        Tue,  8 Aug 2023 09:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E5F4624A8;
        Tue,  8 Aug 2023 10:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2916DC433C7;
        Tue,  8 Aug 2023 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691491590;
        bh=5/vplBpZWRwEXtxAuo+0mchoMiagOLKKpHiTNDbEBww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kssHiHS1t8J2pe2+B38xLRV3R7yKgOPAtYndtLmJ6DF9MGV8fP7DlzArGy22/5xe5
         h60Xn8RnUAwTcHafxwo3aq9JrJLam+Xzdw25HRoelZd9QYjzsEl8oYaIyNvYNLJm3f
         kK9L23khONgms8NuESWXwvCqrhIISx0lFw8qW3g9NtoJFQvICWnPwdFbbzkuRD7SGG
         zMd0Eo+cmO5t8YQLWmHnmbT393YETR2YT5f1zK8BydSkV+gIJMz2KIqfmqmXULQrik
         XCJcpCcGB24/rTcNFSv+dVy3i6VOobzzQZzUImxX6h+gO9ANJ3KXYHKXZ+p1yVLBZR
         TacytRr2qkxDg==
Date:   Tue, 8 Aug 2023 11:46:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
Subject: Re: [PATCH v4 3/8] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
Message-ID: <20230808-quizzical-footwork-4846d6461f74@spud>
References: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
 <20230807-pxa1908-lkml-v4-3-cb387d73b452@skole.hr>
 <20230808-equator-professor-fcc4564b4ef5@spud>
 <2155917.irdbgypaU6@radijator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RztoMnfb+8mn952S"
Content-Disposition: inline
In-Reply-To: <2155917.irdbgypaU6@radijator>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RztoMnfb+8mn952S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 12:41:22PM +0200, Duje Mihanovi=C4=87 wrote:
> On Tuesday, August 8, 2023 9:49:49 AM CEST Conor Dooley wrote:
> > On Mon, Aug 07, 2023 at 05:42:37PM +0200, Duje Mihanovi=C4=87 wrote:
> > > diff --git a/include/dt-bindings/clock/marvell,pxa1908.h
> > > b/include/dt-bindings/clock/marvell,pxa1908.h new file mode 100644
> > > index 000000000000..0c1f328bf534
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/marvell,pxa1908.h
> > > +#define PXA1908_CLK_PLL4VCODIV3		38
> > > +#define PXA1908_MPMU_NR_CLKS		38
> > >=20
> > > +#define PXA1908_CLK_TWSI3		18
> > > +#define PXA1908_APBC_NR_CLKS		50
> > >=20
> > > +#define PXA1908_CLK_AICER		3
> > > +#define PXA1908_APBCP_NR_CLKS		50
> > >=20
> > > +#define PXA1908_CLK_DVC_DFC_DEBUG	16
> > > +#define PXA1908_APMU_NR_CLKS		50
> >=20
> > How are these "NR_CLKS" things helpful to the binding?
>=20
> They are used by the clock driver when calling mmp_clk_init which then us=
es=20
> that as the size of a struct clk array it allocates. In retrospect, 50 fo=
r=20
> each block may be too much as from what I can tell by reading the=20
> mmp_register_* functions (number of clocks + 1) for each block should be=
=20
> enough, anything less than that causes a null pointer dereference sometim=
e=20
> during clock initialization.

I think you might have misread my question, I'm not really interested in
the implementation detail of the driver. If these are not used in
devicetree, remove them - otherwise they are being needlessly added to
the ABI.

--RztoMnfb+8mn952S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIc/wAKCRB4tDGHoIJi
0vvfAQCUBVx+dfC3x4h3dtSQuScpZW8E7hwenEjgq15lYWMiRwEAqp39VWkBj/XW
LQARrUdP4b6MTYsXWU2u/v2O1qsoigA=
=ZFJc
-----END PGP SIGNATURE-----

--RztoMnfb+8mn952S--
