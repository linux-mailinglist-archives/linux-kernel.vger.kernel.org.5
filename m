Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB647AEFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjIZPcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjIZPcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:32:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF73116
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:31:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72146C433C7;
        Tue, 26 Sep 2023 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695742316;
        bh=2B/eHFMRGAjht4C04glxjFpVT39DdqH9nZ5YcLTs3dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+PNWidAF1v4isxra4Q42rHBqwlOaWm7Li1l8LpSyPTi+jToxhmjjhq+zaP+OFnvu
         5KEJYJxYY2K3TGKWEYv8ICameBpggUWIW4xUuJ3Nur6L4SpdRguHrrM9IRWwYHU+mo
         TUVOdtBovL+L/trObJxY0E4bLCVgStzKAq8n+Eau0n/f/afLv4cFFwAHvW36a4FRNv
         4UjKmGbhxpPVY9Z90jWn0tK1Iz1Tb+7caoAC0STJT4P77YNM33DubVzFHA41BdPJPi
         lCKNH9kC3gs9ZqnHvMV8U1/44433AzRTfM7P6G/3YlcJEtKrXjSlqXC8ftXqCP31x9
         60iBC9bWAsP7g==
Date:   Tue, 26 Sep 2023 17:31:54 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v3] regulator: max20086: Drop ID table
Message-ID: <ZRL5ahsXZ5u3brDB@finisterre.sirena.org.uk>
References: <20230910065444.25906-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hrbfzMtbHMG4kH9y"
Content-Disposition: inline
In-Reply-To: <20230910065444.25906-1-biju.das.jz@bp.renesas.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hrbfzMtbHMG4kH9y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 10, 2023 at 07:54:44AM +0100, Biju Das wrote:
> The driver has an ID table, but it uses the wrong API for retrieving match
> data and that will lead to a crash, if it is instantiated by user space or
> using ID. From this, there is no user for the ID table and let's drop it
> from the driver as it saves some memory.

This doesn't apply against current code, please check and resend.

--hrbfzMtbHMG4kH9y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUS+WkACgkQJNaLcl1U
h9AKOwf/ePEO2meMu6LUByg2jws3gjx/Hvb4VUxQcKQuiqYOD2yi7BCQzFlEY31l
26naU8FTVPc6xjmmp+t5nhgrqxqzdfz+hG4Ee6wxsBKmZLBpPGulXTJrZWxuJmN8
VOhU01HjXHPklkI6a2zKgdIKH+8EYWtC27IwQ6iTGpQE9aXdkrO2KcfZdIhVQ5Gy
h+/PRrJLvnDhOtpF4DqmS5y8XoMjZVnjaEFCwQRrjgMkO/LY6Avue3lccgvVuJXb
eF2fztnXzQpQBjrmPg+PrtQfAMxRL+7oCWACDQ/t6qcvZvp4tM76c5oQKO9KM/oC
sgvPPPUjBfr50vcr3rWXmR+/Pd+YoA==
=C5VS
-----END PGP SIGNATURE-----

--hrbfzMtbHMG4kH9y--
