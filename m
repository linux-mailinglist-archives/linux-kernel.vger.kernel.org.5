Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E877E414
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjHPOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbjHPOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582D0268F;
        Wed, 16 Aug 2023 07:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0AA4669F0;
        Wed, 16 Aug 2023 14:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038D9C433C8;
        Wed, 16 Aug 2023 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692197101;
        bh=ugjQhqHLmEDVXEccQlVOVRh5SwCzRAZMzSapMmH9OlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejzyapGBdwIDDaXGBbMFtC5Qw+sa99thGSOO5TByi1AcLV43qnajUZIsPzsAaigyI
         MHvdl8pNZygzhjfXhwgGhfYybb4/P2pDh3OkfWJV4x7zJqsIxp/KnTPXv23ZoMQb/A
         Mc5yArVNks4iZpSoejZxYfI042/Hx7PoQ54BHZ4jgQ91vvH3cT8emw/4hrbZEI+Hl4
         +T8usxYQwgwuyQowG/gekeKeX3FpwyMKSvvhuzX8E+t61TXpTjU3m5ihEX5SV0VQV1
         1fApkosv1EP3ai3bsBQ5bmPrFwaw5/CcFjNv4hgLrylGpciDfWvhOFv9xm0I1KZDiR
         xl7Ucob/x+ixA==
Date:   Wed, 16 Aug 2023 15:44:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mingjin Yang <mingjin.yang@unisoc.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, magicyangmingjin@gmail.com,
        Ling_Ling.Xu@unisoc.com, Jinfeng.Lin1@unisoc.com,
        Yangbin.Li@unisoc.com, Jiansheng.Wu@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V0 1/2] dt-bindings: iio: adc: Add support for ump518
 pmic adc
Message-ID: <20230816-dastardly-escapade-75597e244088@spud>
References: <20230816080225.21482-1-mingjin.yang@unisoc.com>
 <20230816080225.21482-2-mingjin.yang@unisoc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y46xbF1UowmDvRWh"
Content-Disposition: inline
In-Reply-To: <20230816080225.21482-2-mingjin.yang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y46xbF1UowmDvRWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 04:02:24PM +0800, Mingjin Yang wrote:
> Add ump518 pmic adc description and sample in dt-bindings.
>=20
> Signed-off-by: Mingjin Yang <mingjin.yang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml | 2 ++

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.ya=
ml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> index 8181cf9a8e07..f28d188d83da 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
> @@ -21,6 +21,7 @@ properties:
>        - sprd,sc2730-adc
>        - sprd,sc2731-adc
>        - sprd,ump9620-adc
> +      - sprd,ump518-adc
> =20
>    reg:
>      maxItems: 1
> @@ -46,6 +47,7 @@ allOf:
>              contains:
>                enum:
>                  - sprd,ump9620-adc
> +                - sprd,ump518-adc
>      then:
>        properties:
>          nvmem-cells:
> --=20
> 2.17.1
>=20

--y46xbF1UowmDvRWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNzg5wAKCRB4tDGHoIJi
0o3mAP9lfznoeS5TI6minXIn7I72U4YDoOoWD9+AGj7r/cVmagD/bH/bc1NYcQWw
GmGzkM1Oy7CEMFcEtNtdPA/vuWHxOAU=
=JbvI
-----END PGP SIGNATURE-----

--y46xbF1UowmDvRWh--
