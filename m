Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2CE7B3433
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjI2OFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjI2OF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:05:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB59DB;
        Fri, 29 Sep 2023 07:05:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B240C433C8;
        Fri, 29 Sep 2023 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695996326;
        bh=tP1APH92nLtf8T7YFL28/R3TCbGHTTmTTaQOdd2zGXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+MjvEB7dRdldT4nfXOKreJu7PIKU3C48OjQTg0KvQk3mRo9hpdBndfaotDjelmrz
         Z1egO5FlHG6OVvsd3BnafqoOFhE0h0QZNvpFLP6n+94Jf1XQazF1LkWTdA3UyKhU0A
         qd4lG4878MDE8laeNABtnDuxRe3Ff36uuKwuzhyis6v6/NG/iyHxbNA1+LDLNDOZ1C
         /YFAEpW8Ga1ykdO23amVSdTmTf3+91n6fHFGnBIMbJVCnTpKZTfpCXQ1pNwi5aBtmk
         Fmk1q8yumywIGqYsuRnAqyPjSxgoRB/EZXQbuKWKSrwb/YHUtyDxoTPdaSafzvTquq
         Dl/OOpTYLWbbA==
Date:   Fri, 29 Sep 2023 15:05:19 +0100
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
Subject: Re: [PATCH v2 26/28] dt-bindings: arm: renesas: document SMARC
 Carrier-II EVK
Message-ID: <20230929-spud-negotiate-40f630d2c0ae@spud>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
 <20230929053915.1530607-27-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7a52/xrNV+BUgOSd"
Content-Disposition: inline
In-Reply-To: <20230929053915.1530607-27-claudiu.beznea@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7a52/xrNV+BUgOSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 08:39:13AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Document Renesas SMARC Carrier-II EVK board which is based on RZ/G3S
> SMARC SoM. The SMARC Carrier-II EVK consists of RZ/G3S SoM module and
> SMARC Carrier-II carrier board, the SoM module sits on top of carrier
> board.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> Changes in v2:
> - this patch is new in v2
>=20
>  Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b=
/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> index 31d0539bb168..594a7d7a6ee4 100644
> --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> @@ -486,6 +486,13 @@ properties:
>            - const: renesas,r9a08g045s33 # PCIe support
>            - const: renesas,r9a08g045
> =20
> +      - description: RZ SMARC Carrier-II Evaluation Kit
> +        items:
> +          - const: renesas,smarc2-evk # RZ SMARC Carrier-II EVK
> +          - const: renesas,rzg3s-smarcm # RZ/G3S SMARC SoM
> +          - const: renesas,r9a08g045s33 # PCIe support
> +          - const: renesas,r9a08g045
> +
>  additionalProperties: true
> =20
>  ...
> --=20
> 2.39.2
>=20

--7a52/xrNV+BUgOSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRbZnwAKCRB4tDGHoIJi
0utnAQDDAyM70bskIR+jot5/Uoosxmd3Vo+j0LBWTc2HLt+7tAEAwpX9wgoSxAbO
QIu3Es/tsf6na3Bwc0oift7ihJBQGgQ=
=shhc
-----END PGP SIGNATURE-----

--7a52/xrNV+BUgOSd--
