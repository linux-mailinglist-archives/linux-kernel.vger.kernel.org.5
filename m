Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF437D262C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 23:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjJVV6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVV6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 17:58:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5DBE6;
        Sun, 22 Oct 2023 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698011918;
        bh=73X4MkhybZjXtSjGU7T1doqZkeVHs7t2vC0PB7DzO3s=;
        h=Date:From:To:Cc:Subject:From;
        b=f4PREoOdQm64xodCM70c5Fujzz9fvqaJrZUIYhBoqK6d+U2VoJxebd7uUy9VqBwCi
         H+odEIjOxYJ5kn+LFtCLr4s9n51zgKBFJ2bFlqgREbG5risgqFIVVUO712NTWpv2W8
         8yYUdMm8NmAZjdX6Cg7FYTjjqpi/mWu41NrTC/iXG8NsIYjjolYYoBvHyEJOkbGdAt
         9+aj3isAipvWV7HbCQnoqiS/aLUINvst8YXNU5MsOVArvJr0e3sdA0Z90s6uEwYmvJ
         ocdK0fWgJuLzdBS7+zVs5ELAycMjTN0ofT+EUL1VqwIQjeBa+Otihu2HuKTrRIeDtH
         TOv36daUr8Ojw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDBzL590zz4wdF;
        Mon, 23 Oct 2023 08:58:38 +1100 (AEDT)
Date:   Mon, 23 Oct 2023 08:57:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the qcom tree
Message-ID: <20231023085748.453e74fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AqviQ4Rw=LZCWa4IfM35VcD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AqviQ4Rw=LZCWa4IfM35VcD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  00c86efb0f78 ("arm64: dts: qcom: sm8150: extend the size of the PDC resou=
rce")

This is commit

  cf5716acbfc6 ("arm64: dts: qcom: sm8150: extend the size of the PDC resou=
rce")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/AqviQ4Rw=LZCWa4IfM35VcD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU1mtwACgkQAVBC80lX
0Gw2Mwf/eBcEoxaKz8mVpmrYROjwL1mZBfitdcEd/Vh7Uig0Pg16CeY4ulyr5MNr
I+b4dCJq6GBXdBrw6aYLAuVJsXWT4jHBpkhlJJUqVnNExTuuSVUblQNLm4HqqjEZ
bOEEc7Kn+PI8MnebrFToOxZDmYVkdVz9+4bAkKpO6Fh2qTHmzUF2figoMABtKRat
MVzKainaZz6QvQgL8TJLo3mELFViM4uwG3g8KijZGP6Mdyo2X02I9HSwuYrzOvix
qorBRFmLijqbSkp3TV58jT+Ormf4YoaMstikczI2e4/fVVhLNk7Ay8zxx+/9Hzzo
Gl4YjvID7VlMtg2ghFZjS9osuy5/Vw==
=zIDX
-----END PGP SIGNATURE-----

--Sig_/AqviQ4Rw=LZCWa4IfM35VcD--
