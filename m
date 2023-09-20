Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0517A72A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjITGNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjITGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:13:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B409D;
        Tue, 19 Sep 2023 23:13:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81A7C433C7;
        Wed, 20 Sep 2023 06:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695190418;
        bh=sCA6t4YXZyc5rNhGUjMitz7bxr3cqh7547VPQO5z/NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAlxtLY7YcvLrOxMsiqbf4Le3cggE28w/GyZvSzTDZ1LWDwulDeA7PXnKNpr818wD
         Oh+RcbcyXLMQ1tgsLYKsmcnCjgqn7nw17NhnFRG2sf6fZqAWsTyVntPFQNJ1gQznQl
         Z/8P+WUcfjIsCbf2DDTDTZgaL9Z/nof0KsFVEZnR+YebobrMgn1ZjbdqcWqlJZ7mvp
         n4I8Ng33kgHK/NeDt1jY1mHRFccpKgGmT4P8ig310BOcLXlEFgXlrd/9zmXznCUfrR
         EIIkSZeDvR3Tk/vs8xkZq3VqsfPYYM6XXCEVWowAgfrsI6GzCgTFn4udr6WvmV5moq
         kPNKybovu1lEw==
Date:   Wed, 20 Sep 2023 08:13:35 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, neil.armstrong@linaro.org,
        linux-amlogic@lists.infradead.org, p.zabel@pengutronix.de,
        linux-mediatek@lists.infradead.org, heiko@sntech.de,
        jani.nikula@linux.intel.com, intel-gfx@lists.freedesktop.org,
        alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        airlied@redhat.com, daniel@ffwll.ch, michel.daenzer@mailbox.org,
        daniel@fooishbar.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drm/ci: add entries for xfail files
Message-ID: <56iam34xkp4gnffi7cdqkzn33nqkb53ttttersctoa7b2rvvpn@ukaj2ceo4f2y>
References: <20230919182249.153499-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="snkfr47lvwx67rio"
Content-Disposition: inline
In-Reply-To: <20230919182249.153499-1-helen.koike@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--snkfr47lvwx67rio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 19, 2023 at 03:22:49PM -0300, Helen Koike wrote:
> DRM CI keeps track of which tests are failing, flaking or being skipped
> by the ci in the expectations files. Add entries for those files to the
> corresponding driver maintainer, so they can be notified when they
> change.
>=20
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

Thanks for sending this

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--snkfr47lvwx67rio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQqNjwAKCRDj7w1vZxhR
xXAYAP9Bj69+O1sa6mIVvufb7pxaegBC7CPhLcZvoTbWo7giVwEA6DxfglNf7WDj
GvhfiMjoMJRWAeagnk3gM2FAxR30aA0=
=48R+
-----END PGP SIGNATURE-----

--snkfr47lvwx67rio--
