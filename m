Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7875C78E330
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344471AbjH3XZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbjH3XZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:25:14 -0400
X-Greylist: delayed 4130 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 16:25:02 PDT
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF22C5;
        Wed, 30 Aug 2023 16:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30863CE1F31;
        Wed, 30 Aug 2023 21:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89589C433C9;
        Wed, 30 Aug 2023 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693429198;
        bh=oZMG6qL+Cu510IHDOLGg0aYCjrQvUEyoDQ865p6UfDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OB4uqQ962pARB6pbatc4FmftlW6tKKcmCeBxCx6Eq1S4NhQOhXxEcsEN8JIiNjeOF
         7pkba2CcWngAGDN8v9sorAjxwbmroDYlgeKSu8c+yg0BKHc4kdx7bK8bsEJQe6uSd2
         LLKqTQya6xEYJUtRIM4iagEb0+KGvavUM7aYTLnFSMTD9++E3LYc9u1lH8tVqDKEiV
         5jooumYpngLMAYBd/I+tixLEqrjnpUza/V264FcShy13PyEhVqKhhSba6+DyEhWmLt
         IsXoDLS4r/bP4d+ev3W6YRdW76fxwJJK1eoqN54ucGt1at+BQPSW54TnQxnDXRwI0B
         08F1buRuVzu5g==
Date:   Wed, 30 Aug 2023 21:59:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
Message-ID: <737c4114-5b54-444c-8a6a-de4e98566513@sirena.org.uk>
References: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AUDHTcx1/kKY0ynM"
Content-Disposition: inline
In-Reply-To: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
X-Cookie: Immanuel doesn't pun, he Kant.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AUDHTcx1/kKY0ynM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 02:55:33PM -0500, Vlad Karpovich wrote:
> Checks the index computed by the virq offset before printing the
> error condition in cs35l45_spk_safe_err() handler.
>=20
> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>

Who actually wrote this patch?

--AUDHTcx1/kKY0ynM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTvrccACgkQJNaLcl1U
h9Bcpgf+NYLkQOJ3teKC3UN/Bwy5w9yMYjIu3JvSBXR1ejzGVt3epy7Dbb09yaU0
eASqB/UndJgt2v2lasHruMx/WXZlwFRkjhGwFb9KlkUclsn1cSlwo7fEim/ZDorq
p71rxw7E5Eg25KnSshbR3JHnsyr7IiQ3fzp+Fl/Lkl2Nf5JCM0X+iAfCmhUhjF0n
sf60aQvyfST6HJrhxh6+opioyPvwDSJtKcYicJpYNjsbphj1Sew2zN9meoR8SBBv
IuZGEXSRkuUGB5phFR7T/crx2SXZoNAAWoe+0vEl8bNaeCIZo3PXUcydNgJeJmWk
jcT+DHEnQhtac3PYlhxuQ39wI3g5qw==
=mocu
-----END PGP SIGNATURE-----

--AUDHTcx1/kKY0ynM--
