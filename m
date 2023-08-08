Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E421774A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjHHUc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjHHUbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172064AA9A;
        Tue,  8 Aug 2023 09:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E1446259B;
        Tue,  8 Aug 2023 14:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38757C433C8;
        Tue,  8 Aug 2023 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691504572;
        bh=BoGZL15qINg92iX5GzpIYjPkRrdnPmg9jKUou+Jzouk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ta/lRXrtw7X135/22WFEcwjVzLrKE5yQB+5gr7xclahM8A9Lueh96MhshT1fVEA8b
         bNRgDfCoOVe02L4toTo6oFg/cmFPOwr8V2T9MIUu7RoMDvOqdZ/0DjTDK42ClIXNQn
         rrygqvHN9T4oZx0Kly93o9GAYfwITMRnQ+MS09+UlSg9/I7osHpOma/SgFUenCYOzC
         A7IiZo+EdzWHW6AV8IVvppp98GQoI5WoIjnUi9E+VL/184Jwd40frtCo5eJtQOF3qs
         1cU0Wk2ukrPW1rNLCjnf60SKUjUg6yiYlZa750yuW+PIEaI8vx4I6VlQrlfG3oZkln
         BRCIdj0t21C3g==
Date:   Tue, 8 Aug 2023 15:22:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 04/11] regulator: rk808: Drop useless headers
Message-ID: <78af1ca5-12c9-4c12-a08d-6ce2df29ff60@sirena.org.uk>
References: <20230808-descriptors-regulator-v1-0-939b5e84dd18@linaro.org>
 <20230808-descriptors-regulator-v1-4-939b5e84dd18@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="02s0islE/xNt6q2j"
Content-Disposition: inline
In-Reply-To: <20230808-descriptors-regulator-v1-4-939b5e84dd18@linaro.org>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--02s0islE/xNt6q2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2023 at 03:46:31PM +0200, Linus Walleij wrote:
> The RK808 is already using the proper <linux/gpio/consumer.h>
> header and includes the legacy headers <linux/gpio.h> and
> <linux/of_gpio.h> for no reason, drop the includes.

This doesn't apply against current code, please check and resend.

--02s0islE/xNt6q2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTST7UACgkQJNaLcl1U
h9BCWQf/f1t9dZeSv6IT+0vb+00EGsLxELQMnJFIxNYkecL+4eTfiotF+Xg5YzH/
4dEUdEx4lsQOrH4mCYLm1ndKhwFLTCC1ElqJI4rmdvDeMePJXUCbndA/qz/pNOwc
cpUUqlCBr5qhP35uksyfRyYkk9gclBGhbEQ4xva3IewZCq4UiL6FiW8zFw/MHbc5
/LI9IdCzBPbgmI5cw3gf5D3u7dxkgz5BKKditUYJ5gE+3f9Jnk+g13cZY23idjzT
wIWe+RH8yjoUdA8ahzLJtR47zZsNeas5mhLncA3jqFVD+XafqKzubgtqa9JNcWj2
to9N+Oej2TNpi7y/5AuwJ6BCp+AzbQ==
=1iIc
-----END PGP SIGNATURE-----

--02s0islE/xNt6q2j--
