Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6722E7B344C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjI2OJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjI2OJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:09:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE71D1AC;
        Fri, 29 Sep 2023 07:09:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C2CC433C8;
        Fri, 29 Sep 2023 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695996562;
        bh=ECIuZgxCEmIlmR41y89eDdyCkMIakxVpMzDPuDy5MOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvNMHhpqSzuReyTiC4l3M5RQMMGyhdSk3jvXO/U5VICKHL+e2+92J8t7avhcY2umw
         iw3yNR6yleB93+2nj9H5grnfMPhiBG3ECreR6EMjtIHXedm0bZxS9odtsGgN9Yen2c
         3srldQcMsSAGO8krC7yF8aZirgrpA5VXUIRMsy6ZOAsJBraH7S3z5v8JwCJob+Ed6l
         +ifWMJyXJ90Rwa0jjN1KzfhPLDxYYfgcbfpbDqJXEFIcOeTqGuBRdewV15Vf/+MOXE
         lSAM2CTyP8eIaoX3wjaYMl9scZBwd9mNueYN0+KAx/4+repoWvr1m6KhoiyTJWhaD0
         6QpeTM55Y48Sg==
Date:   Fri, 29 Sep 2023 15:09:15 +0100
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
Subject: Re: [PATCH v2 19/28] dt-bindings: pinctrl: renesas: set
 additionalProperties: false
Message-ID: <20230929-garlic-outboard-815482929d9f@spud>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
 <20230929053915.1530607-20-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="my2HgJawl2/1ExGF"
Content-Disposition: inline
In-Reply-To: <20230929053915.1530607-20-claudiu.beznea@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--my2HgJawl2/1ExGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 08:39:06AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Set additionalProperties: false.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v2:
> - this patch is new in v2 and added as suggested by Rob
>=20
>  .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml     | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinc=
trl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.=
yaml
> index 4782f96feb7e..eb726770f571 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -106,8 +106,7 @@ additionalProperties:
>          line-name: true
> =20
>      - type: object
> -      additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"

I have no clue what this original version was doing, I figure it
resolves to an empty list or something, and therefore acts just like
false?

New version looks a lot more normal..

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +      additionalProperties: false
> =20
>  allOf:
>    - $ref: pinctrl.yaml#
> --=20
> 2.39.2
>=20

--my2HgJawl2/1ExGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRbaiwAKCRB4tDGHoIJi
0qh+APwL6eo2jECb7XDIacBCE/sq/P8EV9UzIhGMLfok9E+kzAEAmaehwb9i3mFu
xGy7Ze7QT7QWKu0jwHWu07oEbpptGwg=
=HoNT
-----END PGP SIGNATURE-----

--my2HgJawl2/1ExGF--
