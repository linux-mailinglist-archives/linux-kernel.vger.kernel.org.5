Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD987B86BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjJDRj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjJDRj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:39:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F1EA6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:39:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D07C433C7;
        Wed,  4 Oct 2023 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696441193;
        bh=K/tg8/w4CVZM+MMZbqiJI4I0lw8Qwa2sMwfhdev7ubQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeKoTfCewQffVeEdL4VkIXNCVSD9d9NunmbLsCQ4KZkE5fGE3EzF5s2CJMEFTkFUR
         9+Rp0Lnw0r+oc+Gh5cs7EiGtRjCli4Pt6URVlEReTs6A8YRyKnMlwZuVSsvN5yl8ae
         nXnm9skgJdM3YBXLd0m7/YSlo87hzvKhk8PwH4P4i+Th69UGbjXYVgi82wU+QW8gDS
         TI0fbqAPstYUmGmbBYwsdfYqwZqe7LynkAtCAyxbEKu53rOqqPRSC9TsSL7q66drdJ
         IeRPQWuLX595ZGXfia1I+HXaRR8rGBrwp321J0JJdtnGTVTOmuXonAq7ANk6wMljxf
         w1+um5izaFBhA==
Date:   Wed, 4 Oct 2023 18:39:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>, nuno.sa@analog.com,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kiseok Jo <kiseok.jo@irondevice.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Ban Tao <fengzheng923@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 1/5] ASoC: Explicitly include correct DT includes
Message-ID: <72f8f521-93f0-4e3d-929c-f7478622ddb3@sirena.org.uk>
References: <20231004-dt-asoc-header-cleanups-v2-0-e77765080cbc@kernel.org>
 <20231004-dt-asoc-header-cleanups-v2-1-e77765080cbc@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K1Dh/zQH53UxpeTH"
Content-Disposition: inline
In-Reply-To: <20231004-dt-asoc-header-cleanups-v2-1-e77765080cbc@kernel.org>
X-Cookie: I thought YOU silenced the guard!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K1Dh/zQH53UxpeTH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 10:58:05AM -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.

This is breaking various builds for me, for example arm64 defconfig:

/build/stage/linux/sound/soc/rockchip/rockchip_i2s_tdm.c: In function =E2=
=80=98rockchip_i2s_tdm_probe=E2=80=99:
/build/stage/linux/sound/soc/rockchip/rockchip_i2s_tdm.c:1557:17: error: im=
plicit declaration of function =E2=80=98of_match_device=E2=80=99; did you m=
ean =E2=80=98of_match_node=E2=80=99? [-Werror=3Dimplicit-function-declarati=
on]
 1557 |         of_id =3D of_match_device(rockchip_i2s_tdm_match, &pdev->de=
v);
      |                 ^~~~~~~~~~~~~~~
      |                 of_match_node
/build/stage/linux/sound/soc/rockchip/rockchip_i2s_tdm.c:1557:15: warning: =
assignment to =E2=80=98const struct of_device_id *=E2=80=99 from =E2=80=98i=
nt=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
 1557 |         of_id =3D of_match_device(rockchip_i2s_tdm_match, &pdev->de=
v);
      |               ^
/build/stage/linux/sound/soc/tegra/tegra210_amx.c: In function =E2=80=98teg=
ra210_amx_platform_probe=E2=80=99:
/build/stage/linux/sound/soc/tegra/tegra210_amx.c:541:17: error: implicit d=
eclaration of function =E2=80=98of_match_device=E2=80=99; did you mean =E2=
=80=98of_match_node=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  541 |         match =3D of_match_device(tegra210_amx_of_match, dev);
      |                 ^~~~~~~~~~~~~~~
      |                 of_match_node
/build/stage/linux/sound/soc/tegra/tegra210_amx.c:541:15: warning: assignme=
nt to =E2=80=98const struct of_device_id *=E2=80=99 from =E2=80=98int=E2=80=
=99 makes pointer from integer without a cast [-Wint-conversion]
  541 |         match =3D of_match_device(tegra210_amx_of_match, dev);
      |               ^
cc1: some warnings being treated as errors

multi_v7_defconfig is also broken.

--K1Dh/zQH53UxpeTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUdo10ACgkQJNaLcl1U
h9Cx8gf/XCPMEtGS0YkOT48jnbRA+1YlgQJR8uZlu9+gze7VMTlA1QqBf04fiiA9
I6p4yAWbk8inm8rqWm9T75tCz/xi0cZrcoQHPEFGYgneMyXkkoapTGe/PQbR9ZIT
grUfha4+oIa2oZXQjYL1tV3U/hfjGjRG6dPR9n+92qlgwLfwdMUhOy7Nn752+xHF
f6Igs59sXl5kvZTQVUb7Hkt9jfkBRz3QfUWiYcp9bJCblkEv9tWhi1YgLua+fUQY
VjxE2e4zNB+Z2z3A9zlFKhTB/9yBIaRma+Qp3PElEYmsQQry9nRssA/aXS5Jccon
7fWLNWj6wDBzZjKCwf69j2cORg/HHw==
=RFjB
-----END PGP SIGNATURE-----

--K1Dh/zQH53UxpeTH--
