Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C267873B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbjHXPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242141AbjHXPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D23C7;
        Thu, 24 Aug 2023 08:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC2D66FFF;
        Thu, 24 Aug 2023 15:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B097C433C8;
        Thu, 24 Aug 2023 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692889730;
        bh=EGWLDuNzqq6PTrj2iWCVL1umx9FxMsqgeHIS5IJ9B64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+CXwreJozjcwmarpEJoD90bP+zN7XpuelIOwjuwvVsyNd0fu/Ld2aUvRtXyxHv5O
         08UQmFj+VgHpOGvYMqFfEHB4UYKI4W0hJz4p0F4CtYPgxkTQAlnIjI2aIEXSafbVPu
         W362gQ9pia3KeXy1YGo6eQ2B2cclvyytyufC6Q7flHCGevJ5CX3kg030xNNjUAGmOJ
         hOqZF3+LWP1lYMe11CQ3C3PSr6Xz8j6MB3gOEQQhphVTSZmCOgVNEUVr8Rm8Gytkkc
         tahrPf99RoIvIJ7I4pXSrR2e7QngDUZErsT+cBdIRfvusItRgh89Gd+L20vcp2eGj/
         oUVQe+BLS1DTQ==
Date:   Thu, 24 Aug 2023 16:08:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, conor+dt@kernel.org,
        kernel@sberdevices.ru, sdfw_system_team@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 15/15] dt-bindings: arm: amlogic: add Amlogic AD402
 bindings
Message-ID: <20230824-postbox-refueling-3bccc959d82b@spud>
References: <20230823213630.12936-1-ddrokosov@sberdevices.ru>
 <20230823213630.12936-16-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IeP/KGlIXWB7S8Lk"
Content-Disposition: inline
In-Reply-To: <20230823213630.12936-16-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IeP/KGlIXWB7S8Lk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 12:36:30AM +0300, Dmitry Rokosov wrote:
> Add the compatible for the Amlogic A1 Based AD402 board.
>=20
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documen=
tation/devicetree/bindings/arm/amlogic.yaml
> index 08d59842655c..15880abb7261 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -203,6 +203,7 @@ properties:
>          items:
>            - enum:
>                - amlogic,ad401
> +              - amlogic,ad402
>            - const: amlogic,a1
> =20
>        - description: Boards with the Amlogic C3 C302X/C308L SoC
> --=20
> 2.36.0
>=20

--IeP/KGlIXWB7S8Lk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOdyfAAKCRB4tDGHoIJi
0oIXAQCxCYiJcSXauX/bC1ncL/pW/vgEoxuRCEB1sACDgGlzXgEA5fo4ZywiPR9i
5bRB7njZo+PmtnYhAyMqk7b0KV7YJwQ=
=Twj5
-----END PGP SIGNATURE-----

--IeP/KGlIXWB7S8Lk--
