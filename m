Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E73758183
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjGRP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjGRP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C3E77;
        Tue, 18 Jul 2023 08:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0851B6164F;
        Tue, 18 Jul 2023 15:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E5BC433C7;
        Tue, 18 Jul 2023 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689695801;
        bh=OUGHLXWRvZQd4i149WLBrdAwtqzrKGDvVPyUoqibuF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTKticjYbVQQLmTeraIKe4Qz5hsaBMNYKBSWjRdWymOQjCAeSYl/cbzrGVyJVGTlu
         te9NliQFYAHQYJJiTL8zUXlV3m8TWS2UNfrhT/oLET0tAeB8CW959AvNGpSOvhfJh0
         Xc9dzDDtvm9+bzIY2GY2EzzzLaQdc3tKUAYKBibCGJvmfganbbBNLwwt2kzCfm5FWQ
         0PYZ2Z8kCP35qqGU96rUMunAlkGsTVGX0d6FnH3CWY/7qRj/vM0dysv6F0Dmmel7gv
         y98hESioDjPW+eepPregpMMkAZsmjUzczPXVbGR3c4piTGei9kTPH0+yioxjslat++
         3ldAWnj/SR5AA==
Date:   Tue, 18 Jul 2023 16:56:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: add jasonic
Message-ID: <20230718-endurance-dismiss-3aeab33dd7f2@spud>
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <20230718-feature-lcd-panel-v1-1-e9a85d5374fd@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="79UkCYMlLnqwphdT"
Content-Disposition: inline
In-Reply-To: <20230718-feature-lcd-panel-v1-1-e9a85d5374fd@wolfvision.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--79UkCYMlLnqwphdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 05:31:50PM +0200, Michael Riesch wrote:
> Add vendor prefix for Jasonic Technology Ltd., a manufacturer
> of custom LCD panels.
>=20
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 1e2e51401dc5..1dfafc339ddd 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -677,6 +677,8 @@ patternProperties:
>      description: iWave Systems Technologies Pvt. Ltd.
>    "^jadard,.*":
>      description: Jadard Technology Inc.
> +  "^jasonic,.*":
> +    description: Jasonic Technology Ltd.
>    "^jdi,.*":
>      description: Japan Display Inc.
>    "^jedec,.*":
>=20
> --=20
> 2.30.2
>=20

--79UkCYMlLnqwphdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLa2NAAKCRB4tDGHoIJi
0tbPAP42JYtxjnWsZ+Ip4AgG8fiZyGRzyI3eQ/Ek4AiJdA+mJwD/eN7iTbD3MFnp
9mOc1hfwV3/a0VWDJ63BpKNy3mR8ewo=
=Xf4S
-----END PGP SIGNATURE-----

--79UkCYMlLnqwphdT--
