Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25F7FDB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjK2Pfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbjK2Pfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:35:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7075FD48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:36:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56302C433C8;
        Wed, 29 Nov 2023 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701272160;
        bh=TB30gWWXrXlW77SxxhSjBq16m86w+0vce8gY0Rpmi80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7sbSfysXpySoYJ6RtGsSfSc+clUUisZT2uFvsG+4bUESYF5qLB7/b0KSg5nYsBVE
         weDI6hIirRHXriOHF4YNM+2I9+Cxof3qAY7x0j+7aCII04l87Sl+28uG4q3YZgx0C0
         MRRO4vVi60QfkjAmL1QGYzktXsDz6U07khn5iEYbntI0MymLAxVnGJl/iezqhZ/tUk
         ZzJ+CzH2kku72+5SM+MpX4p9WjKXGvNGn8vfcvRAyrr8JggmeI/V7ufvDusMUgotAr
         396c79rGTpcDuAFp4nEkz1U0TMhA1uNo/xcoDcInnyhiZ58c2ePFWwZLhj3AnQO3E9
         aAE7vIeVCoWLA==
Date:   Wed, 29 Nov 2023 15:35:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH 3/5] arm64: dts: ti: k3-j7200: use ti,j7200-sci compatible
Message-ID: <20231129-reverse-numbness-63986443703f@spud>
References: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
 <20231129-j7200-tisci-s2r-v1-3-c1d5964ed574@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HgCRekJUlEVPbssQ"
Content-Disposition: inline
In-Reply-To: <20231129-j7200-tisci-s2r-v1-3-c1d5964ed574@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HgCRekJUlEVPbssQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 04:31:19PM +0100, Thomas Richard wrote:
> On j7200, suspend to ram poweroff the SOC.
> This compatible restores irqs at resume.
>=20
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64=
/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 467970fab3a0..d8dc1421e75e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -7,7 +7,7 @@
> =20
>  &cbass_mcu_wakeup {
>  	dmsc: system-controller@44083000 {
> -		compatible =3D "ti,k2g-sci";
> +		compatible =3D "ti,j7200-sci", "ti,k2g-sci";

This is not what your dt-binding change allows. Did you test this with
dtbs_check?

--HgCRekJUlEVPbssQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdaWgAKCRB4tDGHoIJi
0l3YAP44nO/sx6rPYRmv02kTSOn0PXi5g8rRrqg5Xzr365uaDQEAyc5SO5UxMzCN
O+A54etEvUvBVRNVKRtCOdfy76AzZQU=
=9RnY
-----END PGP SIGNATURE-----

--HgCRekJUlEVPbssQ--
