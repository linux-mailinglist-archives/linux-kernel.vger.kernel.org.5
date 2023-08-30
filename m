Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5878DE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbjH3TFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbjH3Gva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:51:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13CD194;
        Tue, 29 Aug 2023 23:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693378287; x=1724914287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iJiqQM/21AbbfFTBJGuHIq/kCZ7VDhCQMZ/MLtlN5jI=;
  b=KFPUYuEA6zBCEdE2XJdykEejjZAAF+U6jRoxYSIA8dd/qs7YrTjC0Zp0
   qoJWG+K63BCw/4Xk6wf6DrOkfoqouQU1xWY0a/klgS8g/O/78QaXFU6Ae
   IQo14RlhSyYciqUSrJRfgXc8ZOk3BCnHul8TvcCXAwq/PDz4syfLy2HvE
   yHN/E8C/D59rAem1yog3khS7g+hHppZDXVl5JrcAJJh23GOYoa2PZoIoC
   Y+Bt+0nfcLfqC5TROkZUFjYX5xIJqg8lwShaz90KaAamvqtEMHIMtnoQh
   unAKrwg8vau74I4ObwcfgDPILDKVRoSnhSjNOGMkjKZfawy0lGeM7n2GY
   w==;
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="asc'?scan'208";a="169011728"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2023 23:51:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 29 Aug 2023 23:51:22 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 29 Aug 2023 23:51:20 -0700
Date:   Wed, 30 Aug 2023 07:50:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     William Qiu <william.qiu@starfivetech.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Drop unused properties
Message-ID: <20230830-commence-trickery-40eaa193cb15@wendy>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
 <20230830031846.127957-2-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VGI59nk8mzz/pDkD"
Content-Disposition: inline
In-Reply-To: <20230830031846.127957-2-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--VGI59nk8mzz/pDkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 11:18:44AM +0800, William Qiu wrote:
> Due to the change of tuning implementation, it's no longer necessary to
> use the "starfive,sysreg" property in dts, so drop the relevant
> description in dt-bindings here.

How does changing your software implantation invalidate a description of
the hardware?

>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../bindings/mmc/starfive,jh7110-mmc.yaml         | 15 ---------------
>  1 file changed, 15 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.ya=
ml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> index 51e1b04e799f..10df41941331 100644
> --- a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> @@ -36,26 +36,12 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> -  starfive,sysreg:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> -    items:
> -      - items:
> -          - description: phandle to System Register Controller syscon no=
de
> -          - description: offset of SYS_SYSCONSAIF__SYSCFG register for M=
MC controller
> -          - description: shift of SYS_SYSCONSAIF__SYSCFG register for MM=
C controller
> -          - description: mask of SYS_SYSCONSAIF__SYSCFG register for MMC=
 controller
> -    description:
> -      Should be four parameters, the phandle to System Register Controll=
er
> -      syscon node and the offset/shift/mask of SYS_SYSCONSAIF__SYSCFG re=
gister
> -      for MMC controller.
> -
>  required:
>    - compatible
>    - reg
>    - clocks
>    - clock-names
>    - interrupts
> -  - starfive,sysreg
> =20
>  unevaluatedProperties: false
> =20
> @@ -73,5 +59,4 @@ examples:
>          fifo-depth =3D <32>;
>          fifo-watermark-aligned;
>          data-addr =3D <0>;
> -        starfive,sysreg =3D <&sys_syscon 0x14 0x1a 0x7c000000>;
>      };
> --=20
> 2.34.1
>=20

--VGI59nk8mzz/pDkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO7mswAKCRB4tDGHoIJi
0j0ZAPoD8g3POZOxVjU8MHAqAQsVrGSXh9a5G6ibHoCJuX5zqQD+OwU3VEu8ihr1
DsPdiiCV8fgivVirHHYW8sFlFgF+jQg=
=iZHY
-----END PGP SIGNATURE-----

--VGI59nk8mzz/pDkD--
