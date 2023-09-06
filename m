Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBDA793B72
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbjIFLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbjIFLfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:35:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264E995;
        Wed,  6 Sep 2023 04:35:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638CEC433C7;
        Wed,  6 Sep 2023 11:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694000140;
        bh=R8cX6KBAOR46kqNyWM5gSlQFjpzLIdHBLmnmWEd82Cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpiWsu7HogmInxaMLnRjvlJgp1n/vNaB9C7CnsCWxJs5ThTRQ/IM3708Vht7shtCK
         jOU6ITZ6+Ml9yRqXds4l8H0hFoEaICnZMi9hm86XtUyOGWdCqC1Zngmbw52bqHk3Vi
         ZPSBhM7R1AcYL4DI0VFHCC6bjD6tLo+jo6tXubr55pMtq9TgLk2W5yFbcgijor0lFq
         2Bk5/psx8VBPsEu7arDV0JW3bGGby1ew4lNS9upVJCQZF+HZiW4peKp1HI7EG11ZUX
         LVwSKUlFQQU+78OYbsWkuunBTQhM42XaaIWpyG7YExvFzAHyADVolEMN/xb8jWgC9G
         2ZBlnPJPXSpUQ==
Date:   Wed, 6 Sep 2023 13:35:37 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, frank.binns@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        corbet@lwn.net, christian.koenig@amd.com, linus.walleij@linaro.org,
        matt.coster@imgtec.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        faith.ekstrand@collabora.com, afd@ti.com, hns@goldelico.com,
        matthew.brost@intel.com, luben.tuikov@amd.com, dakr@redhat.com
Subject: Re: [PATCH v6 02/20] drm/gpuva_mgr: Helper to get range of unmap
 from a remap op.
Message-ID: <7z6t4sudgits372e26f37gydfxxonsduiajurr7ztgvmh3crch@mbeb66xwin5s>
References: <20230906095542.3280699-1-sarah.walker@imgtec.com>
 <20230906095542.3280699-3-sarah.walker@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kgq6kck2vs7tqvol"
Content-Disposition: inline
In-Reply-To: <20230906095542.3280699-3-sarah.walker@imgtec.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kgq6kck2vs7tqvol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sarah,

On Wed, Sep 06, 2023 at 10:55:24AM +0100, Sarah Walker wrote:
> From: Donald Robson <donald.robson@imgtec.com>
>=20
> Signed-off-by: Donald Robson <donald.robson@imgtec.com>

Sorry, this applied to your previous versions too but I only caught it
right now. When you submit a patch on someone else's behalf, you need to
add your Signed-off-by. That's also true when you're the committer of a
patch you didn't write.

This one, and patch 1, are affected.

Also, generally speaking, it's a good to write a commit log for a patch
to at least provide some context on what you want to achieve.

Maxime

--kgq6kck2vs7tqvol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZPhkCQAKCRDj7w1vZxhR
xXXKAP9f8E7gk6BdQrqtOlP19X5C2PDO24NNYUt53ReNjMx1IQEAvg2g5mAfgBOv
7sh6wvmMaiVlRQbQiibMAh1kOMIXYAQ=
=qF9D
-----END PGP SIGNATURE-----

--kgq6kck2vs7tqvol--
