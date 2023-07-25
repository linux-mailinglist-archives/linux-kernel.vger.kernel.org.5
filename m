Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97C67622D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGYUAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGYUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F90122;
        Tue, 25 Jul 2023 13:00:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7136618C8;
        Tue, 25 Jul 2023 20:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F122FC433C7;
        Tue, 25 Jul 2023 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690315233;
        bh=Nl7KuEf0KPDnP7qcC7cvhpZp60FL6hPZ02vAY9MQpD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTwina5X4/N4NDKJ254V9wKdjNqGZwMu5KsxvjfdMATACJrkSgLmK2qZ3NxNH4yBz
         rv9b/zaubdr8OYBcjcIig9Pum2/7MnJAzFQrFPmWRUoDsTDH5HyYWYXvvwUhqn3JLu
         rbN38Z5Wp4rX6FphzBa2yEEyFPYr8wcM0B0lW6/YcJ8g3FGuoje3u8yeUWxn5Fe4lw
         BWYjiGLRNxCAI2M15ywj5oufqEn3NQPUgLAZq2xn07NAPWfpNRutJLGoE8AQZzXho1
         wsobQoKoJz4rJ86IlQ0LYksbWcc6+ufbU2tzOLmKRZmffzWM4fbAgn49/J/Iu4shDg
         JVjcNWEHYr0og==
Date:   Tue, 25 Jul 2023 21:00:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: dt-bindings: dlg,da9121: add buck2
 constraints
Message-ID: <20230725-pound-coil-4115d361864b@spud>
References: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z8MCSy8s5o1Kf8Z3"
Content-Disposition: inline
In-Reply-To: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z8MCSy8s5o1Kf8Z3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 02:46:27PM +0200, Krzysztof Kozlowski wrote:
> Instead of describing the constraints for some devices (buck2 not
> present), code it in allOf:if:then section to actually allow validation
> of this requirement.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Z8MCSy8s5o1Kf8Z3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAp3AAKCRB4tDGHoIJi
0iG+AQCtJ/vVaEHGDk8XOlPD8iDizg1wP4ybMWAC4uaDL+5/ogEAmMZrvtLhL1ll
s+4yaAAkHSvQSzFQWeCpatvg8BBZ8Ak=
=moTF
-----END PGP SIGNATURE-----

--Z8MCSy8s5o1Kf8Z3--
