Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8172F7AEFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjIZP22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjIZP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:28:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660A5127;
        Tue, 26 Sep 2023 08:28:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDD1C433C7;
        Tue, 26 Sep 2023 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695742098;
        bh=hSOEVOWea523UX/QfWwrg+we3FwfmY8yKPzRrMa/z+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hN1oBoDNZy6mYj3C8h3AHV7JtrkEr3E7FHxjaAQVQHkbZyp4CzkPh0qsI1tSf8QJv
         aSCQEjRhoceNgjng9c+9CA+R9XWApaM74QlmXjCfQJueJ9Y58jbL84eXcDU8gkqrEf
         FlZn67k0g3MFNVoiSXuOL+Fx9o60vdFJfoAz6pS0bsqIQXIwOTyCyCfXw+ePNGlQwV
         si4jWXqLi62JzR69X/TOTmgWsvxdoByvdDulJhm4ofTt58fLI47J981E3vEUEGf1Q6
         9h3/7A2cL4y/32X6x08js9dFo3vKsHVUn/G1nHktZgz+wKxOXvZuwBGoxR7+WQApSk
         mc83FHgPt0KKQ==
Date:   Tue, 26 Sep 2023 17:28:15 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4] regulator (max5970): Add hwmon support
Message-ID: <ZRL4j32syAhYVu0y@finisterre.sirena.org.uk>
References: <20230919054824.3368656-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D7NHTPFU49baGh6R"
Content-Disposition: inline
In-Reply-To: <20230919054824.3368656-1-naresh.solanki@9elements.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D7NHTPFU49baGh6R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 19, 2023 at 07:48:23AM +0200, Naresh Solanki wrote:
> Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> and current monitoring. This feature is seamlessly integrated through
> the hwmon subsystem.

Guenter, are you OK with the hwmon side of this?

--D7NHTPFU49baGh6R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUS+I4ACgkQJNaLcl1U
h9BzPQf/YzgBcer+Nsw83myWQLXtT0qP8jgd0C2x3Xa+imwR01JSdP+taPRlb95L
Qx7TISlXwFF2aG2wqgOJH8rbhDmBccwBdhh6pEA/nLZSx+PyGeNr6z3Ljmz3VE+6
FqOW9JNtGlD5kdcE1E8AKVIYFGY4T118hB6C8gbB40Q3lO6EiPilj/slsv2K2HZZ
0zeWOxbWRJPOnAFztMMELQ57MQhPBOQ7zFtKE3l1dCS+AN0XjSXqL9ThurrMTa2l
aIW9DXOvb41jOJf91dl99geafpJONONBRyi7N7Yid5uwQTUj+82MvJt1SXMxnceZ
ChOByu+d3l6z2Amfhh1M2cTBvQcUSw==
=ctRE
-----END PGP SIGNATURE-----

--D7NHTPFU49baGh6R--
