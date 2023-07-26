Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D38576395E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjGZOj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGZOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:39:54 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 07:39:53 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F6F19A1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1690381915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B8zkmEooAd3ivhBI5159aRXGkQXjdZ6DaWps5lwao+8=;
        b=BKP68AtHg+sp03VT6ikDKu6RX6Sh+A4yjAxzN5bhI1jkNTxFPjHCgf4ufAUlqSRRvKEMQ9
        AGBcWytXmqNfU/Fy/GVq2mOP4s8Il4tHFwFKO8znxgwg5/q4OPFRlGAo801nrVoSgjaUty
        ndAAoOs/h2LWMIHCM6YndnI7JWPfeHA=
From:   Sven Eckelmann <sven@narfation.org>
To:     mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, yuehaibing@huawei.com,
        YueHaibing <yuehaibing@huawei.com>
Cc:     b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] batman-adv: Remove unused declarations
Date:   Wed, 26 Jul 2023 16:31:51 +0200
Message-ID: <2978210.e9J7NaK4W3@sven-l14>
In-Reply-To: <20230726142525.29572-1-yuehaibing@huawei.com>
References: <20230726142525.29572-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3326948.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3326948.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net-next] batman-adv: Remove unused declarations
Date: Wed, 26 Jul 2023 16:31:51 +0200
Message-ID: <2978210.e9J7NaK4W3@sven-l14>
In-Reply-To: <20230726142525.29572-1-yuehaibing@huawei.com>
References: <20230726142525.29572-1-yuehaibing@huawei.com>
MIME-Version: 1.0

On Wed, 26 Jul 2023 22:25:25 +0800, YueHaibing wrote:
> Since commit 335fbe0f5d25 ("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")
> batadv_recv_tt_query() is not used.
> And commit 122edaa05940 ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")
> left behind batadv_recv_roam_adv().
> 
> 

Applied, thanks!

[1/1] batman-adv: Remove unused declarations
      commit: 5af81b30fd8fc8dcaf2c20e91c9f1f053bf2b4f5
--nextPart3326948.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTBLlgACgkQXYcKB8Em
e0aN+A/+NNABiED0zziMTAwSLZoKYqPEfBGuh+wDQZNdXvb7GJI0ufIdlMrwNEIx
FPsrWyEdD09oOldgb1PJSGsDRel9VaUmK/1J6/bUHH6cFOhywZ2tpsjMb7XDnvhE
5hq6VeRV1uapfxD9l6yupSX9qLeUjB/kk9DSqkDIlX1xDYU1ubojC1chlXpFxmjJ
EJsg/w/1rJrT73aWBesCODU0mHJoF0ouCTXN1t5MCJnnHK45u2rb+18piR+z95y5
iXcCVCAlz8G8Ahg8f4++7kengv6EjJ0+dsocs5bf5aceyE4D0Axy9CN0cQGf+60k
uihHpN5t+oaTZvccqavi/W0c1EbW4S5/7he0B7GekQLD3lUwPD4NULjljSEqofKl
XV+kngsN9e6lMZYIBZZTlkvNL/jyYzUDF5fx2kqtm/0Y1Z69zTRZPO5xPPQQicj+
NkCqUklTY+uTzNohwj2Lwt6/D9q1P0ldqCkz0a9scqoLUPKWuRsu0tg34/vAEUJk
xqVptkrfWZQWWcCb+bAfOw+bgspLh1U26zTIrHwcMyhujaICSAeSQeh5ejFm0Otn
xwPBuxju3WuvTsAMECPsyr/e5khZB27bMPOnioDh+Nx8qj4eXxffPQduPWRk5DKi
26eCmmVTXmkQNSe8TPryajqONF1/O088DOyztpsygO8dLMUpcj8=
=7Jpv
-----END PGP SIGNATURE-----

--nextPart3326948.aeNJFYEL58--



