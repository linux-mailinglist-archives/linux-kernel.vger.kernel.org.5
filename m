Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB657A97A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjIUR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIUR0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F6E10906;
        Thu, 21 Sep 2023 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695268393;
        bh=KEdRzzmocYR9Z/OpSPxscZpAO9h3i5yOvZvvJs6iakI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p0GUsyphTu6Y4scfXa0vD2hiw4fkf2p6+b3gi1Ql96ubtx7vhMdiIHYn0n6bMaHwv
         hYJj332c7lHMiAXc7eZ9LYMw3SK+3SRmLAD8oUiurBvwGpdVgkjvpjwCIBj5E9tOAG
         HaZj02lD53hGaM5K/cokIgyq4+jB5TMX5/AOvpU7rlaBi1u8Yy/J1sF+M2o/z6dDLK
         koP0jIVfQrT57AnZLcmZwx1TypnofWJN+jUcdSfylulGle5lGdszFQq/B/h4WCsL9Y
         bMycGB7Dn6eeeH1ZeiyjeuIs92+1OILSpD7A9db7tUMrkR/+8nvWlLa0qVAvz9Zjao
         pD9DF3+MPisTA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrhMF3rpXz4x5G;
        Thu, 21 Sep 2023 13:53:13 +1000 (AEST)
Date:   Thu, 21 Sep 2023 13:53:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 21
Message-ID: <20230921135311.6d437784@canb.auug.org.au>
In-Reply-To: <20230921124839.77046797@canb.auug.org.au>
References: <20230921124839.77046797@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kIIqA8eNC5rrT/rRCLvL8ig";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kIIqA8eNC5rrT/rRCLvL8ig
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 21 Sep 2023 12:48:39 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Changes since 20230920:

Forgot to say: There will be no linux-next release tomorrow.
--=20
Cheers,
Stephen Rothwell

--Sig_/kIIqA8eNC5rrT/rRCLvL8ig
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmULvicACgkQAVBC80lX
0Gy3XwgAou6u1/5KXLtHUr/kdmhy4w8Q1XzCAdQ5MKINB+30h3mmX8Ebht4etZZ0
4EltK6Cote1gpfN6KUKMk7L/HxiyeOWlw+5SdRJavJnp+mM0arDwOuKsUO/Y0G4g
zTNskazV9ORdNNS246Qlr1X/cLvahzUT38rtFHKDwlLvczmG2yz5az1+qqwDmut3
0rI6ZIELoPvezc7Jlex6MgScKUCzooUMylnf2URzWSDQzupTRQf2GgbmktUcEgj1
pIGyf1MLzgC0HryymrP1v6a6dC4iIzFMdH88K8As98GDx327YXX+woUxgEsE8nBs
MthL8H79ZekzsY70mAL1EceK3fnysw==
=sLfH
-----END PGP SIGNATURE-----

--Sig_/kIIqA8eNC5rrT/rRCLvL8ig--
