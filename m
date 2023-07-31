Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE017699FB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjGaOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGaOq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D795111B;
        Mon, 31 Jul 2023 07:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B3E761172;
        Mon, 31 Jul 2023 14:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDC9C433C7;
        Mon, 31 Jul 2023 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690814817;
        bh=PqlYAMnZ+JfeuRXdftAEQ5hSDtUAYpYdfgTVGuT3sEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwBcAZY0NKbmJ5/K/4M5wt/q/Snl9MV8edbQpaIhW2ZSTntBQ5f77YrshzZRcfM+e
         +F4hKqaNsjLncLgFqOvZfW0HTRgOF62Qj+B0thqCeMAO1sC0HScYVmGQXi9sCw3tlE
         jNdt632W55A8xLfTP6hJe+b2z/6VkX4dsVXfN58691SetbITwgu8P2d5JsmecepkZz
         cbcedP4GmD28lPvBAMgkr2cFU2ZZcTFJtp2TaoRVBUJEdVolw+8kdcbqOCBPDUY1vj
         3eHpHAdbQdsOklnI7ZBoCcTqoia9YDAlfoAXiwlUaTTTfyYYY6J2NrnAvZbstdDn8M
         XABBzcl7BB2VQ==
Date:   Mon, 31 Jul 2023 15:46:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 01/12] ASoC: dt-bindings: amlogic,gx-sound-card: correct
 maxItems constraints
Message-ID: <076d8a7d-8369-4e88-9997-d54b91b7920d@sirena.org.uk>
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-2-krzysztof.kozlowski@linaro.org>
 <1jr0oowg6m.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hTgg8DCib5JQmztO"
Content-Disposition: inline
In-Reply-To: <1jr0oowg6m.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hTgg8DCib5JQmztO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2023 at 11:52:53AM +0200, Jerome Brunet wrote:

> The upper limit of 8 might work now but is very likely to be wrong for
> the next device to come.

> Is there way to correctly describe this "pair" contraint with DT schema ?

> If not, then I guess the most adequate solution is to drop minItems and
> give no bound, like simple-card is doing for the same type of properties.

> Same goes for the audio-widgets property

Right, dropping minItems seems better than pulling a maxItems out of
thin air.

--hTgg8DCib5JQmztO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTHyVgACgkQJNaLcl1U
h9CwBgf9GKwK7KuMoeQQsc9Rl6Sc5X+7lsuk+17rjQr+cd3VJNRkXwkjGCYVxgeP
X6JVUsaKujgeRg/hH9ICfqh0FPemGcEpBh23RVIalVSMA8XZZMGzqwsUw4HUinch
cMfTWev5z6ga9lBwr0CclsNVXu/JYkQXKWPBk3vIYH6sTGwblalUI5AbB6WlwH3F
uzJ7ejviucxNzfnFYheFgckbVJ2MIM+IC4WESBp+Cychr+veWiyr9bihzgSe/9f5
dwEhwsZzQAXdxL6eh5P/shLLT2qHgRFiDfKL101YuzqFSze8ZWSsZ/7Xd0GEkzQa
OF73R/jk4LKgIilX+yNwWW545Ynefw==
=iYq3
-----END PGP SIGNATURE-----

--hTgg8DCib5JQmztO--
