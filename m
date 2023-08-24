Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A24787B53
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbjHXWQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243822AbjHXWPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:15:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD8D1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9145614BC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92494C433C7;
        Thu, 24 Aug 2023 22:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692915337;
        bh=wr6PyYLQMH1FDFPHXkYjeWD/Y1Kihg9mzM2Mg7Nblrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2JolfxxbczZ2nRStLtSdGASRpQ3W943vVGfIQQD6yQ72DVXqTGo9LoaDLrY6pbgA
         DNtu/oY++3yBERvCOZPf2H5eoxR9/jE/lvtj1ubfAMEm2nRocKxoF6MuXjRv7X5DmM
         gGqkZbXbmSQpZG0ieYKigIZE09q6kdShAN9TSwabldt54zwuULmCduRCHPTXADPb2A
         UFFxOlIVzf7BBjzdkAg7BXs00CRKzF4WChRAGuNe8W1krGjQB4KqWvpu4BriZjeQKL
         HU5LY8XR6YDhU650FDTTTGOXtyrHCRfxMVoMAPC5rcfqrbZepZSUA40yyPRzm27ZHz
         hV8UQV7mmf9qw==
Date:   Thu, 24 Aug 2023 23:15:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 0/2] A couple of ASoC core fixes
Message-ID: <ZOfWhHT7300tpRUp@finisterre.sirena.org.uk>
References: <20230824211241.388201-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0MjQKjjQVt6uTKlM"
Content-Disposition: inline
In-Reply-To: <20230824211241.388201-1-cristian.ciocaltea@collabora.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0MjQKjjQVt6uTKlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 25, 2023 at 12:12:39AM +0300, Cristian Ciocaltea wrote:
> This is just a split version of the initial patch [1], as requested by Mark.

Thanks but I already queued v1 for CI, all being well that'll go through.

--0MjQKjjQVt6uTKlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTn1oMACgkQJNaLcl1U
h9A4lwf7BoCSZYfVz2ZDM/97eib5epbICK2hmLNVBMPYR3jTVSjFXZ3FI+Jfqgt+
YpC1frXIgO89cTCP8bp6bcrUrrtdd/99ju/vCGaBkc3oXEPOy6Y+dHjQBQLXuSJL
WmLgo62XNWueb1acsANWyl21TdIu8mpOpL1ZUey65m19IfhAI+EdLDT1Ru/m0aLk
v7mlrW5egoaiy0CeOZTAbaQT81H7OQH2EOBBqPqdsmU27g+xUPqChtM+adar0wWk
zjCl9YeYiWcd9JKO3i7TWXiAAhIzbc1lk9e61b59b7sg76wjd2PcNWL9vi+NoeSD
RBeo3UnDsnN75qPgv09KJR6UCPPVfQ==
=k8P6
-----END PGP SIGNATURE-----

--0MjQKjjQVt6uTKlM--
