Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2257CFC11
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjJSOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjJSOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:07:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA5B0;
        Thu, 19 Oct 2023 07:07:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA4EC433C8;
        Thu, 19 Oct 2023 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697724451;
        bh=NQnMTo4gBloKEhDr5l90XulgIfvK7m0vwuYrC+Nvl1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9KWOarV2VoknsUXWkEgd+i6FlARz8FGvhdRBObmNgR6f76TB4RbhtWoN1F6nZGkZ
         864CKmYnJhl7PKV3a/xe8fpBhr55nxtliALOQSvsbJCG63enwySG1otQYoUH2jO7HO
         FvTacIEi0q9ppSklhF5Vq+nH2cfFnVfyZkwZNYUhmVp8WAhjUN0yPNgh+6Zv2UFW2M
         NZ1OIF+Ug5EFpp5Lcm+AQWTbL3xVE/o2d0Nj2vpW9/rLUh+P1HVKsTB0pjlTEN1CyI
         wuNdCPxQg2rv1+eOraih+5eM8+2FCFYs9KdChUZCWwwciMnsyBXYFoX1qwD1dgrvsp
         3JoNMTfJeaX/g==
Date:   Thu, 19 Oct 2023 15:07:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com, kernel@sberdevices.ru,
        rockosov@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v2 10/11] dt-bindings: leds: awinic,aw200xx: add AW20108
 device
Message-ID: <20231019-marbles-resample-1619cef50e07@spud>
References: <20231018182943.18700-1-ddrokosov@salutedevices.com>
 <20231018182943.18700-11-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="83e25rSk0iUnOhmA"
Content-Disposition: inline
In-Reply-To: <20231018182943.18700-11-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--83e25rSk0iUnOhmA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 09:29:42PM +0300, Dmitry Rokosov wrote:
> From: George Stark <gnstark@salutedevices.com>
>=20
> Add aw20108 compatible for Awinic AW20108 led controller.
>=20
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/leds/awinic,aw200xx.yaml          | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b=
/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> index ee849ef3236a..efb18ddce383 100644
> --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> @@ -10,15 +10,16 @@ maintainers:
>    - Martin Kurbanov <mmkurbanov@sberdevices.ru>
> =20
>  description: |
> -  This controller is present on AW20036/AW20054/AW20072.
> -  It is a 3x12/6x9/6x12 matrix LED programmed via
> -  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> +  This controller is present on AW20036/AW20054/AW20072/AW20108.
> +  It is a 3x12/6x9/6x12/9x12 matrix LED programmed via
> +  an I2C interface, up to 36/54/72/108 LEDs or 12/18/24/36 RGBs,
>    3 pattern controllers for auto breathing or group dimming control.
> =20
>    For more product information please see the link below:
>    aw20036 - https://www.awinic.com/en/productDetail/AW20036QNR#tech-docs
>    aw20054 - https://www.awinic.com/en/productDetail/AW20054QNR#tech-docs
>    aw20072 - https://www.awinic.com/en/productDetail/AW20072QNR#tech-docs
> +  aw20108 - https://www.awinic.com/en/productDetail/AW20108QNR#tech-docs
> =20
>  properties:
>    compatible:
> @@ -26,6 +27,7 @@ properties:
>        - awinic,aw20036
>        - awinic,aw20054
>        - awinic,aw20072
> +      - awinic,aw20108
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.36.0
>=20
>=20

--83e25rSk0iUnOhmA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTE4HgAKCRB4tDGHoIJi
0rVoAPwKZ5Haug7t186n1PU3KYbLww6y1HXyfwQM7rgDp2p2NAEAtZyp5p7E2gIA
QHDRHMUeU9+1OU+DOIoSghTAgoSNEgw=
=enfi
-----END PGP SIGNATURE-----

--83e25rSk0iUnOhmA--
