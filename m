Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1A802661
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjLCSrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCSrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:47:12 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ABADA;
        Sun,  3 Dec 2023 10:47:17 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BBC151C006F; Sun,  3 Dec 2023 19:47:14 +0100 (CET)
Date:   Sun, 3 Dec 2023 19:47:14 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Clark Williams <williams@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Pavel Machek <pavel@denx.de>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Re: [ANNOUNCE] 6.1.64-rt17
Message-ID: <ZWzNMjnF4NgNoKTu@duo.ucw.cz>
References: <170147003175.315432.12322961896739098066@demetrius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="otRBZchght9PPm+Z"
Content-Disposition: inline
In-Reply-To: <170147003175.315432.12322961896739098066@demetrius>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--otRBZchght9PPm+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 6.1.64-rt17 stable release.
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v6.1-rt
>   Head SHA1: 10278c5eac700351db2dbfcce88be2df51725931

Thanks a lot, perfect timing and made my life easier.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--otRBZchght9PPm+Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWzNMgAKCRAw5/Bqldv6
8rHxAJoDk030JPpDySEGISF17uV4iqK1LgCfX14sondzZnIg3de8DiE1uoMgy2I=
=VU4F
-----END PGP SIGNATURE-----

--otRBZchght9PPm+Z--
