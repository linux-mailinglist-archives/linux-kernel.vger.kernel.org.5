Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B970F763E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGZS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjGZS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45361BF2;
        Wed, 26 Jul 2023 11:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3970D61C0A;
        Wed, 26 Jul 2023 18:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA6CC433C8;
        Wed, 26 Jul 2023 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690396026;
        bh=RcVBAAfHER54k81unBpKdeTFWDOVzzrxeLONyzkog9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDVhKP/+rOKPV6FWU0V2HVtCg3RJbPgMXWfCOORXqY6xhyTR7cgeIh3lvxz3ERODI
         gtbMqCMR4SxaeWbb/YIaigOwzCWuVW3NbZXv15KYLqoU3nnDMoUBOCulhgIwdghYnC
         4/7bgT3VfineLAJMu6zG1WuGRHRN6oo3VZEZMNhgrI24Jw57QxYgp0y71DMGzZgqi5
         96aE/FWhDYes2iykdB944h7DLs5LYVbWVfDIs8fH/5M7yxnVOeBfGP/D74ESz+xlcP
         p1y0nFN0laoLzOultlIaNTervCM4VnoUNe37t9Wicxa7u1GLiNyR/q9iGMgQtxrHks
         JAPxoIkEx1OqA==
Date:   Wed, 26 Jul 2023 19:27:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: watchdog: Add support for Amlogic-T7
 SoCs
Message-ID: <20230726-populate-unseeing-0a68fca96e44@spud>
References: <20230726112146.1127145-1-huqiang.qin@amlogic.com>
 <20230726112146.1127145-2-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8r4SD1LFH2QP0ZPP"
Content-Disposition: inline
In-Reply-To: <20230726112146.1127145-2-huqiang.qin@amlogic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8r4SD1LFH2QP0ZPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 07:21:43PM +0800, Huqiang Qin wrote:
> Update dt-binding document for watchdog of Amlogic-T7 SoCs.
>=20
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml     | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxb=
b-wdt.yaml b/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-=
wdt.yaml
> index f5cc7aa1b93b..443e2e7ab467 100644
> --- a/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.y=
aml
> +++ b/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.y=
aml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - amlogic,meson-gxbb-wdt
> +      - amlogic,t7-wdt
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.37.1
>=20

--8r4SD1LFH2QP0ZPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFldQAKCRB4tDGHoIJi
0o1LAP0a8J+dJl9opDCpcZ0beSBf4iEaQFs/LXYgBm7gxVHrtQD6A95c9IYcyNpT
GWMMw9jz4bGJ6bsOQ+T4Tg1Bv+wADwI=
=nTul
-----END PGP SIGNATURE-----

--8r4SD1LFH2QP0ZPP--
