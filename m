Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ADF7D9EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjJ0RSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjJ0RSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:18:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EDA10C3;
        Fri, 27 Oct 2023 10:16:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6304CC433C7;
        Fri, 27 Oct 2023 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698426997;
        bh=g9VyFrxwnXi5OwonEcH8565ahcBYT3MRd4YGIKPuL6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0fp4Y9FOgUmgbFGxV18bnL9dLQH/3QhMSKbuT+U2iATh6r8HMwTNmElyEtcBMSGY
         Iu3Lv4kW3FjogxZYppfsua0IoA7aim2yTf9v7evbKXd0mNtBLC7fyeE5cpiJNVcUpr
         VY5BON7u1E8F98piRVpuuSv13aIiwWZ64T+6p6z1v0uNLr6+Y7rDull3NwqZ8Oc2ZT
         CbELpV3xIg5fbMqHI33eeVRs265YPbW0OgG7on2rGUaIWUEXsLHvASX7EhHy97dCQY
         HrEoT6bwFqUHxRKGBfmik9oKu3O4hZSftH1ChUKDCoLnm3nsEClr0+h6CXJpw/X3jw
         IIZKLafwMheZA==
Date:   Fri, 27 Oct 2023 18:16:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Harald Mommer <Harald.Mommer@opensynergy.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harald.Mommer@gmail.com, quic_ztu@quicinc.com,
        Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH] Virtio SPI Linux driver.
Message-ID: <ZTvwcwiVr9DcsP9n@finisterre.sirena.org.uk>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3I5AJnp46m5zMF9V"
Content-Disposition: inline
In-Reply-To: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3I5AJnp46m5zMF9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 06:10:13PM +0200, Harald Mommer wrote:
> This is a virtio SPI Linux driver which is intended to be compliant with
> the proposed virtio SPI draft specification V4.

You've cross posted this to the virio-dev list which does not allow
posting by non-subscribers...

--3I5AJnp46m5zMF9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU78GIACgkQJNaLcl1U
h9Bv/Qf/b7+AX4/zxnU3M0hZCPSSEu5TrHr0EFvg3sje13+ne9qjKGTciGnvaipO
yq0Y6J4D2F6EmTCu2PJA+iWgYCYvZgRNrbNIMdP81a9GrRx3AYAfhYZE0u1iSmVu
YjmegsB7Z4TLMyDmliNoOroJ1epUd0LK6t+FHa2WlgFI+xo9BpvzejGAVCgSZDH0
GvFk9FkZWI1RxXbMZYXeHU3k41gPxJZ0qHwWztiHdR7KSLovR/EjIp0hwNc3RZrW
hO/dlhBl3pdhBGy0Z1In+za/NFzcj/QPot6xWiQ79sDxa3uKC4FgDovVNj5Sg7tY
nRFdVoSjeL0DKQO5x5xb7vKpGno3GA==
=TVYk
-----END PGP SIGNATURE-----

--3I5AJnp46m5zMF9V--
