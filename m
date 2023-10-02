Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E697B5667
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbjJBPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbjJBPLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:11:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A79011B;
        Mon,  2 Oct 2023 08:11:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3D6C433CC;
        Mon,  2 Oct 2023 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696259465;
        bh=41XksM9CbEPqnvNa0ISp/vSRlLbz+4PKhMb7S1TUSAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a43GUsTcxLVVQlHP1srhc2Ta0b4OZ7SBq6c8jNRGjOA2nNhqTttwcPgjv+EoY/Sk/
         yuU1euPuMJiWOF6SETfeCcw1cc8r/8avOGUxhhtN4wPRiADHbUQEgR8CxuJfITlA2R
         ScIpIVFfEEeaf82zyLCD6ASkOPMJxrXYlWhg5QwNGm9kfTgKjsl7rwye31fIXyM09r
         UzXdWWqnhyyq/Yp1B9TAlMxHZhPtA6mZ2KC7nWk2qlRY8Ino/PI4lwr06wWkOhVdEy
         mGTzbGJBCBQEsngu82ZsBn2uNQA7gNf5bHCExLim85xh2RZQuNetq3T86ZfIQSr7Lx
         8J34ttjE2jGWQ==
Date:   Mon, 2 Oct 2023 16:10:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v5 00/11] Add audio support in v4l2 framework
Message-ID: <2599f388-51a0-4ecc-9f36-b72d96466dfa@sirena.org.uk>
References: <1695891619-32393-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XveoJAUVdjo3FpSQ"
Content-Disposition: inline
In-Reply-To: <1695891619-32393-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Postage will be paid by addressee.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XveoJAUVdjo3FpSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 28, 2023 at 05:00:08PM +0800, Shengjiu Wang wrote:
> Audio signal processing also has the requirement for memory to
> memory similar as Video.

> This asrc memory to memory (memory ->asrc->memory) case is a non
> real time use case.

Other than the naming thing I sent in reply to one of the patches the
ASoC bits look fine.

--XveoJAUVdjo3FpSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUa3YIACgkQJNaLcl1U
h9C9gwf+OHN5aL0Hw/La5WvbqbDYD50xGPRZAiEzHEhxU7t3oB7XRmUGKpAcNp6B
9Gg7xSnez9mmtrqUNNeptqdDTo6KYgdKF0gkoYUMdjA6rwmvBJ4sxs+vv1lRjIT9
8Q2l8jlRl0fFxmRqP6nmKxUPuS6p0m2ZUWU0CbRNiKMdPkGUnHpVpm7jIaXHAy6O
y4J8OrVpC/goCfRANXcrtz7DACV60ihbwMMED6dUZV7xg8ruXAw/cK2kJWqlsTjx
T5bEQxOsCPV3TWM1Gr7BHANCQj/Azzb3XTvMUin+y1PJaHU60qLRROcVDN9V7YaW
qm4fbNobVVMaG1EnsmYguD/bS85naw==
=grt1
-----END PGP SIGNATURE-----

--XveoJAUVdjo3FpSQ--
