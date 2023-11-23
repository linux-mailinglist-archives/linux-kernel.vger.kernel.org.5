Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51F27F65D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjKWR6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:58:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDFAD8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:58:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCABC433C7;
        Thu, 23 Nov 2023 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700762305;
        bh=CdkOgAhi6Qq7XsTQoNuQykYy+5qMsC9bpVDo0+HhVbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpctfeS934De2qrTgc70kNtdR1pySjxVIyIzRZheu5z6vRJYfKnExafV35mIzkBxH
         1+YBgrKmrvaBzLzWwUTYaa9VXs8U6kIaE8CCKELK7kibLFZQs+/8lzUp49mBaVQd/2
         i8i1RmPaiN+Sm5o7t6tQLI1+9BMJ8AWUBZB4fBl3X48a0qZ5xhZYgzV3P5wetPIXZM
         bnKH38/zANHbTfTffAKRyPCU6eHqUQSeEgNy8DvWZf603i+medwJkqfaFTopl9ci/x
         dOKVVLgM9RYvUw68ta/YGkNc0xmO1atfyx88NklO9NeExxPR8Z+omnBE8TrrsHBKSU
         mReTgJd/JJUUw==
Date:   Thu, 23 Nov 2023 17:58:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/3] dt-bindings: ili9881c: Add Ampire AM8001280G LCD
 panel
Message-ID: <20231123-civic-monoxide-ca1d06a02df3@spud>
References: <20231123-drm-panel-ili9881c-am8001280g-v1-0-fdf4d624c211@pengutronix.de>
 <20231123-drm-panel-ili9881c-am8001280g-v1-2-fdf4d624c211@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3USh3Aw49Tg1AKz5"
Content-Disposition: inline
In-Reply-To: <20231123-drm-panel-ili9881c-am8001280g-v1-2-fdf4d624c211@pengutronix.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3USh3Aw49Tg1AKz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 06:08:05PM +0100, Philipp Zabel wrote:
> Document the compatible value for Ampire AM8001280G LCD panels.
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml | 1=
 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili98=
81c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.=
yaml
> index e7ab6224b52e..b1e624be3e33 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - ampire,am8001280g
>            - bananapi,lhr050h41
>            - feixin,k101-im2byl02
>            - tdo,tl050hdv35
>=20
> --=20
> 2.39.2
>=20

--3USh3Aw49Tg1AKz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+SvAAKCRB4tDGHoIJi
0qeaAQCjWZTzaBOgpkzNDPLNrEqSsvJFC3A59Kabqueyk4FabwEAra+EwipZjA+v
uFx8gvNb+kSnNnuv71U0VaHhuVwSBg0=
=iB4D
-----END PGP SIGNATURE-----

--3USh3Aw49Tg1AKz5--
