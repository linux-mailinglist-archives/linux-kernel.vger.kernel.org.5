Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D737B1555
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjI1Htn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjI1Htm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:49:42 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECAC95
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=QZFl
        1a97h2/9g6QzL1NyeY9qjBIRi9sL1LKVpy11Y8s=; b=gHyEXUOcQXilzCMvEm2n
        9S4y+lKXMsP/dsnsZF4xCtUK9VZi8nJQL+kfiN2vdZ1LMPaN71Y+5fLWLLN1KzoB
        0ZHeomr+z1e8m2/byiiJpMNvl7UpEtGTrqZxUZERm6f0MppnQtHqZamJMDMMm8yr
        j8Dj5Txuvubs2P9DazZCuWwYfspe9Bm5MVKZreQulTpZZTDLGcVD5l6qhmltbHhP
        h6JUL3w4J2ZY+eEp2jTGHbA8HOmtVoCpZNgn0Zv24i5EEKiwp8X62iuYqTC/UkQ+
        VIE+CsY54WSx5+wezrpWwseas8C/QF5OlvWChnylWbFpBAN+BJ0J7LwpEmLi67Cz
        jw==
Received: (qmail 3381278 invoked from network); 28 Sep 2023 09:49:38 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Sep 2023 09:49:38 +0200
X-UD-Smtp-Session: l3s3148p1@fQDEjGYGOKAujntX
Date:   Thu, 28 Sep 2023 09:49:38 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] MIPS: AR7: remove platform
Message-ID: <ZRUwEjpfILlF5dgE@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
 <20230922061530.3121-7-wsa+renesas@sang-engineering.com>
 <ZRUl6+i/o0cqCV+6@ninjato>
 <ZRUrVgHyJvvhteGs@alpha.franken.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hEEbsm7LPJ6rnXmL"
Content-Disposition: inline
In-Reply-To: <ZRUrVgHyJvvhteGs@alpha.franken.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hEEbsm7LPJ6rnXmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > most people involved in this series think that it will be best to take
> > the whole series via the MIPS tree. Do you agree?
>=20
> I'm fine taking it.

Awesome, thank you!


--hEEbsm7LPJ6rnXmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUVMA4ACgkQFA3kzBSg
KbY++Q//bHN+C7cPFusKMAo4jaMjlgxuC67ZXQ1nWDDW570H0fejmxmxJ73jMOnl
2wNG8TX8YL4GWRn1b/S4gZmgC/6rL+kt50yH2z13cIvjWFgnMj1WQfX621+XU5d+
j3yOnElL8OALvJXlmB6SxMvl2bG9XDmvp62n9gCpXJhjmUwvvsMEDBLPBKjITGv1
yz0vIJmeP+BMN4m20/thlKZPZ5xgH5TotuW++s5N6z4r34Ix5XagCOdqXA4MlD2c
Sn6XfXEKxMpeTfKvCgwM5mex5mtdQz60BkUEvMQDJt+VN4+4Cmqymrnbqz8Kfdfn
TxRPlNaKr3AJTGMR/fDIJFzEu9HFDHC2ChygCYYJrRNzJzR51cpHzehzpDa86lLX
Id1Tt7OFcS7eLXGGgBQwQUAfjTQOaammebuZXN85/yfk+nwELPkqFQpu1WqZCNT6
8eocVDv8N/8OOeiNWABf37uVz/GJAC5xEZMdUrtBwHxHh63kUGrd5Mw0vDT+kUjV
ycEuPjhy+LU9Y/x0WYjHJzsOjbY8Vt0LsLxP3zsAYs6hf399oS2kzpzZm4cW5935
jaGJ/U0xNqX3i1Ypc75x2IcnwazACs4YOkfYULy6K8JjY/ofIH15maLhsBqnS+wi
I6kxHQJe07U5g8xmthtB73ibxM1m/fGhJT+xuSL9BTzVqm+2eZQ=
=m+DX
-----END PGP SIGNATURE-----

--hEEbsm7LPJ6rnXmL--
