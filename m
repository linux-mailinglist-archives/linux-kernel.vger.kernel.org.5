Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49955774246
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjHHRjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjHHRip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:38:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22961195A;
        Tue,  8 Aug 2023 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691481373;
        bh=okc1bHJRjvmsHv8sh2mNg8kwKuXa47ayMSGEUB6jnqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=REL6224q0qV7HWdfF6abIJ6hhcwLw8kt68mfSyk1XTzvtncAT7Gisdm1lHeJnCSCC
         nyzCgTUTkQYlPLhAIRLNIVw4YwqVwd8DnVSzaQd0FgRU32rxZ+Ocuz2mWGYt7aTLam
         il/SIgIVla+xYBYelZK4x43HsWUOLixyl7HBbrudYmw8IRRJj+TjZaj/2wDolvtGEK
         jyATFlWc3kLfVy/mgfHr91SC5sTRpmmSBjgSMVQygzSCo0CW2HEUPi0LAVmYQy9b36
         8ngBF6CvisRPJRwE72b3zxQVb6GyI9AH0dLmG17vsW3/nme7y1jKgcfZRI2VvawWkq
         jeQoXhCXzW97g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RKlqw6FcVz4wbv;
        Tue,  8 Aug 2023 17:56:12 +1000 (AEST)
Date:   Tue, 8 Aug 2023 17:56:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the iio tree
Message-ID: <20230808175600.145ecf97@canb.auug.org.au>
In-Reply-To: <f7a20a95-48fa-edc0-9724-bfb4484c155a@gmail.com>
References: <20230808083925.7109a675@canb.auug.org.au>
        <f7a20a95-48fa-edc0-9724-bfb4484c155a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1dJkSKdaUgS2DlXXEws0e=X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1dJkSKdaUgS2DlXXEws0e=X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On Tue, 8 Aug 2023 09:26:08 +0300 Matti Vaittinen <mazziesaccount@gmail.com=
> wrote:
>
> Thanks Stephen!
>=20
> On 8/8/23 01:39, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Commits
> >=20
> >    a00cf70f16c9 ("iio: light: bd27008: Support BD27010 RGB")
> >    16a9947646f7 ("iio: light: bu27008: add chip info")
> >    ae8c47c51e5c ("dt-bindings: iio: ROHM BU27010 RGBC + flickering sens=
or")
> >=20
> > are missing a Signed-off-by from their committer.
> >  =20
>=20
> I am 99% sure I had SoB tags added in patches. Seems like they have been =
lost in the action.

The missing SOB is from the committer not the author.

--=20
Cheers,
Stephen Rothwell

--Sig_/1dJkSKdaUgS2DlXXEws0e=X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTR9RAACgkQAVBC80lX
0GwiZwf+K+LTEteRRWwhgKpwsXcEKINsk2BZluaTUVkkzn9+QdbvDMuwURwKGkMk
dVnJi81LVP6eSPbcVmu+m6S92nXEO1OToZGVxvM3NO7+wA8YLiz7NupWSFUYxK4i
vjjFXI1+2TXiqbEdiOSmXz9szo0syfChAu10FrNrX4vbqyqPwmvvc4jM8YkUIwD3
2AcPMm/o31vxarOAenQrULtZlsmQn6rKb7F5el5D1Q/m+pJ20fTCBwrGB6AVodgb
3T98eAzy5rG4wdhuY/i2JEMQs5NOeAVAwpSJbeqglMT769W/eMzWkii6FARG0//J
gLVgvH2tRGHh4uy82kBFZe4CyZQb6A==
=TWRp
-----END PGP SIGNATURE-----

--Sig_/1dJkSKdaUgS2DlXXEws0e=X--
