Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FCF76CB93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjHBLQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjHBLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:16:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99B1FC3;
        Wed,  2 Aug 2023 04:16:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372BGZ4h099845;
        Wed, 2 Aug 2023 06:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690974996;
        bh=dA5RxQddgmoHgqxapVhMN1ewA+RvrGC2OtgpFqYiw58=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XmCqmSfDLKe0SuJwkNAqPrXtHDvDSyToNPbQz9g3pIFLWJqfytbbt7aoWkz8yuZqs
         M59p9vKKdyyFaYNKGHK6gktYIcntzOkKjig0ASg5+PtidH6gyvG2VgIkJDoHgEwCM3
         /IrIKR2Ksyqdwsa3t0XM1B7Qwf5WhjexHnKxeP4A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372BGZ2h010525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 06:16:35 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 06:16:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 06:16:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372BGYKB058312;
        Wed, 2 Aug 2023 06:16:35 -0500
Date:   Wed, 2 Aug 2023 16:46:38 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] arm64: dts: ti: verdin-am62: Set I2S_1 MCLK rate
Message-ID: <25gzvxuvow6py4hqmzjtjvmvlnub6njvmwg5sco5nxcgrsik7c@dd5fbw7x64dv>
References: <20230731142135.108477-1-francesco@dolcini.it>
 <20230731142135.108477-3-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pxudfu2l4nzx3zdm"
Content-Disposition: inline
In-Reply-To: <20230731142135.108477-3-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pxudfu2l4nzx3zdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

On Jul 31, 2023 at 16:21:33 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Set AUDIO_EXT_REFCLK1, used as I2S_1_MCLK on Verdin AM62 family, to 25MHz
> (this is the only valid option according to TI [1]).
>=20
> [1] https://e2e.ti.com/support/processors-group/processors/f/processors-f=
orum/1188051/am625-audio_ext_refclk1-clock-output---dts-support/4476322#447=
6322
>=20
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot=
/dts/ti/k3-am62-verdin.dtsi
> index 57dd061911ab..b686a1caeec4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -758,6 +758,11 @@ AM62X_MCU_IOPAD(0x0028, PIN_OUTPUT,       0) /* (C5)=
 WKUP_UART0_TXD  */ /* SODIM
>  	};
>  };
> =20
> +/* VERDIN I2S_1_MCLK */
> +&audio_refclk1 {
> +	assigned-clock-rates =3D <25000000>;
> +};
> +
>  &cpsw3g {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_rgmii1>;
> --=20
> 2.25.1
>=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--pxudfu2l4nzx3zdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTKOxMACgkQQ96R+SSa
cUVq5A//aM2cY6IXlhadBs3UdlxeuNdnWPBPazxachXyCrJXWKM1jmzNXCTazIAf
GIUS3Jl2mEbx34SWJB1fhm1EwksvznwNqfpKB5gcJfFBgQCd4p9Si/7QYk8c0DiO
3jzABQPb7q7MnDH5rhyLvAvSSWoEIyB6yZw7vKwtqfmMVW9CzRTdaBvdR0kJU79h
yqsWq21GnnBCb+OaJ2LHoEFkzbPGqTFggpAJX9cYUEhGFax9KxySMUEP6puCykSB
spAWAZwlGL2SAy2uSoOqfX6JzTLCCCyq/JdU/wwiSOnuToc3QIHj86OyjrKVZjeE
GxnqVK45X96fBjWwOmfj1b6SxADq+cS4XX4lYIbpTkjtZDkyHhqm9BjhmKtREyDk
zc39jhxFeptSovxFL5kwVGZ6WdTtrVRxNY1i9GNiFJEzjAFjvukgdoED4SEEWgk/
zymmhBo6Y7EKN4MzslePI0uzagguE2xWSP3nSNSuRDx0/pjLe8vihlYFzRzLSwXZ
HoURec7lmkGyQMWBWw7qCgILe4fH336Ya2JtKnsngX7tCK1pzSIYkp2oNYY5cVDc
sVJE0DtlhnY0k7YNxYrAhAL0TH/Z24xRCjoeaIZ/7ixcdp+JkcVkrTzvTEJBcAcB
Wd1abI1swt7lWQJyW+KoCL8cw13HCHf1WE/r6k6bWyhzTNkp1/Q=
=JKZa
-----END PGP SIGNATURE-----

--pxudfu2l4nzx3zdm--
