Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83F78F0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346706AbjHaQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346698AbjHaQFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:05:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BA01B0;
        Thu, 31 Aug 2023 09:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4933B82336;
        Thu, 31 Aug 2023 16:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE302C433C8;
        Thu, 31 Aug 2023 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693497915;
        bh=7hx7dENCRJJYC1sdS/KEN2Hx0CzgtkyQU3faU/Y4KgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Czr8DBk0c+4Rk/t2YiSSHUOaqbZdTLZ+IMPpytBgoFAig6GZQFxXK1MTMLMpPND1H
         BkSBycm92EBwXy233EhHUZx5t+b+eb5qZ6w5dnXVftPLGWfNoWLr4cEhGRkXsMijaS
         sgQZgj7G832dEghI8nexABPET8qudZQgRvowUhxxSljotd4UbjTxWiVj72AREjRG/p
         6rPdWiXwfrb7KTVKEGRLqAaWtaWsHme216MsqIgwgIJGVSoQWJa48ntE6VdfwOJTUj
         U9rYXsS6cUsyxjFw6k//b7lRnxLukAE/5LLRf0AdzCDRTHYvKUSgiYfYJIaJRtNyTS
         UoKVzc84DmTuQ==
Date:   Thu, 31 Aug 2023 17:05:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
Message-ID: <def16e52-3ba9-475d-9d8f-63513c47a392@sirena.org.uk>
References: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
 <737c4114-5b54-444c-8a6a-de4e98566513@sirena.org.uk>
 <5B0EB2A2-2048-4A71-A4A9-D5167C7AB5EC@opensource.cirrus.com>
 <d97094c6-1534-05ad-0452-c627d7c45802@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sg7FyDwimPhJ1e+i"
Content-Disposition: inline
In-Reply-To: <d97094c6-1534-05ad-0452-c627d7c45802@opensource.cirrus.com>
X-Cookie: "Pok pok pok, P'kok!"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sg7FyDwimPhJ1e+i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 31, 2023 at 04:22:52PM +0100, Richard Fitzgerald wrote:

> I think Mark's comment is that the Signed-off-by chain doesn't match
> the patch author. The s-o-b order implies that Ricardo wrote it and
> Vlad is upstreaming it - but in that case this email should start with
> a From: line to say that the author is Ricardo.

Yes, that's what I'm querying.

--sg7FyDwimPhJ1e+i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTwujQACgkQJNaLcl1U
h9C2XQf/e12wM/5qI0klirzI3B5cxQSYtxwT4u4kiP20chaYcc4ZyUzfuqCD800b
INi0tijp1M4LgZjrvVHpzkwGVCdXbAp4rUAw9DYtOqof7LDDZNapno6EwM+cPv7Y
ev1suWR2Rre4fNI8aBZQ7qm5MCVF2ISY0AbvzHJK63NR4epe6Ji16bnWCZ5D97m1
qBwMjRxyu8PSTnLD4x34INVkSxWNw0LGhhnq1J+zas+qEQEKTzTP29S07asSmPNi
9B/TDxUj0bLkdyA8f6bV4eFTAtmRSlo2r+l65vSxRL7cpF7ONB0C2m9vTHSYCFQV
fJsHN9MnLDDbT0Xj0NJ7rLDwndTM7A==
=7p8c
-----END PGP SIGNATURE-----

--sg7FyDwimPhJ1e+i--
