Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC07B3443
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjI2OHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjI2OHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:07:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808221A8;
        Fri, 29 Sep 2023 07:07:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E0EC433C7;
        Fri, 29 Sep 2023 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695996435;
        bh=olOL9wN8cgjXunpWPWp+h6aP5nihELtHTMYME3fBmJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+pbsLbZ3SHEk65ZNDzAKFIOu5sAkQjQw7Uiwpgs4JWPbN8scLx/vuphfrKrFZUvy
         JnN6tkDHlyNdkCKSBZ1pLjBqoj8ljiJ8Rz67K3EMNk40FmaJMbPt7SBsXtX2BvG2wD
         +2rRbsYYDdxZfF5HdJC5TbvN85xPI6yLqF6+NuIZGKbwboMDlkfdL/Lzb1jqeN8eGV
         wfX4jiWy+QQDqB4ri0CpiRWZT4n/WZ3JnWbp8K81ez/dEjHfpouiNFZOz6j7pMGory
         DUZaM9gBp3qEdOMwQ2JqVaMJQk7sEGUW6ErzD7cbi2aJoeaO8m/jZ44CQ43KvetUt+
         fUqysr6IoNQWQ==
Date:   Fri, 29 Sep 2023 15:07:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 20/28] dt-bindings: pinctrl: renesas: document RZ/G3S
 SoC
Message-ID: <20230929-dyslexic-deity-d0ff0d579ff7@spud>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
 <20230929053915.1530607-21-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0Gc/+fe1ZkVHCyX4"
Content-Disposition: inline
In-Reply-To: <20230929053915.1530607-21-claudiu.beznea@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0Gc/+fe1ZkVHCyX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 08:39:07AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Add documentation for pin controller found on RZ/G3S (R9A08G045) SoC.
> Compared with RZ/G2{L,UL} RZ/G3S has 82 general-purpose IOs, no slew
> rate and output impedance support and more values for drive strength
> which needs to be expressed in microamp.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> Changes in v2:
> - defined drive-strength-microamp as general and make if/then schema to
>   not allow specific properties depending on compatible
>=20
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinc=
trl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.=
yaml
> index eb726770f571..86228ba69aab 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -25,6 +25,7 @@ properties:
>            - enum:
>                - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and R=
Z/Five
>                - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
> +              - renesas,r9a08g045-pinctrl # RZ/G3S
> =20
>        - items:
>            - enum:
> @@ -78,6 +79,21 @@ additionalProperties:
>          - $ref: pincfg-node.yaml#
>          - $ref: pinmux-node.yaml#
> =20
> +        - if:
> +            properties:
> +              compatible:
> +                contains:
> +                  enum:
> +                    - renesas,r9a08g045-pinctrl
> +          then:
> +            properties:
> +              drive-strength: false
> +              output-impedance-ohms: false
> +              slew-rate: false
> +          else:
> +            properties:
> +              drive-strength-microamp: false
> +
>        description:
>          Pin controller client devices use pin configuration subnodes (ch=
ildren
>          and grandchildren) for desired pin configuration.
> @@ -92,6 +108,10 @@ additionalProperties:
>          pins: true
>          drive-strength:
>            enum: [ 2, 4, 8, 12 ]
> +        drive-strength-microamp:
> +          enum: [ 1900, 2200, 4000, 4400, 4500, 4700, 5200, 5300, 5700,
> +                  5800, 6000, 6050, 6100, 6550, 6800, 7000, 8000, 9000,
> +                  10000 ]
>          output-impedance-ohms:
>            enum: [ 33, 50, 66, 100 ]
>          power-source:
> --=20
> 2.39.2
>=20

--0Gc/+fe1ZkVHCyX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRbaDAAKCRB4tDGHoIJi
0t1kAQDAMTVYgZd+b31A4SXzfKOCQ/Bprjo8BTMgoAzCaMx7CgEAs5JDFJFu96Di
RHElBGwzn3VH/wmjxR6VkbjzWsONjgM=
=2BHK
-----END PGP SIGNATURE-----

--0Gc/+fe1ZkVHCyX4--
