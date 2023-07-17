Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363AC756FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjGQWVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGQWVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:21:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C89A4;
        Mon, 17 Jul 2023 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689632466;
        bh=oixTEa0/RFq3XNBZUrt9im4EHZJFVcJ45g9yV2/nenM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KFTBY4RW/XoY7DahfbS/EGSOQWr10wtWjDBCgktRnWf0wImzpbGFnY+w+AHm/N8TI
         xvkfUWLMK97JKPuLjlOkMBCOmPD/zG6yIFY3Kuc+GdgCnw1kAIOdNmPEItaqPmvjG/
         938A4Mq3j0HPT6YvRFmI1Cc/Whdep3tooYhjA84GrfWzko6D8ammF4Y7VskzvtfWz0
         u2JtgX2mjvOhzvxUoCB8VulhxSa/giVYh6b0AAKs+rGOaZKAcDZ5AfUlSALc7q2Xhb
         vqnU7/cQvXhlXkMf+rrlcgt0JqNcwA1aOZvp9gSq8dEJK4glm2mUhoc3w+ekexJfFP
         AVyiEI8cHItGw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R4c420yXcz4wZw;
        Tue, 18 Jul 2023 08:21:06 +1000 (AEST)
Date:   Tue, 18 Jul 2023 08:21:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error while fetching the v4l-dvb-fixes tree
Message-ID: <20230718081939.6c9b4c2e@canb.auug.org.au>
In-Reply-To: <20230717154232.433f1055@coco.lan>
References: <20230717142248.281e3668@canb.auug.org.au>
        <20230717154232.433f1055@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rWIsBg.9mSkPank2DnLl8+P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rWIsBg.9mSkPank2DnLl8+P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

On Mon, 17 Jul 2023 15:42:32 +0200 Mauro Carvalho Chehab <mchehab@kernel.or=
g> wrote:
>
>> Could you please update the repository? We're now using a separate
> repository for it:
>=20
> 	https://git.linuxtv.org/media_stage.git/ fixes

Done.

--=20
Cheers,
Stephen Rothwell

--Sig_/rWIsBg.9mSkPank2DnLl8+P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS1vtAACgkQAVBC80lX
0Gz9Xwf/V+olveJAJ++BS21VxH7uKUloqJ1tnqkRpwbuL9x5l2LJxjlpLxGnzSSY
NZcLQpHv+bZaUmVBUhrM7YLTpqAzxAwUgHwpJkdrQdMQZuhxcJZKJbhmOlxcfG36
WwrmOWBTR5HCVA1L1vdYEjMpdPjW4QJ3YNku1irMd/Hqv4SzMiRSHkqxGWhR8WGO
ivNzqZ7Klx+BylIOEgTA9Rv7cBPXnePJMg5YZaJbfsIz8WbpRAvVc1ql+K0I4HFP
KX1MVp7TlWwt6fgdyFk2bFHPDsWKBIetjMzuktB41bzy3kr3SPvV5tg9Ci7nUgsT
E0x4ZMS5vZyugC1zHfvjfTOyqEaPbQ==
=iRYJ
-----END PGP SIGNATURE-----

--Sig_/rWIsBg.9mSkPank2DnLl8+P--
