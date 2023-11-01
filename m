Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB87DE368
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjKAPdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjKAPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:33:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B613FD;
        Wed,  1 Nov 2023 08:33:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC405C433C7;
        Wed,  1 Nov 2023 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698852814;
        bh=eg9WHFCa2Yu4n+A3lcI4eJ92snfSlvDngVSqSCKIOOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9idzNvI6u0AYDkW3BdIDAxmmvdbqW1n/KqGSCiCmXYNMc94Y94PsKl/Ofadqm2XT
         Y+HxW6G0+AEJT0eIeb2ffOiyhZlOiwcCC744+gJwN9X2U7SpkFc2hdoHH5QsHq8sOA
         cXd+Fir0ya7Cej7puu20Ve/AvNX2Mew2zyetdC1zVX9NIJNtRSqcbWltkOI0VoQR8c
         qJwUXkYPOakdIrBxJnWkcDTgmLEyir2bcpRN76s6js8QlmePI/KVVsOkKKmfdN6yGA
         wus8NBZh7VGQQxgT/7KeubwCnqe8BkE7JXFVewqUnsNbfpWfUYuqBNQXeN4QUV27rP
         wUr6XrqbsuY+A==
Date:   Wed, 1 Nov 2023 15:33:30 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] media: dt-bindings: ak7375: Add ak7345 support
Message-ID: <20231101-floss-mortified-452c96c9af46@spud>
References: <20231101102257.1232179-1-vincent.knecht@mailoo.org>
 <20231101102257.1232179-2-vincent.knecht@mailoo.org>
 <20231101-wise-childless-ed44729657c6@spud>
 <0f294695fdfed60c385deadc9d030c225816b4f9.camel@mailoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GFXk9WplJkFov3Ct"
Content-Disposition: inline
In-Reply-To: <0f294695fdfed60c385deadc9d030c225816b4f9.camel@mailoo.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GFXk9WplJkFov3Ct
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 04:29:20PM +0100, Vincent Knecht wrote:
> Le mercredi 01 novembre 2023 =E0 15:10 +0000, Conor Dooley a =E9crit=A0:
> > On Wed, Nov 01, 2023 at 11:22:56AM +0100, Vincent Knecht wrote:
> > > Document AK7345 bindings.
> >=20
> > The commit message should mention why this device is incompatible with
> > the 7375. Something like
> >=20
> > "Document the ak7345 voice coil motor actuator. Similar to the ak7375,
> > this model has 4 unilateral phase detractors instead of 8."
> >=20
> > Otherwise,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Cheers,
> > Conor.
>=20
> Thank you for the review!
>=20
> I don't know anything about phase detractors, nor any other details

hah, that was just me putting techobabble in the example text rather
than using foo. See also:
https://www.youtube.com/watch?v=3DRXJKdh1KZ0w

> (having found no datasheets for either of these ICs)
> apart what could be infered from vendor/downstream drivers
> like in the commit text for patch 3/3...
>=20
> So I guess I'll send a v2 with a commit text along these lines :
> Document AK7345 bindings.
> Compared to AK7375, it has only 9 bits position values (instead of 12),
> 20 ms power-up delay (instead of 10), and no known standby register setti=
ng.

Yah, that is the exact sort of information that is good to have, thanks.

--GFXk9WplJkFov3Ct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJvygAKCRB4tDGHoIJi
0mr0AP9ua78lXwIJm7NKVVKFjyBrUIedY6NKHe0VwDp4fJi5HAD/V0b1ZNpChS1t
c/HKZTeESkrwatJfu376oALOkuZHbg8=
=9zv9
-----END PGP SIGNATURE-----

--GFXk9WplJkFov3Ct--
