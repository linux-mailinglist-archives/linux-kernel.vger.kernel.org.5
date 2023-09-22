Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103AE7AB3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjIVOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjIVOij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:38:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C91196
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:38:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ACEC433C9;
        Fri, 22 Sep 2023 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695393513;
        bh=nu2Nh17EGEHtjLlysjdCrl2hh2gT/i57l3ZdUM7YoCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dywcCfo2kUQ6KP/vdMFgOUlIqpACI1QlIkNzRLoVK8Wr0mUzcoqSuTX6mYbinFPxK
         QUKdhdp4WAY0+aE0jX6CmPf9WVDDBE9bEsa8LUiShvx2POARoKKRGY8KFG9aNM8sUF
         fcH4DbG7cY9IX3pFmUqk9l5oJRjpEijpBKXgEHUo3CUe4Jp+dDfZe8ffgvmjX/IvxH
         n3yUskuqfAZ6y0qsVuur3a8eXr8VYjZnKugUBYIOCBgN92XrgT8Rda4nhF9GrdTKgZ
         +U0YBVcsW/731OH7ZdvVTUHPySBF/FzPjLkTtrT8aV3GBGUX82LBl8ZEOTYkS+KoG2
         u8MFGhRmcROnA==
Date:   Fri, 22 Sep 2023 15:38:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v1 0/2] ALSA: cs35l41: prevent old firmwares using
 unsupported commands
Message-ID: <8b5a22bf-73e3-45ca-b61b-38482c9caa39@sirena.org.uk>
References: <20230922142818.2021103-1-sbinding@opensource.cirrus.com>
 <87a5tecm2m.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RfXcTh4xSBI3kSn3"
Content-Disposition: inline
In-Reply-To: <87a5tecm2m.wl-tiwai@suse.de>
X-Cookie: A day without sunshine is like night.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RfXcTh4xSBI3kSn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 22, 2023 at 04:35:45PM +0200, Takashi Iwai wrote:
> Stefan Binding wrote:

> > This chain is based on Mark's branch, since the api change was made to

The term is patch series.

> > the function in sound/soc/codecs/cs35l41-lib.c.

> I'd need a PR from Mark before applying those, then.

Or if they're 6.7 stuff I guess I could just carry them.

--RfXcTh4xSBI3kSn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUNpuMACgkQJNaLcl1U
h9D7Twf/ZXKN0Y1+6CsKbyzCCUflbuc4f0xqnwrdlm5+qVb6CCFBFQfc82pLbjdw
1qzTJX7B7pUsFnsh/2YkED/3vvjN7ztFpi9gL4CZlVJcktHB1/ta3l29q5+4MiqW
VcHkIrq7O9dg8UF4+6nzyoUfn+zXg9i8fVziNF9rayHvuAgja9lUxWqXQhBucEkF
y16T9wUDf9UvpeJ7QyPIP8OY97n5kQ3+vfQxjGzk5PZjBmKTgPKvSrPU6seyc5Zw
j2A9vQMproks4qlvOcMuE5pdIM+Y2GhENZL0/++NuQDQ9jfSgyE9iwQ3Qm4aW9ST
ZD2u2VVxcWXww3XdjdwMBhJNA2O/bw==
=EMl+
-----END PGP SIGNATURE-----

--RfXcTh4xSBI3kSn3--
