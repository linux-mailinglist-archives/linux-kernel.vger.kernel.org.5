Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8669F7A6CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjISVGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjISVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:06:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6E4BD;
        Tue, 19 Sep 2023 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695157591;
        bh=fOGQ9e4BVoLOtSBB5w72D7gWpOxX/9p2zqJYTCgMKa8=;
        h=Date:From:To:Cc:Subject:From;
        b=UzOdhLNhulU/A2u7orUuPSZpJVBdgdYlrN2pZ7HzcWp3hGygvloyosQUYALfWnV0V
         570wI/vnB16PP6XvGfNhbyY0k7KYn0mDKK9Pc6qYSQujKlpByZt3dCz7qJEu2rLtLi
         ijnlK7WfoYNc/hHPZX5Q60+EUCEzjx+DbTYYL22qJKJgrGeV9v/3kDjV9NRtzb4toy
         5vRVW7eE5xvI3r5ubrDk37SntRJ0/KWMIu0zvLekVtQZQLoy4A7XqNRSvBoPeV57WY
         FLgkdyLVkSKMrYVZQvHnspt5o4Vkv+k9WkunV+ZES+xdwDKOliZapaRzcH+H3znZpF
         aS7iFsUZ+Xw4g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqvNR00tdz4xGM;
        Wed, 20 Sep 2023 07:06:30 +1000 (AEST)
Date:   Wed, 20 Sep 2023 07:06:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20230920070618.6c3d16e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2sDYkqYlpE5GtM2lWcN1OCO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2sDYkqYlpE5GtM2lWcN1OCO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  46b169610922 ("cifs: Fix UAF in cifs_demultiplex_thread()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/2sDYkqYlpE5GtM2lWcN1OCO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUKDUsACgkQAVBC80lX
0GxKVAf/ZcCkKiP2LMC0jj4ToIcqtPcz0AV+3eoNd1hoWGqzk21AzMXbZnBqwLRt
/JhIVTg0VfOQzhhTUivfxVofgZpGi3Vj2N/rccC/qZIeT3nCV3/+fKy1WmYd2jIS
DqpDRexXStlOeIHOw8+NqY+OEOyZn44EEvA94sSRtVQUMjxR7SMHASfvhL8DBecT
NJb9hA8BEn6/4SgWnCNEkwpk1sYwuhjKs6uUzxDV9JTlHjmaPMu7EgoanvBSp5r4
OKMvo/nvZt5b8VcFTROd7PfQR+07qTNSf3HBLPAenX8FZUvjATHtpo7RO3qsOyS+
uliGI6T1CSIERR5JCn8401whQuwEjQ==
=GOkt
-----END PGP SIGNATURE-----

--Sig_/2sDYkqYlpE5GtM2lWcN1OCO--
