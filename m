Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5B7A0FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjINVV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjINVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:21:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1A26BB;
        Thu, 14 Sep 2023 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694726509;
        bh=aJpBulGX0tYz9HyH7B0PzBOmhxLJ5baDQYM1b+3D3hQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Lu5fihFy3y88zmvixAiByJrg63UG5rdyaVO5NOXVU32Gx1BiqOY3+2WJEqxbp+8Eq
         ZV8Jz8NLdchOUg8hmqBYo7E99V8qrmJh4eltV1T5rxTg0EMCJ27wdOOhwHgx7RYsj4
         elf9XESTPegbo2RipAk9XZx0nYwN8Brqxfid+wC1TDJ0TG5XVBQipPS9ILextb0zjD
         FrcO9JQv4tBGG8bsSxYNDp4y3EHX14+KoW0Ny3HqzrgE2i/UwwtFm0y4iruto8RyE5
         PvK5quSTpgbTzL2ndjJjReLrNQp9Egz6eVS6vVT6aNUscVqXvjX4j4LJmScxXjkhOE
         Y65oXBMQkOhyg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmqyN4MM1z4x2b;
        Fri, 15 Sep 2023 07:21:48 +1000 (AEST)
Date:   Fri, 15 Sep 2023 07:21:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-fixes
 tree
Message-ID: <20230915072137.47cef093@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2kNBVUNzJK7nf1Z3Yv7Eu.V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2kNBVUNzJK7nf1Z3Yv7Eu.V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  5503b2f2a9fa ("media: ivsc: Depend on VIDEO_DEV")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/2kNBVUNzJK7nf1Z3Yv7Eu.V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUDeWEACgkQAVBC80lX
0GxI7Af/amZ4qBYFsNlehcAgyIRYLYKLM6t9/REAJ/PgJ88YC0fyR/84feq/qSaE
gHFdsyoP+mPY4LmkpkcKLMCsP33Y36aSb1bf9c0NoTUWdEWvQ85b6bnc2WfPj2+G
DT/c09KHqHxpfkCRrRChgfkUW+dB8/Df5r2NyAV3oohPy88UDo1YKiCd8LSgRVCk
VS3d/owIsZYOSvfWjfC2lrT+XnGdP1dQtPUDGSHpbs9xMcgZddYKrwONBXUdLEU+
7voUsqXMMEckmpaUkFUeQ+c3uJdLS1DX3R/jKykkj0WWkMfQN4R8/KVT+M5rVDEw
AqbqQTtkZTbv9dZzSmDnVZrJ5j2vtA==
=ziwc
-----END PGP SIGNATURE-----

--Sig_/2kNBVUNzJK7nf1Z3Yv7Eu.V--
