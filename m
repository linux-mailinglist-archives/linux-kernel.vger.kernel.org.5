Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EC87D8437
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbjJZOIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:08:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC1D1A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:08:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2843C433C8;
        Thu, 26 Oct 2023 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698329312;
        bh=6f4xiuOx8GAVgCWVik/nTx0Vov7JkxldkKhv4Zht344=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWi5Ve54FAg4OoUVvKDkCM6+ExJyH8Qsyh+Y/kzOIWQxtJiUbSe7WIlabITNbxIcs
         bdob6pkGAU9jUioWzGHd5psFFkIED5KjoZwq/8AAXYmMPR72rJAqKX36deS4tpEXQL
         koTjzv7zlaZCLh1Yl//dIkrXsvEc+q+nSUYTH/8bXIgV4p3W56p5D9zacCCqIrmFDs
         WDG0pPv/wF7nfO4elApyAEI5B6Q5iuGw5b4sXS+am96gfAVTCjEQNRn3lahDXv76Q+
         KRnCfdUjObWM8rHs6sQo7ptWI0KvtPjeSzMNgUQUpOR1Tbe5SmfPqnQe6NgJoFC/lu
         Fs82VQ02mcaLA==
Date:   Thu, 26 Oct 2023 15:08:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cyuval@marvell.com
Subject: Re: [PATCH v3 2/3] dt-bindings: arm64: dts: add dt-bindings for ac5x
 rd carrier
Message-ID: <20231026-overlay-statutory-320dba426682@spud>
References: <20231026084735.3595944-1-enachman@marvell.com>
 <20231026084735.3595944-3-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jK13gaiH2pAsVtN1"
Content-Disposition: inline
In-Reply-To: <20231026084735.3595944-3-enachman@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jK13gaiH2pAsVtN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 11:47:34AM +0300, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
>=20
> Add dt bindings for AC5X RD COM Express Type 7 carrier board.
> This board will Accept a CN9131 COM Express Type 7 CPU module.
>=20
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml     | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.y=
aml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> index 52d78521e412..71bc94047d1b 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> @@ -60,4 +60,12 @@ properties:
>            - const: marvell,armada-ap807-quad
>            - const: marvell,armada-ap807
> =20
> +      - description: AC5X RD COM Express Carrier for Armada CN9131 SoC w=
ith one external CP
> +        items:
> +          - const: marvell,ac5x_rd_carrier
> +          - const: marvell,cn9131
> +          - const: marvell,cn9130
> +          - const: marvell,armada-ap807-quad
> +          - const: marvell,armada-ap807
> +
>  additionalProperties: true
> --=20
> 2.25.1
>=20

--jK13gaiH2pAsVtN1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTpy2wAKCRB4tDGHoIJi
0v6UAQD5nkeE6T2ElyqajbwgeJl0L+dM+KPyCbE6V5qVBEX1ggEA6urabaKXYH+G
+6e267D/NP+3xGLE6/hiHRkVaxiXsA0=
=hIUT
-----END PGP SIGNATURE-----

--jK13gaiH2pAsVtN1--
