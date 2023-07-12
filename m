Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B995375136F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjGLWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjGLWOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:14:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D2171D;
        Wed, 12 Jul 2023 15:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689200053;
        bh=B5mWIWAX0ktHRUwgGbV8XOZ21jjOmLzKNngsxzeEVt0=;
        h=Date:From:To:Cc:Subject:From;
        b=M5OGac/FwSGKZWaRsDnKMHzdeOCB2hzB7sixxR3+CBfI3PrI36F63lwg8DjN6sgPT
         IdC9KKthlmGMZre8aNDoZU5gnyx6oNPGdYLqu5e1usn4AUJ9o/P6bkuOdmvm50DEJK
         JKgiCbK9kcDCNBbfltG25ssXLFVnxlvs1dhbh4ZRFRMFmt5VbnpPPpBDsypLkbmYvz
         MnQ8c3JjpulbueQxyoXAQYj/8Y+sqrf2sPjaSp89o9XD9EjCqgevCEVjT/JLRP0I9K
         GGhIJqbz7UzNnbBZQj8dNvNMOgHLAOHd8iYDcrxcO/5O5n+REiwHXxHUvyOSHWtvx+
         vFjgZp1AmAuUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R1X8P08dfz4whq;
        Thu, 13 Jul 2023 08:14:12 +1000 (AEST)
Date:   Thu, 13 Jul 2023 08:14:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mhi tree
Message-ID: <20230713081411.43792927@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w2W0RFYQ9ms93ffVD0WCR7w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w2W0RFYQ9ms93ffVD0WCR7w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8623c0a70ef6 ("bus: mhi: host: use vmalloc_array and vcalloc")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/w2W0RFYQ9ms93ffVD0WCR7w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSvJbMACgkQAVBC80lX
0GzCrgf9ECxpa9dBZPrgB2Rl5sjUgteRA43TEKnG2impFd5mlMkF4kxsMLmiz97R
u6qhZHrC7GDPYrZCtL4mB0i+9iUGP5LkQJpt6Q+l8fs8OE0VqVLt9UTrFDC25uaj
Nu53brHOrOPZ9EKNIq16i9C21KjNTuVVltWNxKCwH5ReXRFm8Xnfl0TbBoa0/oPD
rdXP3oKXt3VmMHBW7q5Ag7asogvvG55etsjOIN2zmVlHwnNN58+F+4mIqBHZOdY2
94gDEv2Yn0rHnlsMUt+0ngEWDUdiuIYo5mq4AeIImt6oNntgrb2CLvFRDMeW1SMa
IkNVF4JQqEjlxFSK05oxwdqWzSbJwA==
=RrEv
-----END PGP SIGNATURE-----

--Sig_/w2W0RFYQ9ms93ffVD0WCR7w--
