Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A44D80D455
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjLKRnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjLKRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:43:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F42FF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:43:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B47C433C7;
        Mon, 11 Dec 2023 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316603;
        bh=Xrsi+3PuSnsXMklZ6G2qnpKJr2/IDaNfFsWL8VpO5f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBRGtPT1QpzPrQqn9ZWXvcuicsRwZrKH77dTgVAvpBpN800WmF6F/a0YLfAo1tM18
         jmPxjw7FybqnMY3ndobGNTDGZk9mpztbBWbcqscQuuiHVkNQSXnCOuajtRgxpo5fnk
         Qn6I6mujyhKaDRCpZZb60scTr3l/gu2fCXKHCTYNsF5cF0We5DFgfJSfeZPNOxxUPm
         wccJl+Y2tOJmckw26GAH7eJhhiZB58WjBngmy4X4IkcOzBGdXYWT8MW2EPexqCnznY
         wAYRK69areNhIN9DAvtG8qNcqJKG07M4cHKGqTGHfR4Zh/xXXtl0uqg4hZUCVtKoyf
         4jL0V4DHIMObw==
Date:   Mon, 11 Dec 2023 17:43:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Shengyu Qu <wiagn233@outlook.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
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
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: Add initial StarFive JH8100
 device tree
Message-ID: <20231211-vacant-tracing-0f5bfc3b23fd@spud>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
 <20231201121410.95298-7-jeeheng.sia@starfivetech.com>
 <TY3P286MB2611F70A3D61788E556C8A30988AA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <358bcdb3f0ab4a7b9d6bbe17ca1a696d@EXMBX066.cuchost.com>
 <20231211-submerge-vegan-244889f1751c@wendy>
 <b3690246eb1e48428238ceb26b046297@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XS9oPw+vMXVv7R2u"
Content-Disposition: inline
In-Reply-To: <b3690246eb1e48428238ceb26b046297@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XS9oPw+vMXVv7R2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 09:38:03AM +0000, JeeHeng Sia wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor.dooley@microchip.com>
> > Sent: Monday, December 11, 2023 3:59 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: Shengyu Qu <wiagn233@outlook.com>; kernel@esmil.dk; robh+dt@kernel.=
org; krzysztof.kozlowski+dt@linaro.org;
> > krzk@kernel.org; conor+dt@kernel.org; paul.walmsley@sifive.com; palmer@=
dabbelt.com; aou@eecs.berkeley.edu;
> > daniel.lezcano@linaro.org; tglx@linutronix.de; conor@kernel.org; anup@b=
rainfault.org; gregkh@linuxfoundation.org;
> > jirislaby@kernel.org; michal.simek@amd.com; Michael Zhu <michael.zhu@st=
arfivetech.com>; drew@beagleboard.org;
> > devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-kern=
el@vger.kernel.org; Leyfoon Tan
> > <leyfoon.tan@starfivetech.com>
> > Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: Add initial StarFive =
JH8100 device tree
> >=20
> > On Mon, Dec 11, 2023 at 01:38:06AM +0000, JeeHeng Sia wrote:
> > >
> > > > From: Shengyu Qu <wiagn233@outlook.com>
> > > > Sent: Friday, December 8, 2023 8:09 PM
> >=20
> > > > Does the dubhe-80 cores actually support vector? Or vector support
> > > >
> > > > doesn't exist on actual silicon?
> >=20
> > > We don't have a use case for vector application in JH8100
> >=20
> > I am sorry, but I am not clear on what this means. Do the CPUs on
> > the JH8100 support vector or not?
> The JH8100 CPU does not support vector operation.

Thanks for clarifiying.

--XS9oPw+vMXVv7R2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXdKNQAKCRB4tDGHoIJi
0rZPAQCEsghqtswjmJygCWPmWVFvcHsL1UQuaSfdgVrpv2pGKwD+KS8NbHc9i8YD
aj/NuPnffcLulHXB2Efddk4kEgoIdQE=
=tBgs
-----END PGP SIGNATURE-----

--XS9oPw+vMXVv7R2u--
