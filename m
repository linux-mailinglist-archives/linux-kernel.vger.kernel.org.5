Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7181164F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442602AbjLMPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442578AbjLMPYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:24:38 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B45EB2;
        Wed, 13 Dec 2023 07:24:44 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDFOOhR057528;
        Wed, 13 Dec 2023 09:24:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702481064;
        bh=T9KvZybSUurSCcBz692zhDrnpzA6GAPrjsoLQcyT7CY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Cw1wIfRo2IYkiV/LN7FqjP1j9zfI2R5OPbFfNp9nslwi+6f16dC1mIAOCDtsm3LLk
         +ioe42+Q45CcvCbCfO4ebxD7AU8j6WfRXOCDtVaOVc+mCe4ghqvbk7AjFts7D3201b
         TmDmV+W1Fgs95SaeZ35CF0wU2RymebkxxrCIYbTA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDFOOpU122688
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 09:24:24 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 09:24:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 09:24:23 -0600
Received: from localhost ([10.250.64.83])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDFOMBp108038;
        Wed, 13 Dec 2023 09:24:23 -0600
Date:   Wed, 13 Dec 2023 20:54:21 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     "Raghavendra, Vignesh" <vigneshr@ti.com>
CC:     "Menon, Nishanth" <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: k3: Add additioal regs for DMA
 components
Message-ID: <ve2zjmq3adj6v4vqeecitvad2ndlzxsldu2wdpqh6e4xdb3cqs@xvwwbzqq5avr>
References: <20231213135138.929517-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ynjgdttbw44iiykq"
Content-Disposition: inline
In-Reply-To: <20231213135138.929517-1-vigneshr@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ynjgdttbw44iiykq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vignesh,

On Dec 13, 2023 at 19:21:35 +0530, Raghavendra, Vignesh wrote:
> This adds additional reg ranges which are not directly used by Linux but
> by other components like U-Boot
>=20
> Binding is accepted via dmaengine tree and is in linux-next[0]
>=20
> [0] https://lore.kernel.org/dmaengine/170083278148.771517.184188915617441=
3563.b4-ty@kernel.org/
>=20
> v2:
> Extend register ranges to match TRM as pointed out by Jai

For the series,

Reviewed-by: Jai Luthra <j-luthra@ti.com>

>=20
> v1: https://lore.kernel.org/linux-arm-kernel/20231212111634.3515175-1-vig=
neshr@ti.com/
>=20
> Manorit Chawdhry (2):
>   arm64: dts: ti: k3-am65: Add additional regs for DMA components
>   arm64: dts: ti: k3-j7*: Add additional regs for DMA components
>=20
> Vignesh Raghavendra (1):
>   arm64: dts: ti: k3-am6*: Add additional regs for DMA components
>=20
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 18 ++++++++++++++----
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 18 ++++++++++++++----
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi      | 18 ++++++++++++++----
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 18 ++++++++++++++----
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  8 ++++++--
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        |  8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi      |  8 ++++++--
>  .../arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi      |  8 ++++++--
>  .../arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi     |  8 ++++++--
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi      |  8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi     |  8 ++++++--
>  .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi      |  8 ++++++--
>  14 files changed, 116 insertions(+), 36 deletions(-)
>=20
> --=20
> 2.43.0
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--ynjgdttbw44iiykq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmV5zKQACgkQQ96R+SSa
cUWDpw/+K2gkDVe251nUUQVkxsTUiQaOrJVXMhPKaPwTdDt1NRtDYEYJORU0EUw8
VtiPYUkBL2udKOJpdelOtmlR2OYkiL6kIts0+hRP59W0CfKWV1qbqWvJL27+oibo
ULLwYfAPuMb7FLFdC2DswMRc8j8iyG6ph0I/wOp7hyT/rKhShea6ciX2CyZVsSpj
OZdqVh6gf4NlnB3ei0fzrBFJMp7SJN1Z76N1ddGVM30e/85U23gtsM8NT0PGESoM
73npJQ3SlRzHbOpospvql+jm3f5RH4sQ0uUIVc5h4WmCK1PfmE5DR8/ojIOExddD
kJiHTTP9U5njpGhomIi+/eM6c3NmGg649eMr4BvRaRGA0jL6x3avwIdXGeXq+xIB
+wvh8GQPAgyMG+VrZ6YJ/On8JNqqDGKIznPybqClKb0+5uaPWuQeQY/RC6I3Jkhn
mFX/fSh+LfViPX4+3eng7Fm+zsqnjCu+S6qR5lpd1UNV0UNovnMro7b76H6ayA0G
v6wj4Do70sYgWtFLMc+qbWZ9SH9ZVVREa0VtwdOw9jioTaaYuvcM5hadc1lray/n
dnK7+WU1TD1z6x6ixXfPF9E3mMn8XSk3p0voo0ANgQRuJGPQxJ9RkcS5MZJanPWN
QDwqC+slUEzrPZX86FcGX8hULBNtYwB1Ax720uCjztNs5cNw5gA=
=qXSX
-----END PGP SIGNATURE-----

--ynjgdttbw44iiykq--
