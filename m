Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E473C7900F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348417AbjIAQwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIAQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:52:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51310F5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6F45B82488
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF28C433B7;
        Fri,  1 Sep 2023 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693587122;
        bh=G5CrlpdWTKkjHqnYiMzGcwFEr07EzcqlED2n4J8p2qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QH5qo53kt82Do9rF4cIccc0zy4qxrS+yPfxvsChjlWR/R0VpUS65wDtsrnEhDGCBt
         yCHAbU1vm+VVqT6aWow2JSSTCklKrbpnjTYtuYuorLwZeG+UUadDHZp8P9iGj9l+Vn
         MnLqydHejf/3aLEzSZVO5AzOeca3lQv2S9frC4Y/MkvNSUMMTAJy3f42y2JUVilv6g
         mhMl4105/ykrFF314HNhiqBaGU/g6vPk0/8a1HLYvlugn2nUBpB4VwseA6P7ngjzYi
         TzOv/88brkZ8j5FhaEwlT5b8ts1c14GSDItuLAGMGx2XUy3Wn8puxeiOa69ST4/3Wm
         IotCQEAXEIyyg==
Date:   Fri, 1 Sep 2023 17:51:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Waldek Andrukiewicz <waldek.social@pm.me>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 00/11] Fix support for System Suspend for CS35L41 HDA
Message-ID: <e85b7b2d-57f9-4696-84bf-601daf829c00@sirena.org.uk>
References: <03a70489-3a68-4c37-8f72-569bcd7463c4@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yiQGj2BBcqo9sws"
Content-Disposition: inline
In-Reply-To: <03a70489-3a68-4c37-8f72-569bcd7463c4@pm.me>
X-Cookie: Dealer prices may vary.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yiQGj2BBcqo9sws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 01, 2023 at 04:48:21PM +0000, Waldek Andrukiewicz wrote:

[An encrypted message which probably nobody can read, it's not even
encrypted to me even though I was a recipient]

--1yiQGj2BBcqo9sws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTyFqwACgkQJNaLcl1U
h9CV/gf9FGaWQtDXJLJS0psM6GoKWQK7WRl/EDhADd8oUBv2Klnmh6xzuXuqnVU6
xWhOvkETCVeSuFONCxsk8Q1Gjt6leZ+OF3eMQM17HWbk1mhrI3oOpjgkLK5iizeK
Ste3lDIBIUorBoaFVy1VeMZw0PhRoAs6630Brjq8hb3p9yn+lZGuW6qNuV3sFSYq
4kIweZU1DvYUUaQou1YcObMnn9hPj/NYbIQMjDy7adl5tM787RYRCWrdHkCQYdEN
MMoDCHmdHrchAhr+0+cky2NZA0Nq6ZRaiqhWPz8o2ZIkAwQlI86XQ/GJZDo7v0Y0
1VREjKVuR3nDhd940eknUvvmKSpkew==
=ZG5a
-----END PGP SIGNATURE-----

--1yiQGj2BBcqo9sws--
