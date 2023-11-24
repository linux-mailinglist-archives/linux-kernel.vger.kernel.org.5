Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C47F7219
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbjKXKwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345372AbjKXKwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:52:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED5191
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:52:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F995C433C7;
        Fri, 24 Nov 2023 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700823168;
        bh=eEX4tBGuafbo1X94/+okj0mvehs96kjdE/PmoG3Gt40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWNnJzORCs/6+M4b46F3hx+3/IWccwtPeWfYeltqWKFXDpcpipaQX9WAyRPio/iW6
         dT7asdlQ3YGaL9ZhZNAVMAD9vf/Fm2tpYAc2Dw81kZZhSy6eh8qdMsHWVpJKS8rKW8
         LrHBjfrRHBcy1epv3XqKr/bPIt+6Kh6H9aCeWD2WuVvvOGe3++GJYZyUXzes3/oYgV
         hwwvDOXJ01mgZjRMHRXdl9+iiry6ZbL+Hg3hwJTmi8BAYefWUqLBrz/qGPQILpO3Wi
         ss2kaIOsVnHMNP3NwswRovinHhmhs/biEjG9PYb2zfXRKnAy6DclYLFrxrPz0SqG4e
         COia8kKbBFP2A==
Date:   Fri, 24 Nov 2023 11:52:46 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 11/12] DONOTMERGE: arm64: meson: khadas-vim3l: add DSI
 panel
Message-ID: <bn5tpzvohmgac4m46fruxbi6quja624tm2fefyj7f3ngo3enno@2ueiodd6qxbd>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
 <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-11-95256ed139e6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4j755csbj5bgclkr"
Content-Disposition: inline
In-Reply-To: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-11-95256ed139e6@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4j755csbj5bgclkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 24, 2023 at 09:41:22AM +0100, Neil Armstrong wrote:
> This add nodes to support the Khadas TS050 panel on the
> Khadas VIM3 & VIM3L boards.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   |  2 +-
>  arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 74 ++++++++++++++++=
++++++
>  .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts    |  2 +-
>  3 files changed, 76 insertions(+), 2 deletions(-)

Generally, those kind of patches still have value. Now that we are
accepting overlays, could this be converted to one and merged maybe?

Maxime

--4j755csbj5bgclkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWCAfgAKCRDj7w1vZxhR
xS+jAQDMt1rk04cC2Xg84EGUExSHFlcX9BTotBbFO5Zv9W4P/AD+PP2oNqHk906G
kwuJWtCVvyW0H04jWPVuknzUNcmmiQs=
=YClS
-----END PGP SIGNATURE-----

--4j755csbj5bgclkr--
