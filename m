Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB50A7D3684
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjJWM3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:29:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC99AC4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:29:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B3DC433C7;
        Mon, 23 Oct 2023 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698064153;
        bh=9p0AntcfbOKVuz+XGkFoDt43sFlFjI4w0DiNbSxTxHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T95jzUUffCVGKFhalCFOb3kmXNlmWGvOqolVd0L+7uAjMX0CXHdAeSg7iPHiQCv6b
         XiDAsKRUp1fwZ9uurXiIFh14DPgoM9ht1G5am2BqVeNaki82nLZMdwttRex6D55zHX
         1kQxMG7BgXkhZpipvIV8hKqTH/cm7rSPk78XmSFdcN5CRvxGyHwx+5L4a8JpjC/fYg
         FCowMNLrp/S3jFHkEYZQwkbGo4WzfjimgX7w0ZLvfzmtgU3KulDSV4DnBdA7P7YSpi
         6dF27XjIDcsKFfo/CSe3ubV0DR9UpwQV29kkO2nuw4vqcTr94MTVPP9dDkB1KP4KzT
         LLFQ7E5MFjnPA==
Date:   Mon, 23 Oct 2023 13:29:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, herve.codina@bootlin.com,
        ckeepax@opensource.cirrus.com, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com,
        ajye_huang@compal.corp-partner.google.com,
        harshit.m.mogalapalli@oracle.com, arnd@arndb.de,
        colin.i.king@gmail.com, dan.carpenter@linaro.org, trix@redhat.com,
        liweilei@awinic.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yijiangtao@awinic.com
Subject: Re: [PATCH V2 3/4] ASoC: codecs: Add code for bin parsing compatible
 with aw88399
Message-ID: <21bfa0bb-d936-402d-9ca9-6bcf181a0f35@sirena.org.uk>
References: <20231020083426.302925-1-wangweidong.a@awinic.com>
 <20231020083426.302925-4-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="epJqc3ICM0Spx94I"
Content-Disposition: inline
In-Reply-To: <20231020083426.302925-4-wangweidong.a@awinic.com>
X-Cookie: Disc space -- the final frontier!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--epJqc3ICM0Spx94I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 04:34:25PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
>=20
> Add aw88399 compatible code to the aw88395_lib.c file
> so that it can parse aw88399's bin file.

This doesn't apply against current code, please check and resend:

Applying: ASoC: codecs: Add code for bin parsing compatible with aw88399
Using index info to reconstruct a base tree...
M	sound/soc/codecs/aw88395/aw88395_lib.c
M	sound/soc/codecs/aw88395/aw88395_reg.h
Falling back to patching base and 3-way merge...
Auto-merging sound/soc/codecs/aw88395/aw88395_reg.h
Auto-merging sound/soc/codecs/aw88395/aw88395_lib.c


--epJqc3ICM0Spx94I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU2Zw4ACgkQJNaLcl1U
h9BRnQf/e8OI4BUyMbll1FxLsSxKd/uMEJW3/Q3iIKUHcY3Co+mV/dNXbJquzZxc
y5A628DP72PFoSSttDaeD+ryG7L+IVViXyr2qieCq134de1NapdIijs9D3h+hRqm
aQ1N+FeXiuXSIz6tVfHQz4gO+zSUZtKXJCxpCDMPzpOCVeULps1wtnjNBjiXa+AZ
OHnjTZxWN9uB4RvF8uQfZetE8IYKzdHnqb4KJqXzBjb6XE6aFBCFuGFuntsJw4bC
X/mex6L1MZj051V77HufhwgRv9NOZj2jLGdHws9Lj6efK63c1mGsYgXSXVFc+PBu
tOjCez7YLOQ1TCSgxDDjo+JAYkpbKw==
=eJ2K
-----END PGP SIGNATURE-----

--epJqc3ICM0Spx94I--
