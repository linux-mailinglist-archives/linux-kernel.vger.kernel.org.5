Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7AF7EAC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjKNJGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:06:43 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A7FA;
        Tue, 14 Nov 2023 01:06:38 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B2CB41C0050; Tue, 14 Nov 2023 10:06:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1699952796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XH1nNm8LsiTPOr9BH1J3Bya0FX6aY6ioAnkuYCu5cYo=;
        b=c9ZOPsWKeaekqtoseBVTpiwIiQQ7fkD9pKy4hY1yA/8HzCxaxuDA7AzWUF8ohHrHVgkXGY
        2qOXXkszJG2HOROfc2ecPFqIKlenTrP0oejXMsG+oCaKVl+fD/4nKQGLaUj3lJz/S82PTN
        bAjKJrIyp8cILOUrHnDIEwbPJGh50JQ=
Date:   Tue, 14 Nov 2023 10:06:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alvin.zhuge@gmail.com, renzhamin@gmail.com, kelvie@kelvie.ca,
        Raul Rangel <rrangel@google.com>
Subject: Re: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
Message-ID: <ZVM4nFaDTwrKMr8K@duo.ucw.cz>
References: <20231106162310.85711-1-mario.limonciello@amd.com>
 <CAHQZ30DP8ED4g3bib-tZ53rm2q2_ouEEL3TxD-SgK4YrCe3bew@mail.gmail.com>
 <d55a80f7-ca4d-406f-b2c8-b2bba45e3104@amd.com>
 <20231113223819fb469198@mail.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="U4Vrkl1KF0W4hmrr"
Content-Disposition: inline
In-Reply-To: <20231113223819fb469198@mail.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U4Vrkl1KF0W4hmrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2023-11-13 23:38:19, Alexandre Belloni wrote:
> On 13/11/2023 15:36:28-0600, Mario Limonciello wrote:
> > Now that the merge window is over, can this be picked up?
> >=20
>=20
> I'd be happy to invoice AMD so they get a quick response time.

That is a really bad joke.
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--U4Vrkl1KF0W4hmrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZVM4nAAKCRAw5/Bqldv6
8viOAJ0R6umVNflD+5mocMd90SFnUq6jcgCeOl/w6uEJ66JALPpzM9ts0iEHVuw=
=MFhy
-----END PGP SIGNATURE-----

--U4Vrkl1KF0W4hmrr--
