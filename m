Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8381B7F73D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjKXMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:31:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E7D69
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:31:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542B6C433C9;
        Fri, 24 Nov 2023 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700829074;
        bh=tAap/i24iWrMnBAbBq4n2i8qwIMwaOlc9deTHTR+nTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpERsoufGLxc1hxyDAPPD7rZ1tfR4vwx+Xv28yU6m7sD0mNb6bR5aEaOaHGvZ3S1C
         Z+eWKzk2Z6//2Zln4eVbhsPM+ZwC9j3SFbDFt14010chLxOrj9/KQN0GNauCXqK1TO
         dI53lq2m1bRmes5tX2MSRVZbQ2UCQru8lsScHZKlfLjSU8tIRnYP3Agy3ddNBXVi70
         zahOFZ9MV8HzzxMGOAbeFHAyfOWyl5fRWNdI3XeTEP2Hmt3yyUJx4liqNYDGZAR0wf
         m4n94Wsy8zZ7509JSVWkxp2yDj+ExSLrglqTHEcP9mhFIx49uTRKEfRH3Wktt9PSlA
         g0Sh68Xh2OZcw==
Date:   Fri, 24 Nov 2023 12:31:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Shengyang Chen <shengyang.chen@starfivetech.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        florian.fainelli@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, eric@anholt.net,
        thierry.reding@gmail.com, changhuang.liang@starfivetech.com,
        keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: raspberrypi: Add
 compatible property for waveshare 7inch touchscreen panel
Message-ID: <20231124-lesser-sinister-7f9cd7b80e35@spud>
References: <20231124104451.44271-1-shengyang.chen@starfivetech.com>
 <20231124104451.44271-2-shengyang.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6rp6o7CTZMQn9QKM"
Content-Disposition: inline
In-Reply-To: <20231124104451.44271-2-shengyang.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6rp6o7CTZMQn9QKM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 06:44:50PM +0800, Shengyang Chen wrote:
> The waveshare 7inch touchscreen panel is a kind of raspberrypi pi
> panel

Can you be more specific about what "is a kind of rpi panel" means?
Are they using identical chips as controllers or something like that?

> and it can be drived by panel-raspberrypi-touchscreen.c.
> Add compatible property for it.
>=20
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
> ---
>  .../bindings/display/panel/raspberrypi,7inch-touchscreen.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/raspberrypi,=
7inch-touchscreen.yaml b/Documentation/devicetree/bindings/display/panel/ra=
spberrypi,7inch-touchscreen.yaml
> index 22a083f7bc8e..e4e6cb4d4e5b 100644
> --- a/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-t=
ouchscreen.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-t=
ouchscreen.yaml
> @@ -22,7 +22,9 @@ description: |+
> =20
>  properties:
>    compatible:
> -    const: raspberrypi,7inch-touchscreen-panel
> +    enum:
> +      - raspberrypi,7inch-touchscreen-panel
> +      - waveshare,7inch-touchscreen-panel
> =20
>    reg:
>      const: 0x45
> --=20
> 2.17.1
>=20

--6rp6o7CTZMQn9QKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWCXiwAKCRB4tDGHoIJi
0i61AQCwXh07gxbDq8SOnnI05/Qvw5TV2XV1uBpFa4IR3vUM5wEA0CuPaXJnEaU2
MClktifS0gc4Nm9iKOu+bf1Ixz945g0=
=AgXz
-----END PGP SIGNATURE-----

--6rp6o7CTZMQn9QKM--
