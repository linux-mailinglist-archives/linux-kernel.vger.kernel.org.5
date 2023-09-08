Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5670C7992B8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbjIHXQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbjIHXQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:16:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4192E133;
        Fri,  8 Sep 2023 16:16:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A050C433C8;
        Fri,  8 Sep 2023 23:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694214987;
        bh=/xMWogw6x5eul1RoNtsSEze70Ln3xhtEGKKmYzcwgvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMAnTqO4ScuE8Mg6TjzvRv7nhKy5KnQeaKoVU5kW/Qv0R+FvNApwDIHzXQ9ejJQPQ
         nN3hIcggGZXONHsZsFiTBrZD5+/Di1RgvTO76xLK/IvjBnfbAIivaNqsDtymvFiEP+
         /GGeLHGzGzUSX9XzELc9I+EPIlyTVVOGWTwJcF5qzHfG9uG5JyHatTaxnjfLkIWq+t
         JHqCKWmjpFJIH/wT9MtuqIzIHvYcwVchCzsxVB62W54z/8hscHiyvsaAngavpzUm+g
         43qIT1xFK6X4fI2ioYC8GwIb7ehjYDWyr0yiHnQfXPZTo/rEug2HGy24216/OqcUpg
         h2K12t/rFtZDg==
Date:   Sat, 9 Sep 2023 00:16:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Okan Sahin <okan.sahin@analog.com>, lgirdwood@gmail.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH AUTOSEL 6.5 04/45] regulator: max77857: Add ADI
 MAX77857/59/MAX77831 Regulator Support
Message-ID: <3647b079-0ba0-4057-bdf2-879fc44e19c5@sirena.org.uk>
References: <20230908181327.3459042-1-sashal@kernel.org>
 <20230908181327.3459042-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GjWYbzi1IfWrrl53"
Content-Disposition: inline
In-Reply-To: <20230908181327.3459042-4-sashal@kernel.org>
X-Cookie: My EARS are GONE!!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GjWYbzi1IfWrrl53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 08, 2023 at 02:12:45PM -0400, Sasha Levin wrote:

> ---
>  drivers/regulator/Kconfig              |  10 +
>  drivers/regulator/Makefile             |   1 +
>  drivers/regulator/max77857-regulator.c | 459 +++++++++++++++++++++++++
>  3 files changed, 470 insertions(+)
>  create mode 100644 drivers/regulator/max77857-regulator.c

This is an entire new driver - this is obviously entirely inappropriate
for stable.  I thought the output of this bot was supposed to be being
reviewed by humans before being sent out.  How did this make it to my
inbox?

--GjWYbzi1IfWrrl53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT7q0YACgkQJNaLcl1U
h9AGjgf/Rx3LgtCztdQQYKCDD3ZWcYoC+7b8FUbbTkER147s+poNE/qTgbXIGLVd
+eJFdT+6y1GUYtkuAkbcGxc0fg7tyKrgWtq/alCC2POvp+HkOCmZLOOCUdOqCZGk
RCrBe7yT9U2hpx6l7QPcXX+MzVeHPqMO1j7CRub02y8HMUwIbeGlmz1KYP7y2k2q
XZDNgmINAiN0Pw5qV1UNHxc88BwpItCDJhSifhBYkApBJgv1kCLxWhOo1QVZ7Wd/
J43rwTqoXw7npOPcBrWlSFScvLYw399JMqw9A0fwrLMRjEZZQTT/JHVsQdUAjmOP
cijrDsnmJ7q5WLvCHwcIpzimSmNY3g==
=oRhw
-----END PGP SIGNATURE-----

--GjWYbzi1IfWrrl53--
