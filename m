Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD88F7EC583
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbjKOOkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:40:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC38FB6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:40:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F7DC433C9;
        Wed, 15 Nov 2023 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700059207;
        bh=BaGIA4l4ejhYWBQISc1C+sD93500hrAcYx7aVH8JMVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhDBs1seuSmSug6Q4RjM8AVkxVtJg3I1chbH7NIG18ioJz+zMIQR5EsTh/63/w8zO
         vbGelQqDTwYs9c7u1KpgqK6cXL8gxXge3QenH3Pa4t5IjVlFt99vgfgOYIuPCSgU64
         v7i8HaqbbJ3vZ9NiJTGj5oN5AyTF8cOKFkMp7gZw05j+c7DftEskPRI3Rbbfhv4l0g
         OaQHStJIW4IB43DEyLLl9WdNHzTsdp3UyNKswCrGlaPE2MfaHMqP1EubCJpXX6MK6T
         +Wwi8yZemDQpYLsau7/TWrzW/Wq5SLBibcSQNMgxeD2LVKeLFXWS3xA6ezMxcw1Pwz
         iE9BLLETPiX+Q==
Date:   Wed, 15 Nov 2023 14:40:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: display: bridge: lt8912b: Add power
 supplies
Message-ID: <20231115-epidural-vantage-89ff91774805@squawk>
References: <20231115121338.22959-1-francesco@dolcini.it>
 <20231115121338.22959-3-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GZwI/uocM5eJlZ54"
Content-Disposition: inline
In-Reply-To: <20231115121338.22959-3-francesco@dolcini.it>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GZwI/uocM5eJlZ54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 01:13:37PM +0100, Francesco Dolcini wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>=20
> Add Lontium lt8912b power supplies.
>=20
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor,

> ---
>  .../display/bridge/lontium,lt8912b.yaml       | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt8=
912b.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912=
b.yaml
> index f201ae4af4fb..2cef25215798 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.ya=
ml
> @@ -55,6 +55,27 @@ properties:
>        - port@0
>        - port@1
> =20
> +  vcchdmipll-supply:
> +    description: A 1.8V supply that powers the HDMI PLL.
> +
> +  vcchdmitx-supply:
> +    description: A 1.8V supply that powers the HDMI TX part.
> +
> +  vcclvdspll-supply:
> +    description: A 1.8V supply that powers the LVDS PLL.
> +
> +  vcclvdstx-supply:
> +    description: A 1.8V supply that powers the LVDS TX part.
> +
> +  vccmipirx-supply:
> +    description: A 1.8V supply that powers the MIPI RX part.
> +
> +  vccsysclk-supply:
> +    description: A 1.8V supply that powers the SYSCLK.
> +
> +  vdd-supply:
> +    description: A 1.8V supply that powers the digital part.
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.25.1
>=20

--GZwI/uocM5eJlZ54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVTYQAAKCRB4tDGHoIJi
0ra9AP9qgkDDNxwgVnODaITFA4y+M13nhrU7tTP38T1RTbT5VAD+IT57rAccR244
fPUa50O7sdrTRuV6XocSiiIKqp5eNQ4=
=DqWG
-----END PGP SIGNATURE-----

--GZwI/uocM5eJlZ54--
