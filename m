Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267076DFF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjHCF7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHCF7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:59:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF0AE6F;
        Wed,  2 Aug 2023 22:58:58 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3735whoB028843;
        Thu, 3 Aug 2023 00:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691042323;
        bh=2w45c6TKaLh8V9z2602POyKiePKxK2Y8Q2IsHVVY/3I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lBRlO3RSuBs668NpLgrrezkzLwoelA8ZSc0PKF3y2+kBax985EByj+3fu7D7kgB+X
         /fDk0Ql1QjskF8J9APk3J0qEUCJvy3Cx0T2HOYeQsY2+P77k2Pe2GcPARLUsvNdXB/
         uPKXmPCffLgz7f6cTJLOd9px5O3UCpa/qhsV1ZVk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3735wh25004226
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 00:58:43 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 00:58:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 00:58:43 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3735wgO6015429;
        Thu, 3 Aug 2023 00:58:42 -0500
Date:   Thu, 3 Aug 2023 11:28:46 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: ti: k3-am62x: Enable AUDIO_REFCLKx
Message-ID: <mhz63eszfuovzbrbzconkazzt3xvwtlko3nej7saimrilyfrm5@ok2kkggbapyi>
References: <20230731142135.108477-1-francesco@dolcini.it>
 <20230731142135.108477-2-francesco@dolcini.it>
 <itvg2zmmapbfmgbwos6c4y5zsc2rb3sffv2znhwz6i2vahe4y6@uu2547kcz5sd>
 <23C6E13C-3F10-490B-A18E-C67B91CBAF35@dolcini.it>
 <20230802133244.b66pg3mztotgqotm@steerable>
 <ZMpc7x8U91JLVakd@francesco-nb.int.toradex.com>
 <20230802140020.k233zqpjar5ag4iv@outbreak>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vphmbkt4zdnaykea"
Content-Disposition: inline
In-Reply-To: <20230802140020.k233zqpjar5ag4iv@outbreak>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--vphmbkt4zdnaykea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nishanth, Francesco,

On Aug 02, 2023 at 09:00:20 -0500, Nishanth Menon wrote:
> On 15:41-20230802, Francesco Dolcini wrote:
> > On Wed, Aug 02, 2023 at 08:32:44AM -0500, Nishanth Menon wrote:
> > > On 13:37-20230802, Francesco Dolcini wrote:
> > > > Il 2 agosto 2023 13:23:50 CEST, Jai Luthra <j-luthra@ti.com> ha scr=
itto:
> > > > >On Jul 31, 2023 at 16:21:32 +0200, Francesco Dolcini wrote:
> > > > >> From: Jai Luthra <j-luthra@ti.com>
> > > > >>=20
> > > > >> On AM62-based SoCs the AUDIO_REFCLKx clocks can be used as an in=
put to
> > > > >> external peripherals when configured through CTRL_MMR, so add the
> > > > >> clock nodes.
> > > > >>=20
> > > > >> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > > > >> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > >> ---
> > > > >>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 18 ++++++++++++++++=
++
> > > > >>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++=
++
> > > > >
> > > > >Given currently none of the AM62A boards are using the refclks, ca=
n you=20
> > > > >drop those or just mark the nodes as disabled. Whoever is the firs=
t user=20
> > > > >can enable them.
> > > >=20
> > > > I can drop the 2 clocks from AM62A, however, should we really do it?
> > > > These clocks exist and they are just defined in the DTS, they are
> > > > not going to be enabled if not used, "ti,am62-epwm-tbclk" is also
> > > > not disabled for example.
> > >=20
> > > Overall, the SoC clock as such has nothing to do with board specific,=
 so
> > > leave it default (enabled) in SoC.dts - just want to make sure that t=
he
> > > clk-parent selection doesn't get in the way of platforms and is a sane
> > > default.
> >=20
> > When I looked into that, months ago, this looked to me the correct and a
> > sane default. I had the same in our downstream way before the addition
> > from Jai Luthra to the SoC dtsi.
> >=20
> > Not sure if Jai can add more on that regard.
> >=20
> > > pll2_hsdiv8 output - which looks like the default mux value anyways..
> > > I am ok for it being explicit, but wondering if that works for boards
> > > that do not use this default.
> >=20
> > IFF needed, it would be very easy to just override from the board dts,
> > using the labels that are already there (audio_refclk0, audio_refclk1).
>=20
> Jai: This sounds sane to me, if you are OK as well, I'd appreciate a revi=
ewed-by
>=20

Makes sense, most external peripherals would prefer that default PLL as=20
parent - for other usecases what Francesco said can work.

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> >=20
> > > (sidenote): Fransesco - your new mail client has line wrap issues ;)
> > Yep, I had the crazy idea to reply from my mobile phone while having a
> > walk. It's already a success that I did not top post ;-)
>=20
> hehe ;)
>=20
> --=20
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--vphmbkt4zdnaykea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTLQhUACgkQQ96R+SSa
cUWv3g//Up4niurohAiYtx6RDrADpMcBRcNofI20ZBpN05GAEi9Rku4Ht1G52l0L
9mOC2nxhzJnBAPfFb8MaUHnD8eov0qb63+KorZwRz58/nwygedyIKAM1GYcAI7NY
t/p7nLgjenWbRRkEtX1ARpNcKou6zzIgy5n9EkLj+y3FQwNHHlkJIRVCKTuqwt4r
9h7o0DKCfNCXljjFlgYe/1sn617KMkfDUkelafKSTXd+PvblKEqvqO6ECrYB1VvT
7jBg491dE6DYayKcKKDGobtW0HUy8ex1GUsCNjyF1cgxVWsdg6l+JNCzMdeoENA8
5nrofUTZURg3M8i9siLtEVua2ygT0GxBf1oP3E+iOFdEpvq3I9lpySffsCM9ZX1R
DBUV26P5zSdJQ8lvNnJcMV7nyR8ve7oEFx9a2OAx5MGpvYXS2IeRunPDGZ3SGbA+
O73xaAKZOl1d4m+GIXxvRFqdJBUh0NBEh+Z2HJYzPDvU1fpcYco1OnCLLTQk7BaA
l8MyEhaLtx+BAow0dS7ZOSzM8KXxuYt2LbWY5oWA8aeV4xQOM69cJ6n1TZF+HmdO
seEofIjChxMxzkdTq9s1Dhp7zi/rVm4TCxV4uC3jfGU5h2KkM6HwuQn0Ani3k9eP
W257rnY1+LrDShBddHDNgymUmxuLiUsboIKbJLVnsYABi4R7OFM=
=Q0iI
-----END PGP SIGNATURE-----

--vphmbkt4zdnaykea--
