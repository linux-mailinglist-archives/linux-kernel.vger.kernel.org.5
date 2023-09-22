Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E3B7AB3B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjIVObN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjIVObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:31:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E478319B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:31:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99ADC433C8;
        Fri, 22 Sep 2023 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695393061;
        bh=+/eXrMbjo9AYUje7C8sHSUC5rVwhb/5kqN65KjNA98o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bX7AfFwTfpiTS9a459g8HxQKG5NcBLT2GV8e1Vv+h5S2zF6aOxajjcJtIQiZVqK/T
         wlbDQQSAqkEoWhokbsqXTpszdQeHzeM2H0C72yI0cyAlsVOv8Q4GAFZcxp6LBNuNWH
         uefyI2g/suqUqJ2Qj81D5dFTP0jE/ytoDL5+BvS4Q5mEgUEiIXN/J0NeCyFtdWYD5E
         Z4yrbR5mhzujZqLl2HgbBKKYuPjl8BFZIhNQ8kb/KpckIfr1GNTuV9QPLacMWMa+db
         dc/bo5/1ItwAwMTJ+aQ6jrjgqVGM3uci+Uzi22f7mH3fgNjwNMs6r86K97QOIjSjlz
         ZmOVhX6TnAcsQ==
Date:   Fri, 22 Sep 2023 15:30:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v1 2/2] ALSA: cs35l41: Fix for old systems which do not
 support command
Message-ID: <c484d680-f000-4eea-88a1-7816749c92c4@sirena.org.uk>
References: <20230922142818.2021103-1-sbinding@opensource.cirrus.com>
 <20230922142818.2021103-3-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wyZdhTYzmwaa4UCO"
Content-Disposition: inline
In-Reply-To: <20230922142818.2021103-3-sbinding@opensource.cirrus.com>
X-Cookie: A day without sunshine is like night.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wyZdhTYzmwaa4UCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 22, 2023 at 03:28:18PM +0100, Stefan Binding wrote:
> Some older laptops using cs35l41 use firmware which does not support
> the CSPL_MBOX_CMD_SPK_OUT_ENABLE command.
> Firmware versions v0.28.0 and older do not support this command.

Acked-by: Mark Brown <broonie@kernel.org>

--wyZdhTYzmwaa4UCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUNpR8ACgkQJNaLcl1U
h9A4agf/co+S2ZofqO0cRimwQbeFCeWFmyn1SgSNWuDgQIqcT+s6NwDhz4yztkxQ
M/4O2nwOi6Nj1YtMClU/QdF1nRB8/b+W/P8H0nt+e3+SAVI1jjBL7m3zCXptyKrV
xyzl1aC7tHiSMvaRYgxEKTDz1B8Qg6ONTCqGR18sRv1XWn9f9jQAnd+dU+fkT0J+
N6zChy/LLNVe2Z3hK/fq388C34qbjcKaiFvSflc1fI1aKIo2ynQR3IJTw0cLof2Q
+s9oonRNQaoHoQt5CXYH3UpyT7WStA/hMUtHXUzFrO51yx5TIHk2JCbqQx+rUsS3
TMTG2TPbiXdbe7tU58d2UhRwe/S9hQ==
=aP6q
-----END PGP SIGNATURE-----

--wyZdhTYzmwaa4UCO--
