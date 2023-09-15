Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4F87A1D17
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjIOLFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjIOLFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:05:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C6199
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:05:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47547C433C8;
        Fri, 15 Sep 2023 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694775933;
        bh=hOyiTxdftFAjmpAlocJ9lFxzTFRptiSSvs7eM0255YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WpDsJsuw/XYb/kdsFriqTellUdxp3bv3hoVp+QKf5Zpd8MhP0Gs9q8g0/SNyC4oSI
         As8VAsqgLMD6cOuFT6sTDAOZ3oXGRMxIEoHxhnSUvvRmqg0/WML6mljnfDFQhkqDL5
         yZFxquEeaZDlA8oinuSE2akhgUhcCDZDSP5aSXL+c4XwciNfqVqekVgovMX4sfRRhx
         zgRlwHnnDr8lfFn9IpPKhxPn8RuYby5Kw94sDqy1xI8iSHxducXC1Wn0DS0zJ3bq+d
         EuOqmeCiZp5VyB0kqNE8kjNZcAgL7lolHLaZlVUC6MoDWNzGCRA3dKY1lVAH8zcwi0
         zAyT/8woJ3GJw==
Date:   Fri, 15 Sep 2023 12:05:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Watts <contact@jookia.org>
Cc:     Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen
 property
Message-ID: <5af3315a-7d28-456d-ae36-9984bc8a36e0@sirena.org.uk>
References: <20230913171552.92252-1-contact@jookia.org>
 <20230913171552.92252-4-contact@jookia.org>
 <20230914145234.GA1275176-robh@kernel.org>
 <ZQPuJXcmHABQFaQl@titan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fvWBAkIAAADLULEo"
Content-Disposition: inline
In-Reply-To: <ZQPuJXcmHABQFaQl@titan>
X-Cookie: Gravity brings me down.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fvWBAkIAAADLULEo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 03:39:49PM +1000, John Watts wrote:
> On Thu, Sep 14, 2023 at 09:52:34AM -0500, Rob Herring wrote:
> > What's the default if the property is not present?
>=20
> 0. Should I specify it here?

Yes.

--fvWBAkIAAADLULEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUEOncACgkQJNaLcl1U
h9Alnwf9EPsqr1HyoMSzQWvu19hw6Elkc/4CZFN7c83HmYYYCw9czGwXkWmepk/7
pdGCA6F7elZgl4NSe5uVT9oufbHDplEwq5p7PCW4kK+V5q0THsxxNXfG9QvWb+LV
xbHHM2IBeAUR1Vb9Ah7aauT0Ub+ZzQxwSRcbmq5Vue3Q7OiVEc5PNPt+PVonR9uU
/kl6+rj7bQGjTPZBPODjqPNTzuKq0ZiW2fNBIS1BRj/rOGqzdmufuXPNmbRL3RLF
U8BdngqaatpTb/MDsqYBrJlcruyd2ohW/Wzmo7KVkSbHYRZn5xssz2w5hKW4L0Ds
kvORxQle7O2YX/3zfrfRDhp0GQL5rQ==
=rfmv
-----END PGP SIGNATURE-----

--fvWBAkIAAADLULEo--
