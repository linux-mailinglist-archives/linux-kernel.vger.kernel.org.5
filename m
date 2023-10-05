Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE57BAF5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjJEXiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjJEXhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:37:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0095119;
        Thu,  5 Oct 2023 16:36:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB365C433C7;
        Thu,  5 Oct 2023 23:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696548996;
        bh=jM/w3fzfVHdmadDXFozFx6NFKuTnREVwExPWlfdgFgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUcWtuyeYhbG07u6HpTAvW7DOS7G42XnmLKPctw9KA5fA7aKTjvKyKRAyWtmTUAQ0
         Szi4wmKMm8XKxe4YfpLFwtXgKjj9Pc4uCHAeZOLMwzngDZ9rQQ9oJTko1XtWa0fSXn
         7PyMBndfHG799/tObcqH35jZBPOWOyCyjlmIo64FZMwCsNs4aKV0IRU4SjNv40tsra
         Y06D0H2PIHB0Xaxl8t8w9upqskBQH3vAHCHylSPya38VP7cBy8tPkmNkTPTKSKHlv4
         0FP/FVMx56J+3Y/rl3LCXkyvdE/erFhPPVhPx+D8dh84tYl4d3C4ZoXdOLDOGpU4+n
         5pSr3IZIZGfEg==
Date:   Fri, 6 Oct 2023 00:36:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: Re: [PATCH v2 1/2] media: dt-bindings: mediatek: Add phandle to
 mediatek,scp on MDP3 RDMA
Message-ID: <20231006-jinx-playing-261e5f41ff7f@spud>
References: <20231005104905.120544-1-angelogioacchino.delregno@collabora.com>
 <20231005104905.120544-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gIB/z/xC+ykFsm7t"
Content-Disposition: inline
In-Reply-To: <20231005104905.120544-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gIB/z/xC+ykFsm7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 12:49:04PM +0200, AngeloGioacchino Del Regno wrote:
> The MDP3 RDMA needs to communicate with the SCP remote processor: allow
> specifying a phandle to a SCP core.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>=20
> v2: I've dropped Conor and Chen-Yu's Reviewed-by tags because I have chan=
ged
>     the description (so, the patch actually changed a bit).

I dunno, you made it more informative so you could probably have kept
mine at least.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
>  .../devicetree/bindings/media/mediatek,mdp3-rdma.yaml     | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.y=
aml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> index 7032c7e15039..59dcea797b71 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -45,6 +45,14 @@ properties:
>        include/dt-bindings/gce/<chip>-gce.h of each chips.
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> =20
> +  mediatek,scp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the System Control Processor (SCP) used for initializing
> +      and stopping the MDP3, for sending frame data locations to the MDP=
3's
> +      VPU and to install Inter-Processor Interrupt handlers to control
> +      processing states.
> +
>    power-domains:
>      maxItems: 1
> =20
> --=20
> 2.42.0
>=20

--gIB/z/xC+ykFsm7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZR9IfgAKCRB4tDGHoIJi
0mYNAP94jJiEEICc5tNh0nDrkI4gQqpKlFv0/+qx4Ml3g4MyRwD/bq/qU6AsenA0
urxwY3sdNT0Qa5qIFRnbeDawGz/Y9gE=
=bidF
-----END PGP SIGNATURE-----

--gIB/z/xC+ykFsm7t--
