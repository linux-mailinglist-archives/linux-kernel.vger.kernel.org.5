Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58547AB4FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjIVPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjIVPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:43:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2269383;
        Fri, 22 Sep 2023 08:43:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D32C433CA;
        Fri, 22 Sep 2023 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695397400;
        bh=2D8Z7v2qzLl47ly62ZoxkjJCQb0vImD7WRAPF4T+c1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJJda26xUSaI7AbpBmjodCtUgBE+/4MgwsXQGUfMN2zwte4LsM3H3WOt0ofldycqn
         22w2jIpnSjNrhdajZ/k0aaWR2KJJN5z6KUgIk7Gvk/sBk7IFa9gBlzBa8QB1jEO6+R
         okohs077D4CbpubChXzv3XARmcP0H64paQszEWXI1q0ZjTDi2n93rRp41vkJyE4o9c
         xJdAlhHzcFKWk+ypfN41s3bix/bqpED58IRSQOWdTvLr1ApfN/VMyiw3RcnQ7TE+sL
         BhkoScCWTBCPa7MNyR/oIOWWlt39hUjG5s8oX8P5kgZZ1VbjleQm/WhdmXsg8vlEZN
         Que3U44C/ryaA==
Date:   Fri, 22 Sep 2023 16:43:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 04/16] dt-bindings: media: mediatek: mdp3: rename to
 MT8183 RDMA
Message-ID: <20230922-dividing-trousers-58395562a80e@spud>
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
 <20230922072116.11009-5-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Y4vtjwYzjnHR6mE"
Content-Disposition: inline
In-Reply-To: <20230922072116.11009-5-moudy.ho@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Y4vtjwYzjnHR6mE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 03:21:04PM +0800, Moudy Ho wrote:
> The file was renamed to support future scalability in response to
> the changes in general properties separation.
>=20
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Same with this, not all too sure why this is a commit of its own.

> ---
>  .../{mediatek,mdp3-rdma.yaml =3D> mediatek,mdp3-rdma-8183.yaml}   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/media/{mediatek,mdp3-rdma.yaml =
=3D> mediatek,mdp3-rdma-8183.yaml} (96%)
>=20
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.y=
aml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma-8183.yaml
> similarity index 96%
> rename from Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.ya=
ml
> rename to Documentation/devicetree/bindings/media/mediatek,mdp3-rdma-8183=
=2Eyaml
> index 0539badc9821..74a1eebf668d 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma-8183.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/media/mediatek,mdp3-rdma.yaml#
> +$id: http://devicetree.org/schemas/media/mediatek,mdp3-rdma-8183.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: MediaTek MT8183 Read Direct Memory Access
> --=20
> 2.18.0
>=20

--4Y4vtjwYzjnHR6mE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ22EgAKCRB4tDGHoIJi
0hezAP9q+TcUrIoWLs39/7VTOK8gnCa34WnmBN2JLB3/wXifJwD9FRCsU+pP21m0
v50WOhjJOqVPaEeX/UEApSfWeT7RSAY=
=LIPX
-----END PGP SIGNATURE-----

--4Y4vtjwYzjnHR6mE--
