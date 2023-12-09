Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420FC80B5F5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjLIS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 13:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLIS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 13:58:57 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9DD12E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 10:59:03 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E6EA41C0050; Sat,  9 Dec 2023 19:59:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1702148340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s4H1icGgnVQhjMOKhA81uMGUcmlVZSRUDXxUfVrYhUA=;
        b=PlLWFOo5/3Xm25roKuCnD6EoNfVi3CepIhU8jUQNQjaDttXHOTFGDoo+/fll2MUhja6jRZ
        BjKK0amewyvxgYUQkAEd5yQY90cqXD633LOwEr/L2IFCrfeEyQOOwxTAuksAwBrqkueQmE
        nkQxkbo6XxbDPjwi8eOKFRohoBM7ets=
Date:   Sat, 9 Dec 2023 19:59:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Aaron Gray <aaronngray.lists@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can we please have a major fork of Linux into a modern and
 legacy versions ?
Message-ID: <ZXS49NPio5oLPvit@duo.ucw.cz>
References: <CANkmNDcCX+UwbEjy8Ly7jav9sA=Wark7xFEFdhX-KuR6uOkp-w@mail.gmail.com>
 <ZWJm-6elPNNtbNI5@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0b1j4NNO88Uk+zof"
Content-Disposition: inline
In-Reply-To: <ZWJm-6elPNNtbNI5@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0b1j4NNO88Uk+zof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I hear Linux is going to drop a lot of legacy devices including the
> > ones dropped already. I am wondering if we can please have a major
> > fork of Linux into a modern and legacy versions ?
> >=20
> > With a consolidation and security updates to the older version.
>=20
> If someone wants to take an LTS kernel and volunteer to maintain it,
> including cherrypicking security updates, and making sure that fixes
> in core subsystems don't cause some of these legacy drivers to break,
> anyone can create such a fork.

CIP project is maintaining 4.4 and 4.19 kernels, and will do so for
=2E.. few more years. Our trees are here:
https://gitlab.com/cip-project/

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--0b1j4NNO88Uk+zof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXS49AAKCRAw5/Bqldv6
8hBwAKCtPwzYhYXYQe5+l8aEHqRjsavF+wCcC1OpmjF5SJxl2avuqv1z8QT3kgo=
=6CNN
-----END PGP SIGNATURE-----

--0b1j4NNO88Uk+zof--
