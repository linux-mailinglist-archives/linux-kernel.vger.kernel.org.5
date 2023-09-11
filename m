Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83D79A0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjIKAbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjIKAbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:31:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7A212C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 17:31:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146FEC433C7;
        Mon, 11 Sep 2023 00:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694392278;
        bh=NeTrmT/Cysdab45bAar5rJ686Czxxw+Y2sLdrDC6zG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAIaNTmfasbW237foCPQhuArW5/nEMwzmBk7fWSNCmY2uQ7sLFlbSW5gHcCgDtEKp
         VmPTTfZKM+QqQ11kTWktZWwele7UeHURn2K4mKroIKaWffGs7f8EZTXs0DZ+wJrdJz
         XAz2/wGe65URPZuNSrlJ3BYijhrLKXUXA9EYVakbIKayuFutuPr/9MOW7WvnUMe/Eu
         J8QFv+rcdO/7HxkTf4y7lk9dk/pdCBfVtGnun9QA5NtiDd6/5noNCyI7UWn99rabYc
         Np1T48xOQVAmnuWkURSz08PmmjAF8JA6G0ajkKyas1eVSa7e3Zv4fLBsXt6ked5qGa
         xt4UKDJKQm7ig==
Date:   Mon, 11 Sep 2023 01:31:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] regulator: mp886x: Make similar OF and ID table
Message-ID: <ZP5f0kj3uHPkd7Il@finisterre.sirena.org.uk>
References: <20230903155125.73638-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SP4dUtKe4M+d5IVu"
Content-Disposition: inline
In-Reply-To: <20230903155125.73638-1-biju.das.jz@bp.renesas.com>
X-Cookie: Adapt.  Enjoy.  Survive.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SP4dUtKe4M+d5IVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 03, 2023 at 04:51:25PM +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match using
> i2c_match_data(). Currently it works only for OF match tables as the
> driver_data is wrong for ID match.

This doesn't apply against current code, please check and resend.

--SP4dUtKe4M+d5IVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT+X9EACgkQJNaLcl1U
h9BSXQf/Yn0VR/a40wOZQ6HVbW9pV+p7U76FJISB5nyYkOeGqOdvtYM5a6cKDNCw
Y4vjsQkZH8dC37qUXEhVIHGOVHgDVMoaA8O49cLSIi3vlQU348AJYxUOuypeFIRt
CrUqkxQyoiU+4wLMACk+qLwa1DjwjyjTmWwody/o/FYCzMveqGqUWFK0KmVOaTy/
UFb77ZdFCT7IEPYhth8irDjZDsHDZMJVIzswDx92Z6AOKV3t8WEIH8shHVla4sSd
3OoFAs04BkjAgrWN5ScSSL3fbv9OwIIgMggp1ntK5VyIGsuiPyuqcpjrj8cd9+Qo
MyDjcC3wQiSa+BOKYlH97czNFlwsMg==
=jmZX
-----END PGP SIGNATURE-----

--SP4dUtKe4M+d5IVu--
