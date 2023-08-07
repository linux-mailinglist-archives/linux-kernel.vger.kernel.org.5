Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3077251E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjHGNKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjHGNKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEA410FE;
        Mon,  7 Aug 2023 06:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030F461A56;
        Mon,  7 Aug 2023 13:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44A0C433C8;
        Mon,  7 Aug 2023 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691413808;
        bh=+ylZyoYYRfcm6fV2c5Chg3oeks3UOFVe6ienNx0Fhmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ptPcngcyFrXPhfW+uAcklMgxyhnPVyuRFGiByyYxP0vv5fqTTBf1C+4ZecNjaXNCU
         x5dexojsK7ip6GaiKDXtsaoPTYSzIcInPyoG7TA1F5LhXIZeJNLz4vhFA354hQ91bs
         jlsfMHj4h4bMB1a/aQ3hV8/OzE/8wWOiZVToK/QLyt9vfOvmf665T9kjIbKegLgNdG
         EZ4JdpqVL7wvyWODD+mDyu8mLQ22wCFOdQmTWgvbGeolnFdDe+TK/BROYHkQNEskI5
         tUJXXtpYQAPIshCzIIkr5tAXQJJ/v2mXmUc9Kz2LqqQ5og6ku6/LbuVEVnS+gnoIru
         0Ov9IDZ3B4O+w==
Date:   Mon, 7 Aug 2023 14:09:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 24/28] pinctrl: Add support for the Lantic PEF2256
 pinmux
Message-ID: <8f80edf2-c93d-416f-bcab-f7be3badf64a@sirena.org.uk>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
 <20230726150225.483464-25-herve.codina@bootlin.com>
 <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jTPmHke3dW8il9IP"
Content-Disposition: inline
In-Reply-To: <CACRpkdYXCQRd3ZXNGHwMaQYiJc7tGtAJnBaSh5O-8ruDAJVdiA@mail.gmail.com>
X-Cookie: idleness, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jTPmHke3dW8il9IP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 03:05:15PM +0200, Linus Walleij wrote:
> On Wed, Jul 26, 2023 at 5:04=E2=80=AFPM Herve Codina <herve.codina@bootli=
n.com> wrote:

> > +#include "linux/bitfield.h"

> Really? I don't think there is such a file there.

> Do you mean <linux/bitfield.h> and does this even compile?

#include "" means "try the local directory first then fall back to
system includes" so it'll work, it picks up extra stuff on top of what
<> does.  There's a stylistic issue though.

--jTPmHke3dW8il9IP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTQ7SUACgkQJNaLcl1U
h9Cgmwf/SLPNpdzBUj796oCGdE0sLv3Wx6OOJqUx6r7OcXxbdmI57ntyLtd42nrN
Bto5bvnu1D1GkKvkmyy+3qu8xEk9s7C2T9S8wddibRU4Ltzcda/eNPj7PwZuLuj1
0z8caed2ZZTmxKQJzHev6bV798Prre1UC1Wu8xTev1OLJpck8z68ITezl6gh97ma
TFmBFQx8ZozN8KVhSTI49Oc5lUUWGJC/CYjNSASRYYC5Wm/bSfAfdDHclNhQLaW9
7VQNOvJvO5CmbCu7s0dq39QvEWgoC2sm0Cx8ZWUpHxjKZVyWbnfMr0sMyPwgLtWb
vb6uLwRLtAlanfRgULyEgNLTnZ+BIw==
=+n7M
-----END PGP SIGNATURE-----

--jTPmHke3dW8il9IP--
