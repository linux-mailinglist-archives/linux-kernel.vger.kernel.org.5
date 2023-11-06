Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E2F7E2327
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjKFNJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjKFNJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:09:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859B91;
        Mon,  6 Nov 2023 05:09:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCC1C433C9;
        Mon,  6 Nov 2023 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699276155;
        bh=TRct+bPBVhdIJ8fTDcuYFeIefcIAth8Jq+4FUbkg2Rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cy2NnDi1q1g4/iMErHjKrKaHtglwhrdGygzy4CqOUboMWBwCAaPF8JhJO0NipzHNf
         SbtGmgeAXmA9UTsV6WqSa0+ePbB3Gt9AAGsfEPr7vsxGqNDy3zmWq4W2FjGukI2wMo
         rJrQHCohvEAl/xMOEdRfnjKLv9MuVdU1nNAMSJvirKtg+ubG0DmU0bLyPr9fK2O2ld
         V8TxHCKol5f1CWdTmYa/CO9bdaGTJItG+7ksG2SAdL8TV1v/RrKCHJH/toFXKQQlAA
         5brKYwd7IL1Cv+/3tQ5Necs/Pr1WqJg6jIVmy0y4hRz12ENY+zLndgOppVBvAi68iY
         +5I1vaPE4hO9g==
Date:   Mon, 6 Nov 2023 13:09:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
Cc:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 -next 5/5] spi: mockup: Add documentation
Message-ID: <ZUjleJPyuaGqtQDv@finisterre.sirena.org.uk>
References: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
 <20231104064650.972687-6-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWV+XuFJO7JKUDO3"
Content-Disposition: inline
In-Reply-To: <20231104064650.972687-6-zhangxiaoxu@huaweicloud.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWV+XuFJO7JKUDO3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 02:46:50PM +0800, Zhang Xiaoxu wrote:
> From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
>=20
> Add documentation for the SPI mockup controller driver.
> This include the tutorial for how to mockup a spi device.
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

Could we also get a kselftest that demonstrates how to use this in an
actually executable form - it could probably just be the tutorial
program from the docs stored somewhere?  That would both help ensure
continuous testing and be a bit easier for people to pick up since it
would show the whole flow rather than assuming knowledge.

--pWV+XuFJO7JKUDO3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVI5XcACgkQJNaLcl1U
h9Chpgf+Jawf/jfjukYlH+HXfPfdQixWmlTDpagtRClXL+5X/Y4FYB7TLYlzkjLT
92w5Ipu9qHZCzNhqjPQEijtm1EZXj//PfUG1k2qFqzn6If6K6Ip9jJSGj0AxOpKN
6T9ARzhFRbxjkarCkd59tFTu7J+lIZpln7sCPl2YhWrN+jctvwfeGmsHP5Nv7ETr
RAcZ7tQEMd/GJ0NZQlg1JiERon+A4aZuooeB7+orV31+NWVhgcIGtD0O3SH2Cxmp
YigtJehEdoFji+GT4XV2X7+xjm46PhDM99O316xiuybTIjPX7E30geXaIdj5NapQ
zMlLkYeZM3Y96RtFrXdCYwwBi9zw7Q==
=xkdR
-----END PGP SIGNATURE-----

--pWV+XuFJO7JKUDO3--
