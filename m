Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5117B0753
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjI0Oww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjI0Owu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:52:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D1F4;
        Wed, 27 Sep 2023 07:52:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E010C433C7;
        Wed, 27 Sep 2023 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695826369;
        bh=KYsU6F1OWipGJBjQhqhwLEtZLYFO0yCsHTzUzpd2p2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEOIaLTaSOlMEI3zbHLgX2Rq9MOxZ1qYbwvuGcXFaqKZjXlwVan4cwG+d++ZTI0fQ
         Robf6HffovF7TGOQUcNoyUDCaTGEc10MKc7xIa+6490fZIs9X//C+CjtJRJTssI4Ej
         Kuc6FMUa2t2Lh8GSL2SztyGeA3f6kmn9wLKwi6jym+xediWk3qdAPNGh0m3GAdx4kg
         MgBx5VXxwCFouYEJBKN+VaXuMx3UcYO+n4wsKFpa55CJe8irhp8yaPQDMv90JS3v99
         mftCUrnL9SyfWQ957hKBmEaneaXlJcBraOKHYaYLLXWYCyvXkWmRCMA1zIuJcUHBR1
         haUDsiQaqrmgw==
Date:   Wed, 27 Sep 2023 15:52:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [-next v1 1/2] dt-bindings: power: Update prefixes for AON power
 domain
Message-ID: <20230927-coma-flashback-07d2e7b34f96@spud>
References: <20230927130734.9921-1-changhuang.liang@starfivetech.com>
 <20230927130734.9921-2-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xGOf7ag5cN9+/+jq"
Content-Disposition: inline
In-Reply-To: <20230927130734.9921-2-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xGOf7ag5cN9+/+jq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 06:07:33AM -0700, Changhuang Liang wrote:
> Use "JH7110_AON_PD_" prefix for AON power doamin for JH7110 SoC.
>=20
> Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  include/dt-bindings/power/starfive,jh7110-pmu.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt=
-bindings/power/starfive,jh7110-pmu.h
> index 341e2a0676ba..7b4f24927dee 100644
> --- a/include/dt-bindings/power/starfive,jh7110-pmu.h
> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
> @@ -14,7 +14,8 @@
>  #define JH7110_PD_ISP		5
>  #define JH7110_PD_VENC		6
> =20
> -#define JH7110_PD_DPHY_TX	0
> -#define JH7110_PD_DPHY_RX	1
> +/* AON Power Domain */
> +#define JH7110_AON_PD_DPHY_TX	0
> +#define JH7110_AON_PD_DPHY_RX	1
> =20
>  #endif
> --=20
> 2.25.1
>=20

--xGOf7ag5cN9+/+jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRBvAAKCRB4tDGHoIJi
0gecAQD3KIdJsVdpHOt1Z0tStNB+PSX9XCQVNaOTNXm6DboR5AEAxVgdVcUs49EP
rivtCK7ZZmaldoxIUnLYA+jEPrzFqQM=
=5LyB
-----END PGP SIGNATURE-----

--xGOf7ag5cN9+/+jq--
