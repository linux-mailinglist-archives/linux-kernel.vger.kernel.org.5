Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF86E786341
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbjHWWRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbjHWWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:17:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1BFE75;
        Wed, 23 Aug 2023 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692829014;
        bh=vCYwPePb0VjFZ+Z7F65w7181gZDfrQozs7mP2qmIc2Q=;
        h=Date:From:To:Cc:Subject:From;
        b=BkyfUU7mOdH+C0r6jkzaCluXAJF2WblY8ngE+49kG4AyYyzmcflsx1KmJEuuCmNAb
         r5+TyfoDwZCT9i8ge1SLIoqbQ24VAlHNG1ZADl12q33XdKZGTjDtnR+GlWf2SLRt6L
         aGgt0PPwGnT2WFZIFH1OE2yLDc9aTrpc4amSQ2CU7PW2hGhMnYSTRVFfd+ZG6Zk287
         dW4kpbqx1Ro3HDED9t3gXS2wLXgOEO5RlTy5YpWVJZIoBawk1zIbrMwmdmhFTbPWES
         3/C6vTs4o14L/DbyM188cW4vpxSZh9KR7K85bBqtpMee9rSpghpyg1utloBx4TYh7k
         mw7muFCByjwdg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RWLD64r28z4wb8;
        Thu, 24 Aug 2023 08:16:54 +1000 (AEST)
Date:   Thu, 24 Aug 2023 08:16:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the regulator-fixes tree
Message-ID: <20230824081644.4fd24d37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gsuofbfc.6vgoPt3+z/Y0CT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gsuofbfc.6vgoPt3+z/Y0CT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  e4eea7122272 ("regulator: da9063: better fix null deref with partial DT")
  fb0db7f2d010 ("regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550")

These are commits

  30c694fd4a99 ("regulator: da9063: better fix null deref with partial DT")
  7cdf55462c55 ("regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Gsuofbfc.6vgoPt3+z/Y0CT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTmhUwACgkQAVBC80lX
0Gw77gf/Rbm+sn6FZ7n0YH+C6o1fxszHHqCwhIZIkvasxyE+7CLpX8vtzP89jeD8
SG15q/fLLqYhmh875Z1PC3SfE5dhPrHPADh+0+ZETED+ESs4fPsbLbIi60LdlaQ7
xuU7Km+ZSk2szT7JSYfDuEZqTjKgzOS58cpDVk5l9MND7Re+na+UfozmRChiHnPQ
pH0SgEeIEbAkRZmm4gTnVQ1sUq/FcWVpHmDw3sQ7iN8Qz1/FJBxhGHTcYmXm2bev
h8V72PtwFwCBjeWqfpcDdlXgPKUo47gWWuExzQRDH+mPlDijML4EXQv36fwNMfXo
n5d74OzGNF6h3+mv2y7O8wFrne5kBQ==
=Av4s
-----END PGP SIGNATURE-----

--Sig_/Gsuofbfc.6vgoPt3+z/Y0CT--
