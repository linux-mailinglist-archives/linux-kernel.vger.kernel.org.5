Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506317A318C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 19:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjIPRCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjIPRCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 13:02:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00760CE6;
        Sat, 16 Sep 2023 10:02:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB398C433C8;
        Sat, 16 Sep 2023 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694883724;
        bh=HvS5bB5OYjWUqM9WsgsfrAazLkEGCqqOSG8Usa9O9tI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GeqO40LkxE2/wEN8eaFeXwn/KUgM4oiYAfrVbyKNXOU+CaN33XllWjjPwePmhy1Lh
         ug3eNx0jEhwTTdpfyBp4S8roiDYuw9vxf8ETAeWLThPOu7vOU2dsZ7PzUhIaLONZqV
         0t5HhAcrGPpmnZsYHf6Dd3ecf8QOqjdLOxkYrk0/eai0HKkp0qwqCpLQ5sie99KZn/
         f0h8Fuv8FbFfal6DrGpHo2QRf6dAvhWWoCs+/8XY4aHacOsDDeOZml0nv/3lg369i8
         +6oEYL5LYCy+stNH0RYI09XWN0oEvp3n3SxL0gtJ19c5CI+pEJhTnjL9CFbShAtfG7
         MWn1IB9HDBO0A==
Date:   Sat, 16 Sep 2023 19:02:00 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] vlynq: remove bus support
Message-ID: <ZQXfiK5+eYOW6zyS@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org
References: <20230916091125.3221-1-wsa@kernel.org>
 <CAOiHx=kLQzTTzuGM0tyuv=e9J3Oi7EbWWYFRK5mEfqNrVj05NQ@mail.gmail.com>
 <3395161f-2543-46f0-83d9-b918800305e1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/PSHHcS+ZZTB4Yjq"
Content-Disposition: inline
In-Reply-To: <3395161f-2543-46f0-83d9-b918800305e1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/PSHHcS+ZZTB4Yjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Agreed, TI AR7 is nearly 25 years old now, we should be able to remove that.
> Wolfram, do you feel like doing that or would you rather have me do it, say
> next week?

I will try it, thanks for the heads up everyone!


--/PSHHcS+ZZTB4Yjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUF34QACgkQFA3kzBSg
KbbZgRAAqWHxrGst5mAJsc80C8GWtnQpl6k+A9hBFcpdRIEMNTsPHoFUoTE+IBKI
j2lIOxQD930fVC6h+ozKVKC0sYZB+gEMAUwRINr6FJeE0y3gkxhvIGBbP7KJPTe/
KfjDqnZ7f8z5cYtp6M2FTqT+LzmQEELJnvUre9muUkk5cCDp+xCD1AScAESlgw6T
vJAA/hneaFouc7Bh3oyzy+8uu0Uhg3YBRn9hY8fx+DfWL/fcMNr463LW87ph6UVh
xsa8ZR9tNqswhS9mXLL6mUSQ2LaI9FGkn0hyF1bsD9BvTEqXBZzyp80lIOjIuLAT
EqXIB6yPQstWvNTjsNek/OLL0M9NVV1tfI2Ud6fvDHMYIgKQI+XkBLmglIigb4P9
wM7jybkWn1AJT5kxJEjCV+oWRsbMnlSRTZ0KoWIfTg6BiKybgTiZRqZcNQQ6hOwh
CS6q8qUpk/LnWur6wbFBoa2aD69RRDmn5mrIOsCv4N1JF9bwghSZTcViN8qm403+
KjZzX5VCrE5QcBQh9Y/OVTL+B3gZYcEQwGzINUrBx1Xmkru+Vz1UK+3qsY3kgMCd
2EYRmZ1iBlnOsUb+ljWhs6XV64X5cMORwgZvqZ7lrRQx8Ym4PAekqWaDD9hxLHw3
cnQ2iWh6/zhL7DC41Q5Saz9IQbHSIWph+Zebj75HUl2SCOot3vI=
=XjWk
-----END PGP SIGNATURE-----

--/PSHHcS+ZZTB4Yjq--
