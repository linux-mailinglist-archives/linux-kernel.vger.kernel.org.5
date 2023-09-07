Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCDF797A7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjIGRlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245390AbjIGRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D325FCA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:40:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6294C32781;
        Thu,  7 Sep 2023 11:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694087729;
        bh=NNDQ95Ik3jD4bkeMVg3/UZlcD+PTe1xiy5xkc23z0go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkpixnVSJMcF/lo+Pr5YTlOCC9vxzC32TLu2mThIfQOy7DH78iHXRUNPqFZsK0DAH
         u/LVrZkIK1Pg94iwDe/UmSV4Dpep2asDJmtNqfb7+/kluo7z6kt8Rmbc5BLoCkYsNe
         5uqsgAtCgS2u/FrBSP1+N7v0EDG+Uk9aW7lCBpz0s9LTPv0gbXZogb/FG6d4xG7W/I
         ZYbFOggJes4q3Twn08HWw88B8RKwFcVKPNtDv4HMCz8xXVOYjG/onbRtH6JEVaZxCU
         AVtqZ3ll3OhNnZeF3Z8Ix0h14wm01JEwBv+9V4x7gdAieLGBq4IuPxH/JlswS8FWFj
         oEqtM+lDgt4MQ==
Date:   Thu, 7 Sep 2023 12:55:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] regulator fixes for v6.5-rc7
Message-ID: <3f98a18b-fba9-48bb-8f27-0b576a960e84@sirena.org.uk>
References: <20230907115238.5BD9CC32780@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ivMzcpejHd9w5Hsg"
Content-Disposition: inline
In-Reply-To: <20230907115238.5BD9CC32780@smtp.kernel.org>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ivMzcpejHd9w5Hsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 12:52:26PM +0100, Mark Brown wrote:
> The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b4=
21:
>=20
>   Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)
>=20
> are available in the Git repository at:

Sorry for the noise here, my scripting got confused about what it had
already sent out.

--ivMzcpejHd9w5Hsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT5uiwACgkQJNaLcl1U
h9D+Awf9EWuKkqk9aqCttPGaDyDW81b2AC9VlpAjHBtnL4s/BO+9IuUqAJhkiF6P
B2FkqQOGiaFTzw/OMZpu1TMWrWo2BOYBK0hkmVrQ+tj7Sehioigm+6ZgarURc1sh
D5hFEv86B7DQLSl+38Mrx/EBkmunBbHLyj9Okkqi+7j7frZD86960z0WrSQhJ+QO
SXf+zkpTE+im+++ZCXV0U4QpExB34o0owVj+uTVNAOhzm2wbMAqh3i44qDaTSnbd
WEICZWXZv0EaIxqzJyJtJFP1ZjDyjcWUn1CHCCDO8KuPG9vj0qOdHOz3M4hDXL/S
0BxXmbONKCc2c7DB016RK1lTtfRb8w==
=RQz1
-----END PGP SIGNATURE-----

--ivMzcpejHd9w5Hsg--
