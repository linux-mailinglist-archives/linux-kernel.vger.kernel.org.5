Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5CB7C5E87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjJKUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjJKUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:39:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC2190;
        Wed, 11 Oct 2023 13:39:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090A1C433C8;
        Wed, 11 Oct 2023 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697056742;
        bh=FbI1r+GxgiW/hIT3A4siGwLpMXiIWKPWQMvqhtmEF7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQA262V17unZC1ty121xArppNfMkRJPTPf1t8uCW1Bl6DoIibYhJbh2W16gSg7ndD
         UjNM7pkH11ZzKk+X69almEjwhP0NEyXeUuXnTydpCkqICOUZmhA8Uc0suCjiiPLgMa
         S0vaw9xwod+SycNssBYhLzyARt1manKimaTJGapymnvWATHIaq91e0QnfSnQcAbJjt
         orCCN5pMMwfXOCT2hVEt+e6CtK6ECxzOB2rboAq5V25tU+ereEKurxYDq73S/nGqqi
         ijMWFJmvcvG9iDIa09ef0jfhcmjyFjd950mSS2ePv5HM05jUVT+6VlmsIeXOGKKMJD
         5X8sTuU9K7dFQ==
Date:   Wed, 11 Oct 2023 21:38:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5] regulator (max5970): Add hwmon support
Message-ID: <723d4e81-acab-4a31-9a5c-9458d27ec2dd@sirena.org.uk>
References: <20231005075508.1656071-1-naresh.solanki@9elements.com>
 <a1bae0c4-0453-4f17-808f-859b684ae525@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4uCE4bRwmaw0sLv"
Content-Disposition: inline
In-Reply-To: <a1bae0c4-0453-4f17-808f-859b684ae525@roeck-us.net>
X-Cookie: What an artist dies with me!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w4uCE4bRwmaw0sLv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 07:20:06AM -0700, Guenter Roeck wrote:
> On Thu, Oct 05, 2023 at 09:55:07AM +0200, Naresh Solanki wrote:

> > - Remove duplicate i2c_set_clientdata

> I just noticed this one. Not my decision how to handle this,
> but the change is really unrelated to this patch.

It should really be a separate commit but it's not the end of the world.

--w4uCE4bRwmaw0sLv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUnB+EACgkQJNaLcl1U
h9CtIQf/bMNWN+yZBsvadvnTyWELpDwFcTvvX9BOPblqlKfADxGXq2q7XEBnTzKn
2wYIrA3oAl5zB4KpJupNu7H4Or+rDuudIvM2dkNqRBR1zz4FqX2oHdbuceys68yX
CAJXl+MnKEwbFMwVVlphmypMryNeWh6VONZ90lil9kGgvK1T2bSrqq1Pd+qRPg/k
1T8uSgw39q5fQK59G4ok5/sc60/robhHYJEvkwLK+V/LpGSIGy8rP7iD9czYb6YD
Vpq8UkunTwdFDmOj72HWBSQbmtu3avEhWw5kX3wp+NZzM+sR0fXUUlaUGmk7Y6KI
iZdYFzUdbdLn6tC4hTZuiyoBOrhw2Q==
=Hqnr
-----END PGP SIGNATURE-----

--w4uCE4bRwmaw0sLv--
