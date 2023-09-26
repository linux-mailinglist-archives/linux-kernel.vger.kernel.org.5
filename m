Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8337AED86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjIZNAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjIZNAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:00:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BAF101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:00:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED2CC433C7;
        Tue, 26 Sep 2023 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695733231;
        bh=XgRLp7reMByJE6iz+js3n2o08ntA/g2oL1gYbgxKMvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuMaBcWEEUoMwIGVfh7LCgMZLzIoRYyIQZfmV9mqDOYRvMEzQBDBmJKadK8zOhUOA
         8TXzzE+VRGzdUC7IydYVWYEaDhfqRSubqXBhDhQu3LfiUwhPyz4LoJltapIUtZsv9x
         Nt5wXsK/S+Ixv5FKef7+8TzVtoGu1h6chKIwyzPlb80hqxV+8EHVXh9lHCK6/36MCg
         23FOubJjpnR3LzBr6evvPH7WrFTczRW3YI4e4mq0NqEADxjRHox93iiKOvAmchkHXF
         KkW9YRuiMtASJZ1sIzo/mj8/RDUUyh6UY3VvhXhOxJVZoD1M49UUk7U9vp7HJaL8Ed
         w4dis/6GFpjBw==
Date:   Tue, 26 Sep 2023 14:00:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: bus: fsl,imx8qxp-pixel-link-msi-bus: Drop
 child 'reg' property
Message-ID: <20230926-remold-splendor-7993a7c13450@spud>
References: <20230925212639.1975002-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zcGQjy0PLp5BA9R5"
Content-Disposition: inline
In-Reply-To: <20230925212639.1975002-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zcGQjy0PLp5BA9R5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 04:26:34PM -0500, Rob Herring wrote:
> A bus schema based on simple-pm-bus shouldn't define how may 'reg' entries
> a child device has. That is a property of the device. Drop the 'reg' entr=
y.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml           | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link=
-msi-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-lin=
k-msi-bus.yaml
> index b568d0ce438d..7e1ffc551046 100644
> --- a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bu=
s.yaml
> +++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bu=
s.yaml
> @@ -73,9 +73,6 @@ patternProperties:
>    "^.*@[0-9a-f]+$":
>      description: Devices attached to the bus
>      type: object
> -    properties:
> -      reg:
> -        maxItems: 1
> =20
>      required:
>        - reg
> --=20
> 2.40.1
>=20

--zcGQjy0PLp5BA9R5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRLV6gAKCRB4tDGHoIJi
0io+AP9wlWXH+j4jhPEZeQOoW6HTGgw44C5an64Q85qsYtHNMwEArDFSJJAqvGYu
e9o5vwjvRLIW3w1n2uU8LgrrGe3MMgk=
=z3JY
-----END PGP SIGNATURE-----

--zcGQjy0PLp5BA9R5--
