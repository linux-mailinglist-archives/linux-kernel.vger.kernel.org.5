Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172B57DAB58
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 08:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjJ2HUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 03:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2HUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 03:20:44 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB1C9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 00:20:42 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id ED4A31C0070; Sun, 29 Oct 2023 08:20:40 +0100 (CET)
Date:   Sun, 29 Oct 2023 08:20:40 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] This is continued work on Samsung S9(SM-9600)
 starqltechn
Message-ID: <ZT4HyA3IocyDub26@duo.ucw.cz>
References: <20231018123033.301005-1-dsankouski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/Rp9Sdcbvclk4qN8"
Content-Disposition: inline
In-Reply-To: <20231018123033.301005-1-dsankouski@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Rp9Sdcbvclk4qN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> - Samsung s2dos05 pmic driver added
> - touchscreen support
> - usb 2.0 support
> - some cleanup

get-maintainer.pl should tell you who to cc.

Please cc: phone-devel with phone stuff.

Best regards,
						Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/Rp9Sdcbvclk4qN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZT4HyAAKCRAw5/Bqldv6
8gkIAJwNzW+3Sx2Rub/1mRN+PL222eWOkgCeLD+wzCRSwjFPU1b4LeO0CNO0ATM=
=4liX
-----END PGP SIGNATURE-----

--/Rp9Sdcbvclk4qN8--
