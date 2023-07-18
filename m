Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8D775815E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjGRPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGRPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418341B9;
        Tue, 18 Jul 2023 08:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84776164F;
        Tue, 18 Jul 2023 15:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1DDC433C8;
        Tue, 18 Jul 2023 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689695553;
        bh=XHpeFJn0biYE4gV7xczfk0L4JqX1SaDiayTdQtqcn00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpuLNj10tvhOLFYPo0gAJSUCDA/pvSdt524z27elKPHaHPpMOfDiCkXzUJrs1l9lV
         qmXfVBcyGhu04vMxndgS8ZnsSevIcs0qC0Aj2xQY9mrvOisut+xndNT/P38pQ9PZhl
         UdKOV9vcwcLON5kvxo06oAv7/KPU3qbHbFlepSFgZbTqRdw4oXOrw4z97JuYpGkgjD
         VDgfv2zW3V9Qsp/wz4l7scZQwzngjGFhXr//IEmKvxuHuR6NjJ7Bw6uppRR6d4U98q
         PMu8IjKha4QlPq/NWm8JoinmbXkaK0bOKdfisCgvUDSn8o0nrZe4R+qg8xzp7tFaQ5
         LnfAtma7y35PA==
Date:   Tue, 18 Jul 2023 16:52:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display: add rotation property to
 sitronix,st7789v
Message-ID: <20230718-trinity-moonshine-af526b1c8fcc@spud>
References: <20230718-feature-st7789v-v1-0-76d6ca9b31d8@wolfvision.net>
 <20230718-feature-st7789v-v1-2-76d6ca9b31d8@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LwCAvlGHnD6MaHlT"
Content-Disposition: inline
In-Reply-To: <20230718-feature-st7789v-v1-2-76d6ca9b31d8@wolfvision.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LwCAvlGHnD6MaHlT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 05:12:46PM +0200, Michael Riesch wrote:
> The sitronix-st7789v driver now considers the rotation property.
> Add the property to the documentation.
>=20
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml | =
2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7=
789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789=
v.yaml
> index fa6556363cca..694d7f771d0c 100644
> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.ya=
ml
> @@ -22,6 +22,7 @@ properties:
>    power-supply: true
>    backlight: true
>    port: true
> +  rotation: true
> =20
>    spi-cpha: true
>    spi-cpol: true
> @@ -52,6 +53,7 @@ examples:
>              reset-gpios =3D <&pio 6 11 GPIO_ACTIVE_LOW>;
>              backlight =3D <&pwm_bl>;
>              power-supply =3D <&power>;
> +            rotation =3D <180>;
>              spi-max-frequency =3D <100000>;
>              spi-cpol;
>              spi-cpha;
>=20
> --=20
> 2.30.2
>=20

--LwCAvlGHnD6MaHlT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLa1OwAKCRB4tDGHoIJi
0gMkAP960GmGAgRd4Yg6XS0aqkgycqSXLmPV0ki3Ai6wmaFPLAEAmx02q9lXoias
k/IIgb37pU++baZsXsTkqsap7kJlJgs=
=UStO
-----END PGP SIGNATURE-----

--LwCAvlGHnD6MaHlT--
