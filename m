Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A11A77C59A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjHOCGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjHOCG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:06:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D171702;
        Mon, 14 Aug 2023 19:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692065183;
        bh=0+dD2sVdFwzszpHI5Y/LnL4Ozf3sGM2mUBnR+8XHP+Q=;
        h=Date:From:To:Cc:Subject:From;
        b=Qkk9Kby6pOWn7aiTDDzFDTAwutXACI9/6GW1AZbi+wFssRwk+nltDwEUyGaEvx9WG
         3+g76CXrnhkjuyw0zKOSkWBFBb8ef8ezkiHCS4drEXLHEjvxcIK3euPxRFBZTfMHIC
         jHISI+sVsgZzleHV0f9HxcValj7aS6ecRRu5XKVErNqngweE7JgpVqHrjYVgVmawQx
         Y+mrhLlkEFS6bTxkkbCNmly0q0PROnhbDMqW84f62EFQs5Ea4q2/RBB4JDDv3+7nsh
         EhILi0flBdG/op/tEl96+LfXaD2bt1OW25guVzYIjCSPH98RRBOcYYkoY3Iv//bk4L
         2UM7gtuimZy1Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPvl357X1z4wZx;
        Tue, 15 Aug 2023 12:06:23 +1000 (AEST)
Date:   Tue, 15 Aug 2023 12:06:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the samsung-krzk tree
Message-ID: <20230815120622.528613e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.c_clR4AYj1nuQGVvkeFKiR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.c_clR4AYj1nuQGVvkeFKiR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in arm-soc tree as a different commit
(but the same patch):

  3027df7e739c ("ARM: s5pv210: Explicitly include correct DT includes")

This is commit

  8787bc51a7e2 ("ARM: s5pv210: Explicitly include correct DT includes")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/.c_clR4AYj1nuQGVvkeFKiR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa3Z4ACgkQAVBC80lX
0Gz8dAf/Q+F6dE/efKTMHU8yTmUDSzRubFRhUGN6KFQaeRC2vmlwIKAuqZbMWMNs
13dDSE/9N68rZ19k/afJCPd3+AEZ4wFuAF6CidD4d2ry1Yzu5fqZ79LpCDzP8OZ9
erNcPwU5Z3tGY4P7y21+iaMo1L6JkCv/K40X21kFNuw4cPOzVI8mxGYiuiJZyAF8
fTCgWDsZV+s5wr0RHtaM0sV0ZLSBnOijHpu1B6C/ovDZIZvCOJNvL7QWGitxhers
65kBBHSshHj8NnIabz6qlRs8oEppkbDDf4YAi5V9ar1sHdCA9KK46MvxYzE1v10a
i3X9E8m80xbz+7XMlGcmSeKMn0ZwzQ==
=uG5q
-----END PGP SIGNATURE-----

--Sig_/.c_clR4AYj1nuQGVvkeFKiR--
