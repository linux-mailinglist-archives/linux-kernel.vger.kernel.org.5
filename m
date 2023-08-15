Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3483E77C82F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjHOG6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjHOG5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:57:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7765F10C6;
        Mon, 14 Aug 2023 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692082648;
        bh=X6h9uRdt/JwF6/Jb8PTPjGTNLT5VM1JgWQ64Qv1EgBA=;
        h=Date:From:To:Cc:Subject:From;
        b=RPfn1qbK5l6HYLPkhbSABwIsADWWNIcOlNvHzNAVf3Rq2UFACLBYbZozZbnd8P2wQ
         ZZIENKbLHdVC/YITo0ydR7mMDmKQQQS2EikuIAMxQkVD8GJpdt7OaplMIPXpBl4hdB
         WH26H5DGP0/NG+7+ER5borlmD7wKEg/h+pB6v7c8GNHt6YlVyVqCBii/sI87KBYGtR
         T4Z2I+rgeCMeV0qmKDAQNNPuoAAWQ/tkM6wNKUmt89Uwc0qruiduH/qHEnc8SXRWTF
         UTrLtyV2kWYGxg2+Aywd6NdgrbxN8WMF3ZrckJLZaWOXuSGS5iw7aA7QB/nkGWq1Ch
         peV8n5e7b5Juw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ2Bt30klz4wbP;
        Tue, 15 Aug 2023 16:57:26 +1000 (AEST)
Date:   Tue, 15 Aug 2023 16:57:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the drivers-x86 tree
Message-ID: <20230815165725.30a01fe9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_TGV0ieInscxq3A1SZZtCsa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_TGV0ieInscxq3A1SZZtCsa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the watchdog tree as a different commit
(but the same patch):

  3fce06406c59 ("watchdog: make Siemens Simatic watchdog driver default on =
platform")

This is commit

  926df9ae133d ("watchdog: make Siemens Simatic watchdog driver default on =
platform")

--=20
Cheers,
Stephen Rothwell

--Sig_/_TGV0ieInscxq3A1SZZtCsa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbIdUACgkQAVBC80lX
0GzAnQf/f/qwVQ+r9iNi//g6OjvnALXeUxYxYJa3eFpn+bh6WXAiPn51QMf37O4i
x9Gc7EWXTnizOvyZ4a8taHhZKELZkGHlwMjft5mTyyeVNVKTmG/BMkkmNxiHG6+c
jGvFJfwA6AxfCWzCstFo3AqAjYNcTECcpZZmGuCsbabjPHiRe9m+9TVskz9Fx5h+
7YLqztwOEryrrFqumNrAMKIqabfmvh9zb/F8zVyAOB+QgH3q/8pGdvoA6uyIgHmH
hJma3uVgkOFu80s4KMERHYMNu9tDZJ0MXw/8FPT+2ZY/YYPmz9i6tZqRucyuoUMr
D//s6IKhoSGlJ3aFe6Rk2Ki3YU6ngw==
=6zrs
-----END PGP SIGNATURE-----

--Sig_/_TGV0ieInscxq3A1SZZtCsa--
