Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD6B7C8704
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjJMNjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjJMNji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:39:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA97B95;
        Fri, 13 Oct 2023 06:39:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B98C433C8;
        Fri, 13 Oct 2023 13:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697204376;
        bh=Daw0oV8avVvs3EF+zKAfgZ1+IJkL9210R2usowvEsyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecS4BIyRUjVKqpOSwmbEMFgD2mkLOzob8z36DLk5NsjL5pWRpaaju8vuB9gNGo6/7
         INLiteok8petspSUsj39GF9S+2co8eF0YKXXl7EB7A5b5GBCxf3fTgbxMOUB3dn15Y
         TY0i9gTt+bG41cpVQP3Dgi0zNFwa3uJBa++LH96mWvHpSn4minfwop6nMhtvOCXCc0
         2px4dX0/TIek+xAxyTwYjsfWVBYnRdgWOR4TZ75Optn1KfAcMBBoSiNOlzQassi019
         vuw1EJuhmlIA9YKgpXDKKCcb8orSY35b3hbRQH9hu3myUUj9qGOUuKnYK0LW5acBri
         fn/2gS7YyC5aQ==
Date:   Fri, 13 Oct 2023 14:39:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v6 05/11] ASoC: fsl_easrc: register m2m platform
 device
Message-ID: <ZSlH8BW8yr+WJFK0@finisterre.sirena.org.uk>
References: <1697185865-27528-1-git-send-email-shengjiu.wang@nxp.com>
 <1697185865-27528-6-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UKDVDCqpnMS86zNZ"
Content-Disposition: inline
In-Reply-To: <1697185865-27528-6-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UKDVDCqpnMS86zNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2023 at 04:30:59PM +0800, Shengjiu Wang wrote:
> Register m2m platform device,that user can
> use M2M feature.

Acked-by: Mark Brown <broonie@kernel.org>

--UKDVDCqpnMS86zNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUpSI4ACgkQJNaLcl1U
h9D3Mgf+PDdKi3n9C0kflM9CvsKjX5j3rfiOo6oGsIA4yaHNFonDmjLM+iJAGM0x
QTPAK5TwHUOu2fZ9wQHo7FKNTV7OPH5h8VuU+wQjWc9Ftg4kgmqbAEfFsw/EEjaz
k4J8zpD1c+B4iF3NNAKaJu+6HIkx6bcffkDCaUqtFEjewvc7mjNZNBnsL+rilyhy
z7/tS6VfFD5Skjl5xG1x+Kh9XO0ziRJSfUNNEGzRFFzK73GngtE0Reh8qN4aNNXg
1BhBUoDRS0Qczjt/Cb9YXTaicRJBvHEMTLz/6vl/sMlUhweBrLXWuX0rwDwR6MT5
2tMlxCViUMgG/ug9JJOB6acfEQVwBw==
=3R9J
-----END PGP SIGNATURE-----

--UKDVDCqpnMS86zNZ--
