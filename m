Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A807AD831
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjIYMnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:43:06 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CD89C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:42:58 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 789E81C001E; Mon, 25 Sep 2023 14:42:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1695645776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=aQA6fUc3V7hr6WF8NziL8sVL8R5DtD1C0RzSxnYAPYQ=;
        b=bJXJeaY+2OraVLWixHYB1wql4qOdrDXKPwgi6dkrR78ltk/95+XrnUPl+j9azePu9T8+cS
        bylgz1jz+Cqu95br3ruGSAcFONUmZfFaP+OjjpPpRnXnokQNNugp2XqlyjJz6QX+iexdnh
        hYGHEm7VRC5rH6gFacwzLT/m0rYU8Hg=
Date:   Mon, 25 Sep 2023 14:42:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     lkundrak@v3.sk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Newer kernel on olpc 1.75
Message-ID: <ZRGAUP6qIoNp37cg@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QBF5LolXNNdUwjFG"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QBF5LolXNNdUwjFG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

First, thanks a lot for olpc maintainance. I still have working 4.19
kernel from you... so far I'm using:

commit f99b274084d320814f4b035a7e3455af424229ea (olpc-xo175-for-upstream)
Author: Lubomir Rintel <lkundrak@v3.sk>
Date:   Sun Aug 5 23:11:27 2018 +0200

I updated it to 4.19, but before pushing it further...

is there a newer kernel I should try?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--QBF5LolXNNdUwjFG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZRGAUAAKCRAw5/Bqldv6
8spKAKCRUQkHqysVLkgl763roly98Td9fACfcBv929EJM/II3U3Rql6kMesXxwk=
=TASB
-----END PGP SIGNATURE-----

--QBF5LolXNNdUwjFG--
