Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454CD7B36BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjI2PZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjI2PZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D3CD6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:25:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F0FC433C7;
        Fri, 29 Sep 2023 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696001128;
        bh=zR3V39FUOXpDJZX+fcXic0O2fzgMBC+hizqSI52SM+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raNcOeAP+3T8q5itobNnfQzGZodlhmfufngy0pt74/+sP7smAxMCkRkquKoPhJ8oH
         l2HRX3hCJN7FAxdaZRt0/7k3pKWACWvwFibCjq2a9G8XDAoPQVGhGV6R3AmSGJjcOO
         G14QPDMELVKzgoooGk2Nj+N85rUhN7uylPvlQBg/81oOPbpQuq77krausidgIQbCoa
         sFIgaKO9rrzQaJabcVR5Zy0nhRc0fgmfX6tc13DW2TNHGGTxNhp4BVDFpfBJrGrOZ+
         MMdWVpAGeked2HEmGQLOGD+vtPNw0nx5KlKfHzamSg0QzRz8rL1xl04RvFMpzxTU+A
         Y0QXaZ4/FiwNQ==
Date:   Fri, 29 Sep 2023 17:25:26 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v5 00/12] sound: Use -EPROBE_DEFER instead of i915 module
 loading.
Message-ID: <ZRbsZmjnR3hfsr3N@finisterre.sirena.org.uk>
References: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A0XDTaLZBAdeh9YB"
Content-Disposition: inline
In-Reply-To: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A0XDTaLZBAdeh9YB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 29, 2023 at 04:51:14PM +0200, Maarten Lankhorst wrote:

>   ASoC/SOF/core: Ensure sof_ops_free() is still called when probe never
>     ran.
>   ASoC: SOF: Intel: Move binding to display driver outside of deferred
>     probe
>   ASoC: SOF: core: Add probe_early and remove_late callbacks
>   ASoC: SOF: Intel: hda: start splitting the probe

The subject line styles aren't consistent within the series here.

--A0XDTaLZBAdeh9YB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUW7GUACgkQJNaLcl1U
h9AnUwgAhkSLp+kvd8MgYHfmPYIFUUhZBZQRkcIQIqKSWYl6JEIdZ1alxsCsbLsQ
bLr4HT6V+0HukhLfCwbFCk/oL2R+dhrxz/s1lLANnVdQd7sZ9qsmpj3FRV2TFnpM
pKL0z8mJF3mHV9z1k5KxcJO91VnBQE+0o+P3GkYAJA4P++kOD++2+HX3k59Z+WM5
TKsYQ/7y89Y7XThCqJclbyGgp9rOz/JLblfdMvtUhP3hgzjDxd25md+L8v6BHmIR
0fHrppNupGzgB1095PW/uFB9v8bXDsgHKRMvc7n0nO7RJ23h2w9Vx84b/G2LYBNe
dH331KjnIx7FUlLcTb71hXlpPXotbg==
=cs2R
-----END PGP SIGNATURE-----

--A0XDTaLZBAdeh9YB--
