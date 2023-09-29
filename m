Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013937B3439
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjI2OGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjI2OGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:06:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943F9DB;
        Fri, 29 Sep 2023 07:06:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F075C433C8;
        Fri, 29 Sep 2023 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695996361;
        bh=TbckdWvwK4auFOXas/a0A6Sw7++8w4iMTpEnju2FbpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bztEm8/+W8oJ9LY0UW30TZB7TXrWO9ynk2xaHq5c9epgJ+NZWojZSUBeIwdr3Z7QC
         WE0Dyw/FenBWk7V2OBPDCLLw70eZ8WCZk2CEfTf/xuhcRV7gK5781EYqrh7zTd6enf
         GnXsPwoX6/CNM16nUnQWlwOz9GaFRRb6xqp7RHPyS5N9x6VM04HFmCUlcB8GY4z3oy
         u2y5WfgmBgG95p6HdhdqGTgzLxpYfdVai9uKXahC8WbfoWcT1vd84VOIUARo1PNGTG
         LJ+9ZB0YfbrH4M6TfD0BZcU7inktZxXMV1XikuK8JEcrXdZM/K0G2Bq5Y+RgwxCSiD
         G9nRIhOKJpjeg==
Date:   Fri, 29 Sep 2023 15:05:54 +0100
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
Subject: Re: [PATCH v2 23/28] dt-bindings: arm: renesas: document RZ/G3S
 SMARC SoM
Message-ID: <20230929-multiple-scallion-3a6e106e56ac@spud>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
 <20230929053915.1530607-24-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vCKR3sYe3VOcj8c0"
Content-Disposition: inline
In-Reply-To: <20230929053915.1530607-24-claudiu.beznea@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vCKR3sYe3VOcj8c0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 08:39:10AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Document Renesas RZ/G3S SMARC SoM board which is based on RZ/G3S
> (R9A08G045S33) SoC.
>=20
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> Changes in v2:
> - this patch is new in v2 and added as suggested by Geert
>=20
>  Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b=
/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> index 822faf081e84..31d0539bb168 100644
> --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> @@ -480,6 +480,12 @@ properties:
>                - renesas,r9a08g045s33 # PCIe support
>            - const: renesas,r9a08g045
> =20
> +      - description: RZ/G3S SMARC Module (SoM)
> +        items:
> +          - const: renesas,rzg3s-smarcm # RZ/G3S SMARC Module (SoM)
> +          - const: renesas,r9a08g045s33 # PCIe support
> +          - const: renesas,r9a08g045
> +
>  additionalProperties: true
> =20
>  ...
> --=20
> 2.39.2
>=20

--vCKR3sYe3VOcj8c0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRbZwQAKCRB4tDGHoIJi
0kJ8AP9BDPKe/hn4dFJsq9M6O7qa+VPwhPLyoiOzVm0U9KDxdwD7BsnjNtnFKjUz
LaSkObGrQi3BGDyei4YqEq6esOx24wg=
=GBJI
-----END PGP SIGNATURE-----

--vCKR3sYe3VOcj8c0--
