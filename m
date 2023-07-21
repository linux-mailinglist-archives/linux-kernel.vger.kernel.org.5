Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33F875CAAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGUOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjGUOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B267BF0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43E1261BAF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194B3C433C8;
        Fri, 21 Jul 2023 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689951176;
        bh=vtVnGZ2RXU7NehUk7NlLf6nLv5bc76kKbS+lg0mNhAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4MCcDGu+tle/EKitSAd6aNWqwdiFz5TnRVkvMjCjiic6g1O1LfXvWXYyIRY8U3Hr
         xrhLZydTd65mnGz5ZcdDSgrVDHjDuGlsY04T+k3dpTTjT040IA03dHZg+zxDD0u7zv
         IkneHQ0WfLmoF3kF2opepCA83Own+drVh6+LqDKce+SOeoi6SVo7ytVnv3ZYTQap/a
         0GPD0qu3eLtWvsCCb8NUjvJfZ0BEtMXhnu/xQwbMjpAQ1xROuXFlBhoa2dYbEgdoBK
         7fDzhnzQiQpXzXmkXsEr3PPNhjjEnWWFGtCFBpQ7YgczmN7siLfOKJ2waHGSOkwnOt
         0mqlfmFEj1vbA==
Date:   Fri, 21 Jul 2023 15:52:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v5 00/11] ALSA: hda: Adding support for CS35L56 on HDA
 systems
Message-ID: <d7f96ecc-3900-4149-94b4-8bf96dc0728c@sirena.org.uk>
References: <20230721132120.5523-1-rf@opensource.cirrus.com>
 <87bkg5z5c4.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n0NYlQtDrz93hsxo"
Content-Disposition: inline
In-Reply-To: <87bkg5z5c4.wl-tiwai@suse.de>
X-Cookie: Do, or do not
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n0NYlQtDrz93hsxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 21, 2023 at 04:50:35PM +0200, Takashi Iwai wrote:
> Richard Fitzgerald wrote:

> > Changes are trivial so I have carried forward Mark's and Takashi's acks.

> Mark, I suppose it's fine to take all of those to my sound.git tree?

Should be.  Might be handy to have a branch to pull from in case of
conflicts I guess but probably not essential?

--n0NYlQtDrz93hsxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS6m8MACgkQJNaLcl1U
h9C3TAf+O4sNPx4efX134iRtM5GDWQTtPtEpS60ujm6bSTONrcvy4zyNcY5UOfR4
oyQP5xl1PgBJKhUwOqjwYvE4g6ZlJPt5YXOjIYdUZNm+OO+cM+3tVv2blewpqsVx
c3ca4p4KBJS8FGBJIIOiK5k8vwLLwW+o3zJVuDB/W6rZurTKBE6Ph9GyL/YLsx0f
v3efNtm3EoSXFp+LwVOxPbc48IbpA08bZhv+31KKZqeoeEQhMmHl55eRfr4V+Lwn
JAslTfEfn1oJUKrCUWKZ/xEzKkTo0m4l5ialNdxboLly/vHV/KYFgRyIxJavwn5g
8/IAOdFKdAQ7HewGdFExz2T7dpH2jg==
=NcQm
-----END PGP SIGNATURE-----

--n0NYlQtDrz93hsxo--
