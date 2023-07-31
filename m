Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BD6769F63
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjGaRWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjGaRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3E1BD6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 833CF6124B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 17:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBBDC433C7;
        Mon, 31 Jul 2023 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690824107;
        bh=kiXzpQqenKMMpnBqTOhAGdvH08lsx7pYXETUBIhe2Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMStE277hRfTz2v7aKoGI8wVqwS9crflOd0yqEEyNHDkj9xfFqxIsaZcNrrgXcJgE
         keq55KuTw25asvxAJabz2TP1UOaKt4Hf/o4xhtfHKQEqtNjIXmcF2dIIZBMBah/0qi
         PNqryFw8cATRFrkBEzQybmHhqgaxRnwjaYLklyNhhpT/cO3TSYIW+5U9cDMAVt6/aT
         uqG19DfuBylTGbTYI6G6nNJTbKnh2mI3cFAPXNH/MqF9K18A9A6sfSwuZf3wk4OOfB
         U2GLtm6QBT4Wi3z0DWoHqgngu0ABekSKbtsbyV9rQWw6kXjsIJvOOiyzILRCZSTNos
         BZeAKEo9aSmJA==
Date:   Mon, 31 Jul 2023 18:21:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 0/1] Intel: sof_rt5682: remove quirk flag
Message-ID: <f87952ee-908c-45c3-bd8c-cad692654634@sirena.org.uk>
References: <20230731103419.2536036-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cNapWE7fzt2N3lOd"
Content-Disposition: inline
In-Reply-To: <20230731103419.2536036-1-brent.lu@intel.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNapWE7fzt2N3lOd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 06:34:18PM +0800, Brent Lu wrote:
> We add a helper function to detect amplifier number according to device i=
nstance
> in ACPI table so the SOF_MAX98390_TWEETER_SPEAKER_PRESENT flag and a dmi =
quirk
> for 4-amplifier configuration could be safely removed.
>=20
> Also refactor the max_98390_hw_params() function to use an array to handl=
e the
> TDM parameter.
>=20
> Amplifier number detection and TDM parameter are tested on two Chromebook=
s. One
> with 2 MAX98390 and one with 4 MAX98390 amplifier.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--cNapWE7fzt2N3lOd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTH7aMACgkQJNaLcl1U
h9CUWgf/ateymIZbZ4zSCmCF40krOpEKI545+7ZSX9VWn3zhMUVGp6EPWNwpsAZR
XSEv64pC2EPySh3510ktC5cxUAOf0k4LDzvkuUbwvbJU2EMWHST9pvuXw2ShamC3
gOL3Uqk8bERAa/UfHWrFa/rqGv29bJUMMG541LMoQgRhy473tZDoFtaMCdZutJqC
Jqy0ZA4+dJQ43KQ0J8qbifjuSkG+jaIxaImOfU7aqeF7UXG7igKe9h88vQkfxWsD
Ym8qlE97uZHoh68W0iL+bPZ1TVVOyftIq651quI2bzbQdeestx1/S+6YjlExHlyi
T4Vej0V2yyG1UGZlTGgKUgC73KSDig==
=5xmf
-----END PGP SIGNATURE-----

--cNapWE7fzt2N3lOd--
