Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB67807152
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378659AbjLFNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378509AbjLFNz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:55:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8146EA4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:55:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EBEC433C7;
        Wed,  6 Dec 2023 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701870935;
        bh=4wG2778RJ9BN1vj3tcdf+nWrzYvGBZUU1AlPFXB6MuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsyAeJ9SclO/4lpPCeNWcuTis9RwUp+wgN75mkvE2g5gxsgEWfVTmX60MBvkJR1n/
         u+qdanMJMi5YxHGEcb2oU8ftuZsLKdPH7G3E3tiLWOc4mSjDhvOdzOr+m6GPfXGVEK
         qVNWxEt2i9p6TP0WERiuGCaP7rXOFenGaow6ZwJgAr1bvcNTWQsbWPGBX861eSyfvZ
         UjqlxWescK65kTWwX48fGqzNM/ESDqqcm+6vEdFmcLNiWLAz83sLr4bWNnTmjQcmxU
         /pb5MIrtQDuAipQ73a8ruNiea/cDFVEEkGKDuHnIrNB4O+vpEo0ue8LgD2IfOjsvSN
         o4agXSOsraQZg==
Date:   Wed, 6 Dec 2023 13:55:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nam Cao <namcao@linutronix.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@zonque.org
Subject: Re: [PATCH] Revert "spi: cadence: Add SPI transfer delays"
Message-ID: <d8eb53dc-5158-4212-8715-052e9e99768b@sirena.org.uk>
References: <20231206134446.69048-1-namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zGuUWPL8Su5KzsnF"
Content-Disposition: inline
In-Reply-To: <20231206134446.69048-1-namcao@linutronix.de>
X-Cookie: From concentrate.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zGuUWPL8Su5KzsnF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2023 at 02:44:46PM +0100, Nam Cao wrote:
> This reverts commit 855a40cd8cccfbf5597adfa77f55cdc8c44b6e42.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--zGuUWPL8Su5KzsnF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVwfVIACgkQJNaLcl1U
h9DQLgf/eOjAdaTe1eSw1Z8YIUpxfaQZCyKkVEKPYnA8Z4ugSLnYtJVABS5T3rOB
/BDp3ibVeFfsiCwB8A1/HwLjjxEc7kx9AW6FXQq6prkno5tqSEvZmt/QQUURra6G
znSWwNeA/DlXiqKateYvmB5ysYQAR6qdLeFPhcLk7Bz7Cz02YeTsnBr8tGGF5s/m
SGoHZ1Ywc+QMzEzTqZ9oBlwVsc1LgnXVOn1WvlTSK+eRuhcuElcs8jYhEz/rsZcE
ATPiunC+YRmoUZeZIA1IbKzUNki8VnzmSS+1RE1JHwCtzZbRDWQof+WZ5bsjBwNZ
YcOfETV85Kv2ymlPTcsr0pFgDTX5+A==
=4v3Z
-----END PGP SIGNATURE-----

--zGuUWPL8Su5KzsnF--
