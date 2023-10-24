Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E297D5007
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjJXMmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjJXMmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:42:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B429C90
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:42:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AB4C433C8;
        Tue, 24 Oct 2023 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698151333;
        bh=5lr+pjwvp0zOcTeinONIaVGHup83Xhs/5KopjafIzWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jT/Q06gQwMhmXpCagBElDNMA/5ot1BalmQiWLI6DB9ID59whjQKQaCKm1JrMAKVCB
         oQh+TomXr/VvPjWIzDJZhOvHa8QvvmTDDf8SQOGnWhZMb+XuxoSWFxJzoYfPwt5LhJ
         WiNGScv9mbRQnFgdDMQQDcsV8h3/l8iUsEQ1uo510OFScpZQrroRFfVYuM6KSFHRiX
         qC5n7AQqQJQRn4VMAFumFtTqpmo9DH59WBImCUzPhYCD3F1OM5el7To6V8e6BOwU6e
         4qAxsqJ9xFjY1eLZtMXHQc/tOXL0+Nfzh/gLMaaFazGfLjr6UdkeCjms+EKZv89Nqv
         Sz3zpyz6vhWSw==
Date:   Tue, 24 Oct 2023 13:42:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     13916275206@139.com, ajye_huang@compal.corp-partner.google.com,
        alsa-devel@alsa-project.org, arnd@arndb.de,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, dan.carpenter@linaro.org,
        devicetree@vger.kernel.org, harshit.m.mogalapalli@oracle.com,
        herve.codina@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        sebastian.reichel@collabora.com, shumingf@realtek.com,
        tiwai@suse.com, trix@redhat.com, yijiangtao@awinic.com
Subject: Re: [PATCH V2 3/4] ASoC: codecs: Add code for bin parsing compatible
 with aw88399
Message-ID: <27dd3dfb-7a40-4e26-b8c2-e432c30a0eea@sirena.org.uk>
References: <21bfa0bb-d936-402d-9ca9-6bcf181a0f35@sirena.org.uk>
 <20231024071929.88898-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pL7UoU2fS9tXvDvv"
Content-Disposition: inline
In-Reply-To: <20231024071929.88898-1-wangweidong.a@awinic.com>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pL7UoU2fS9tXvDvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 03:19:28PM +0800, wangweidong.a@awinic.com wrote:

> I generated the patch based on the mainline branch,=20
> Why would there be a conflict? I know that I made a change to
> this file when I committed aw87390 and that=20
> the change was in the Linux-next branch, but the two=20
> changes are in different parts of the file.

I don't know off hand, I didn't check in detail.  It's possible someone
else sent a fix that's been applied and is causing the issue - if you
check out my branch and try to apply the patches hopefully you can
figure out what the problem was.

--pL7UoU2fS9tXvDvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU3u5kACgkQJNaLcl1U
h9Dr6Qf/fdkNinl8wVxXP3U0qwaV15ASSfA38GeqDIqp+FlZSN61aMRCAfgEvI0y
QiJ1yqwLMrQzbWZcss2SnDi3N0J7KAqe3DXDHyH5FGYDxgSpMegLxDojqD6ecoEV
vf25mLtwq6w7/2LHuoJqiPDeE+LARk28dFHrIeAiQAl0NDxBX+Q84heKKbTzf0iC
RxFTOfdtBPxGmm0pyA7bm647VGZ5cqC2Yres0FD+ES20QnEh0lRImX7PY8yCAvyu
ykm+apBEZeKrq27nTFpmG4tNSFh2tCmlPCVhM4O2kGflQ0YHQUa0S8HxrnKiXSRb
2A8LUloo0+K+kEFa6oTbzwdjhOjcGA==
=RVdx
-----END PGP SIGNATURE-----

--pL7UoU2fS9tXvDvv--
