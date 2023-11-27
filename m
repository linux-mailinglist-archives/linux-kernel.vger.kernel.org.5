Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB8E7F9C64
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjK0JKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjK0JKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:10:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280812D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:10:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2178FC433C9;
        Mon, 27 Nov 2023 09:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701076239;
        bh=Ps+Fa/dulVUd1PDAHALRfrfI3qw3k68n8ZSw/yf2lAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2iXI9YoFZ19dm4dhfILyvtYzs8ky9ggc84g/7AIdC9fNR4yv1YB5h7FDVPlgyvy8
         zgKol8BCqqiLfVBkJEJCAQcOVCgSdusaqMHjXbJ9t7an5MPLbWcRpM1ZrJxScYtA55
         k+o9CdZOuSQMrNLT5ksGcomOa9h2S3WvfVOdSlBO1A3T5WrCwj7NBKXNT4VqMU1Pej
         pYbV7C51SNvO5k6Nn3KF0oDGPAd8fPjXSG606L7Y+8k4QFTseEQboFCMThgdTINi09
         hjwS8+c6R0UOCuuKv0O1XGunT+m/iIB7I1Lbmm6CFB3oSB50WTQTMdJBdJo0vzxyr8
         /+qCaV560su+Q==
Date:   Mon, 27 Nov 2023 10:10:36 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, heiko@sntech.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Rockchip inno_hdmi update
Message-ID: <ehbpa5qzq5aednqerhlb4xi652dd6rxslsjrurkkt5eruxssvv@2dcl2765fjix>
References: <2601b669-c570-f39d-8cf9-bff56c939912@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w7qeozagnw3krs5v"
Content-Disposition: inline
In-Reply-To: <2601b669-c570-f39d-8cf9-bff56c939912@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7qeozagnw3krs5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johan,

On Sun, Nov 26, 2023 at 11:55:03AM +0100, Johan Jonker wrote:
> Combined update for the Rockchip inno_hdmi driver in a
> somewhat similar way to what is proposed for the
> "Create HDMI Connector infrastructure patch serie".
> Keeping the inno_hdmi and rk3066_hdmi driver functions
> comparable makes maintanance easier.

It's not clear to me what your intent is exactly, these are my exact
patches that you just sent again?

Maxime

--w7qeozagnw3krs5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWRdDAAKCRDj7w1vZxhR
xVKcAQClmlIR0bc7c19KWzUwSe/UDRDPcWIBHtu8Uoaf+2t79gD+IDyn3OKNIt6D
P7XtYjRgJXnPgNggszjP7+iEpGgicwI=
=sHaM
-----END PGP SIGNATURE-----

--w7qeozagnw3krs5v--
