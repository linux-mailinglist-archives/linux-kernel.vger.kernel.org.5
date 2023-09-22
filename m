Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4C7AB51B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjIVPt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjIVPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:49:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C7100;
        Fri, 22 Sep 2023 08:49:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD083C433C8;
        Fri, 22 Sep 2023 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695397760;
        bh=jMjHcug31WE0Bf+Ku26R9S8JCXFscQZH4Akv3KWK0Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/SOWMfNE20zbjcBK/8c3F6O6Fc1na8/hodzZZ6DGFRpmsfAkqnWg/2PfBkUGQDfN
         t7R+uTAEmxHPA2Ja2+bmUkE0GCtFWPpzaUb/QFDmD2Hde2nKeh/m/QBgzg8B3iYy+Q
         rYaChEdl1p3tKO3m/aLHWbQ3ifkqxXV2GTIaCy9R9okYWTGdqIsTS6VQYnNPe+fG7D
         ja508rv2ZxCUTLw7YSs6jk5zGXCPfQxbpE0+CEhxu5i14SfbWDQ/R08ZlVn/MEVmzm
         4hR1WIFYYlXXRO6OIMq2snh4Nwv9dmlipjE/Ef3qTFtjCkjidtgtihq8ytBApJvYuM
         Tn1S6OnoXQAJA==
Date:   Fri, 22 Sep 2023 16:49:14 +0100
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
Subject: Re: [PATCH v6 12/16] dt-bindings: display: mediatek: color: add
 compatible for MT8195
Message-ID: <20230922-zebra-modify-87ff23c70bb3@spud>
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
 <20230922072116.11009-13-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4AbnyxYTFcvfDnp5"
Content-Disposition: inline
In-Reply-To: <20230922072116.11009-13-moudy.ho@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4AbnyxYTFcvfDnp5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 03:21:12PM +0800, Moudy Ho wrote:
> Add a compatible string for the COLOR block in MediaTek MT8195 that
> is controlled by MDP3.
>=20
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,color.yaml     | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,co=
lor.yaml
> index f21e44092043..b886ca0d89ea 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> @@ -26,6 +26,7 @@ properties:
>            - mediatek,mt2701-disp-color
>            - mediatek,mt8167-disp-color
>            - mediatek,mt8173-disp-color
> +          - mediatek,mt8195-mdp3-color

How come this one is a "mdp3" not a "disp"?

>        - items:
>            - enum:
>                - mediatek,mt7623-disp-color
> --=20
> 2.18.0
>=20

--4AbnyxYTFcvfDnp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ23egAKCRB4tDGHoIJi
0jeNAQDbS49YRGx3evrS4YI09M9KqM0J+UXzPHF9KB+js6e3qQD+Ivrgl0SwBLae
2UKQyhQwRkwkANvuDlc0Y+I85WBfego=
=zbsi
-----END PGP SIGNATURE-----

--4AbnyxYTFcvfDnp5--
