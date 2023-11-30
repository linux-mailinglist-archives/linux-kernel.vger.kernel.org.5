Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE87E7FEC9E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjK3KNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjK3KNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:13:33 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66BC10C2;
        Thu, 30 Nov 2023 02:13:38 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1E1901C0050; Thu, 30 Nov 2023 11:13:36 +0100 (CET)
Date:   Thu, 30 Nov 2023 11:13:35 +0100
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
Subject: Re: [ANNOUNCE] 6.1.59-rt16
Message-ID: <ZWhgT8s2BDZ566F6@duo.ucw.cz>
References: <169783215859.257534.17071765559550518745@demetrius>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9vwCjjQE29mdy/7N"
Content-Disposition: inline
In-Reply-To: <169783215859.257534.17071765559550518745@demetrius>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9vwCjjQE29mdy/7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 6.1.59-rt16 stable release.

We'd like to -cip-rt release "soon", so I'd like to ask what are the
chances of -rt release in next week or so?

Thanks and best regards,
         	     	     	     	     	      	     	    Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9vwCjjQE29mdy/7N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWhgTwAKCRAw5/Bqldv6
8iVDAJ4vYeGPz3uPsl2REXiucUYK6R12HQCcDDAb0oMdFHK2Q62qKHCknNYt1PM=
=N3+l
-----END PGP SIGNATURE-----

--9vwCjjQE29mdy/7N--
