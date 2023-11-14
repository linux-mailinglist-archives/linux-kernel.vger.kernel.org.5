Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066297EB5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjKNRrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKNRrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:47:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A8594;
        Tue, 14 Nov 2023 09:46:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906DDC433C8;
        Tue, 14 Nov 2023 17:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699984018;
        bh=eCMU4RF9OJ4X7mcA2D6kVETfj8p7WKrVJJV5XZuQ5Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M043fNWlZFaDO4W2DaRdnW/Zkgbizurx86jTKDsqEKY1+6ayXvXouPLX3RaMWw3aW
         ea0bmPGghraL+VzuSZ8rwjzIU0IAbRV5+nHN75PxxDGubFW9peZ9/S4bmrMLcX+wtA
         VeIndsF78jfozk3B4yRZ1I8gSwWZAJl2LA5sUH9GEhyNmvFefkDf056z99OgKvCth0
         6O2uh5CtMEFGEUV3gLLMYvGMdTKi3lhSmz/UWywxVisV/VRLbIT0ATz6lBnVXQZnJw
         29TPCQ8KzEwNcF/Gw35VQwjEistoju409/jXK0d8Vi70G9QsTVKC4PxjPKmMVRmqgQ
         FS9AjhGBnaQLQ==
Date:   Tue, 14 Nov 2023 17:46:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: meson-g12a-power: document ISP
 power domain
Message-ID: <20231114-tremor-deftly-9e0df4aa6dc9@squawk>
References: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-0-f01e6fca67a0@linaro.org>
 <20231114-topic-amlogic-upstream-isp-pmdomain-v1-1-f01e6fca67a0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PwYF9EZeZpf3gj+q"
Content-Disposition: inline
In-Reply-To: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-1-f01e6fca67a0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PwYF9EZeZpf3gj+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:19:50AM +0100, Neil Armstrong wrote:
> Add MIPI ISP power domain ID to the G12A Power domains bindings header
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor,

> ---
>  include/dt-bindings/power/meson-g12a-power.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bi=
ndings/power/meson-g12a-power.h
> index 44ec0c50e340..01fd0ac4dd08 100644
> --- a/include/dt-bindings/power/meson-g12a-power.h
> +++ b/include/dt-bindings/power/meson-g12a-power.h
> @@ -10,5 +10,6 @@
>  #define PWRC_G12A_VPU_ID		0
>  #define PWRC_G12A_ETH_ID		1
>  #define PWRC_G12A_NNA_ID		2
> +#define PWRC_G12A_ISP_ID		3
> =20
>  #endif
>=20
> --=20
> 2.34.1
>=20

--PwYF9EZeZpf3gj+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVOyiwAKCRB4tDGHoIJi
0rmuAP962Bb9llHANd7qrsMYBmKgYiRTEy5nus69HQ/DSFFWngEA5WgpUUCCOIRm
vSTfY/PJbbSulsYVa7P1iCnUYaoERQI=
=gjcN
-----END PGP SIGNATURE-----

--PwYF9EZeZpf3gj+q--
