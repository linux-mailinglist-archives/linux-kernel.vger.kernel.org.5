Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6B79B97A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355922AbjIKWCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjIKJvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:47 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCA9E43;
        Mon, 11 Sep 2023 02:51:42 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 347ED1C0006; Mon, 11 Sep 2023 11:51:41 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:51:40 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
        broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
        bradynorander@gmail.com, muralidhar.reddy@intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.10 4/9] ALSA: hda: intel-dsp-cfg: use common
 include for MeteorLake
Message-ID: <ZP7jLFodE0ndbQB3@duo.ucw.cz>
References: <20230908193611.3463821-1-sashal@kernel.org>
 <20230908193611.3463821-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="52UtXH6MR9bvNHUJ"
Content-Disposition: inline
In-Reply-To: <20230908193611.3463821-4-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--52UtXH6MR9bvNHUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> [ Upstream commit 73e6ebf6a21a62429282632eccb8aa4212489b3c ]
>=20
> This was not updated in Commit 0cd0a7c2c599 ("ALSA: intel-dsp-config: Con=
vert to PCI device IDs defines")
>

AFAICT, this is not queued to 6.1. What went wrong here?

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--52UtXH6MR9bvNHUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7jLAAKCRAw5/Bqldv6
8p3LAJ0Y2mNhL7Pv9gNoBfHQQzAl2WdHVwCgnSksuS4IOjpz5h8cnmjbWsfB6E0=
=vvQu
-----END PGP SIGNATURE-----

--52UtXH6MR9bvNHUJ--
