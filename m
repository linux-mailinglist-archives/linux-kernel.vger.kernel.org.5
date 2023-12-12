Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A1C80E43B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjLLGZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLGZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:25:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CECFBF;
        Mon, 11 Dec 2023 22:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702362309;
        bh=6FXciDOk6FJw/FyZAH+ChmYphbgzU+7buoZzINDwj7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FnG/RHsYZH5RE9Idh9U57qbBLBioaHdoZ53FMN+qFxti77h1edLaX/wyouOUgK7/q
         L7Xe/g6+A4Gj1g0MkTJ1H1thFfuZYKybJdJyRmdpjbAq7fN7pAUg99LSHcA6Zrg0ZM
         bmWdiZYGItqQSik60e293dUcwi7c6FZXJt+o/VohUsS5MJ9iCrNT3MCr2AUJ4PG0SA
         mxfvHSKvJhCS4ZPyVkQwzQ/4wSkReEWxlOpj3Scoey+gNa/mZxkxLa5U1+AQq+XU0i
         MkRiAd35q7NCSbzrw97tQnsC5yEK8fNNuPYOJS5yMsubZdb60BB9DMx9MSQkZAvZWE
         /ZrliNwmmG3VQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sq7rh6V7Nz4wch;
        Tue, 12 Dec 2023 17:25:08 +1100 (AEDT)
Date:   Tue, 12 Dec 2023 17:25:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 12
Message-ID: <20231212172508.5b6f963f@canb.auug.org.au>
In-Reply-To: <20231212143215.7c2283ca@canb.auug.org.au>
References: <20231212143215.7c2283ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8.wA3rvlF5iasU6SZKLrtX1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8.wA3rvlF5iasU6SZKLrtX1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 12 Dec 2023 14:32:15 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> The nvmem tree gained a build failure for which I applied a patch.
>=20
> The percpu tree gained a build failure for which I applied a patch.

These two trees actually lost their build failures.
--=20
Cheers,
Stephen Rothwell

--Sig_/8.wA3rvlF5iasU6SZKLrtX1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV3/MQACgkQAVBC80lX
0Gzf8QgAhfG+7eEXRIVngcvzOZnvXw3A+fnYjiG3HJQl8g61VGXsUXLSaYupcFZ4
7UN7QWfaYcVzwX9cRhI/ZK8RhkU4pCRm9d4Lk5r2DlNMWccPucW6XMgZr4ANOE7Z
FOH9ktyC2vUED2x2k4lRNwEhxttHmJCTvvOvBINTHLjluN+SQuW2tv0D6FolMlZX
TtSUzmx9J9dEUnSr3fGqfU7DOCVH76xbM/7HWX7TbSd/BD+5tKZFmNrxv4A4ykL7
oAkCFK037dK56xouLXmNZ1jze7SSKKpE91DRRNaOB4GKYv3BZmZ3UXdKlom8Nqx4
bR7S+MLKnCWUtV0uk+xYmb9RIN5D/w==
=jCMe
-----END PGP SIGNATURE-----

--Sig_/8.wA3rvlF5iasU6SZKLrtX1--
