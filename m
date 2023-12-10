Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8E80BB81
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 15:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjLJOBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 09:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJOBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 09:01:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7EAF1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 06:01:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81C1C433C7;
        Sun, 10 Dec 2023 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702216886;
        bh=vwsPeST9hIcjEZYqHc5Ghu/ipmiE95comqHSPct4YBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/VK41U6lamQs5PwYc88weGzfWfeVoVjYba6H6N7VAnI90XjgRdDjg4qoUC9XCGuz
         x6gSkBS5hAPTdPErw5HH341qC0jpspyiHcLGJJwP6LuqSYY308lcIdXnViN1fe/TV4
         eRPg/GR+BaN/XXvDCIawfIW5bCLk6J2IW44zIb1E+uKbLbiLqpRON85zzwDq+5SrKE
         gjedt06RJ6iIL4V9uwEP1h6OyNOpbSaDhf8TAhWo/akR1IB//WZZWFSGSAMhQq0/hm
         YPOPH/VdQOmi7hGrfQkBXtEtl86VPB9FghlftZF0SaYBboKxcyvoZa6pRQ3RaF2Zcn
         VgpPCv3VejQaQ==
Date:   Sun, 10 Dec 2023 14:01:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: Re: [PATCH 11/11] ASoC: SOF: topology: Add new DAI type entry for
 SOF_DAI_AMD_BT
Message-ID: <ZXXEsyBUCrBULNgk@finisterre.sirena.org.uk>
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-12-cristian.ciocaltea@collabora.com>
 <fad8a055-eabb-4087-94d5-9e1de00933e4@amd.com>
 <aa830670-e544-43a2-9ba9-a64f1964a9f5@collabora.com>
 <318470ce-1631-4c46-b425-755c877dda65@amd.com>
 <421128f7-6a17-4be9-a72b-272ea4017fbd@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oreos5sKtpBo0N/Z"
Content-Disposition: inline
In-Reply-To: <421128f7-6a17-4be9-a72b-272ea4017fbd@collabora.com>
X-Cookie: You might have mail.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oreos5sKtpBo0N/Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 10, 2023 at 12:12:53PM +0200, Cristian Ciocaltea wrote:
> On 12/10/23 11:51, Venkata Prasad Potturu wrote:

> > This should send to SOF git repo for rewiew, once SOF reviewers approved
> > this, again need to send to broonie git.
> > All the changes in sound/soc/sof/ path should go to SOF git.

> Unfortunately I'm not familiar with the SOF dev workflow. So it's not
> enough to have this patch cc-ed to sound-open-firmware@alsa-project.org?

The SOF people basically do their own thing in github at

   https://github.com/thesofproject/linux

with a github workflow and submit their patches upstream in batches a
few times a release, however my understanding is that their workflow can
cope with things going in directly upstream as well.

--Oreos5sKtpBo0N/Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV1xLIACgkQJNaLcl1U
h9CoTwf8Dwnj2+UjtYHJuIbJnCxMg7GhXck/1rPcY4inJ4bbew1s67PLh9CPuwrv
lsjre54uKUtGLt/7qlrfeZABNe0CnlAEKN/qQCMjzPe1uTqDnN8+NMb2uiUTezTd
IivcXTjRaV502TmPmiIXTIXSfPgk3OAmNFBn4J5Pkxb5wTMO+KGbLU+xfqRYlAJi
dzVC56UGPXpx2XHv9rbBx5/fhizsgEFrrVwnzJlr6376JDUd27yRP3Ew6n2hgJhk
vFkeFMinSViAB0VmBDgTqjTMTpURbt7TqYOLY1Pj23+JEM1YAt1y7AX81ILA0SEC
E8YS2bDRqva7ez7lA2Z8ktcmq+TstA==
=S5Ee
-----END PGP SIGNATURE-----

--Oreos5sKtpBo0N/Z--
